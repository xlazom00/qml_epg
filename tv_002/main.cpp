#include <QtGui/QGuiApplication>
#include <QSqlDatabase>
#include <QQmlContext>
#include <QDebug>
#include <QSqlQuery>
#include <QSqlError>
#include <QtQuick>

//#include <QDeclarativeComponent>

#include "qtquick2applicationviewer.h"

#include "qlsqltablemodel.h"
#include "tvstream.h"
#include "autobus.h"


void CreateTables(QSqlDatabase & db)
{
    QSqlQuery query(db);
    bool ok;
    ok = query.exec("create table stream (id INTEGER primary key, "
               "name TEXT)");
    qDebug() << ok;
    ok = query.exec("create table event (id INTEGER primary key, "
               "startime int, "
               "duration int, "
               "title TEXT, "
               "shorttext TEXT, "
               "description TEXT, "
               "streamid INTEGER, "
               "FOREIGN KEY(streamid) REFERENCES stream(id))"
               );
    qDebug() << ok;
    if(!ok)
    {
        qDebug() << query.lastError().text();
    }

}

void GenerateStreamModels(QSqlDatabase & db,  QList< QObject*> & models)
//void GenerateStreamModels(QSqlDatabase & db,  QList< Autobus *> & models)
{
    QLSqlTableModel * streamModel = new QLSqlTableModel(NULL, db);
    streamModel->setTable("stream");
    streamModel->generateRoleNames();
    streamModel->select();
    int streamCount = streamModel->rowCount();

    for(int rowIndex=0; rowIndex< streamCount; ++rowIndex)
    {
        QVariant data = streamModel->data(streamModel->index(rowIndex,0));
        QVariant name = streamModel->data(streamModel->index(rowIndex,1));
//        qDebug() << data.toInt();
        QLSqlTableModel * eventModel = new QLSqlTableModel(NULL, db );
        eventModel->setTable("event");
        eventModel->generateRoleNames();
        eventModel->setFilter(QString("streamid=%1").arg(data.toInt()));
        eventModel->select();

//        qDebug() << "name:" << name.toString() << ":" << eventModel->columnCount();
//        QString filter = QString("streamid=%1").arg(data.toInt());
//        qDebug() << "name:" << name.toString() << ":" << filter;

//        models.append(new DataObject());
//        models.append( new DataObject(name.toString()));
        models.append( new TvStream( name.toString(), eventModel ) );
    }
    delete streamModel;
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<QLSqlTableModel>();

    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
//    db.setDatabaseName("app.sqlite");
    db.setDatabaseName("c:\\QtWork\\qml_epg\\tv_002\\data\\app.sqlite");
    bool ret = db.open();
    qDebug() << "db open" << ret;

//    CreateTables(db);
//    db.close();

    QList<QObject*> streamList;
    GenerateStreamModels(db, streamList);
    qDebug() << "itemcount:" << streamList.count();

//    QLSqlTableModel * model = new QLSqlTableModel(NULL, db);
//    model->setTable("event");
//    model->generateRoleNames();
//    model->select();



    QtQuick2ApplicationViewer viewer;
    QQmlContext *ctxt = viewer.rootContext();
//    ctxt->setContextProperty("myModel", QVariant::fromValue(model));
    ctxt->setContextProperty("myModel", QVariant::fromValue(streamList));
    viewer.setMainQmlFile(QStringLiteral("qml/tv_002/main.qml"));
    viewer.showExpanded();
//    viewer.showFullScreen();

    return app.exec();
}
