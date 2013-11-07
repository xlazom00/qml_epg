#include <QtGui/QGuiApplication>
#include <QQuickView>
#include <QQuickItem>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QQmlContext>

#include "qtquick2applicationviewer.h"
#include "qlsqltablemodel.h"
#include "tvstream.h"


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

void GenerateStreamModels(QQmlEngine * qmlEngine, QSqlDatabase & db,  QList< QObject*> & models)
{
    QLSqlTableModel * streamModel = new QLSqlTableModel(NULL, NULL, db);
    streamModel->setTable("stream");
    streamModel->generateRoleNames();
    streamModel->select();
    int streamCount = streamModel->rowCount();

    for(int rowIndex=0; rowIndex< streamCount; ++rowIndex)
    {
        QVariant data = streamModel->data(streamModel->index(rowIndex,0));
        QVariant name = streamModel->data(streamModel->index(rowIndex,1));
//        qDebug() << data.toInt();
        QLSqlTableModel * eventModel = new QLSqlTableModel(NULL, qmlEngine, db );
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

    QtQuick2ApplicationViewer viewer;

    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("data\\app.sqlite");
//    db.setDatabaseName("app.sqlite");
    bool ret = db.open();
    qDebug() << "db open" << ret;

    QList<QObject*> streamList;
    GenerateStreamModels(viewer.engine(), db, streamList);
    qDebug() << "itemcount:" << streamList.count();

    viewer.rootContext()->setContextProperty("epgData", QVariant::fromValue(streamList));


    viewer.setMainQmlFile(QStringLiteral("qml/tv_003/main.qml"));

//    QVariant val = viewer.rootContext()->contextProperty("epgModel");
//    qDebug() << "some shit" << val;


//    viewer.setCon



    viewer.showExpanded();

    ret = app.exec();

    db.close();

    return ret;
}
