#include <QtGui/QGuiApplication>
#include <QSqlDatabase>
#include <QQmlContext>
#include <QDebug>
#include <QSqlQuery>
#include <QSqlError>
#include "qtquick2applicationviewer.h"

#include "qlsqltablemodel.h"


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

void GenerateStreamModels(QSqlDatabase & db,  QList<QObject*> & models)
{
    QLSqlTableModel * model = new QLSqlTableModel(NULL, db);
    model->setTable("stream");
    model->generateRoleNames();
    model->select();
    int streamCount = model->rowCount();

    for(int rowIndex=0; rowIndex< streamCount; ++rowIndex)
    {
        QVariant data = model->data(model->index(rowIndex,0));
        qDebug() << data.toInt();
        QLSqlTableModel * model = new QLSqlTableModel(NULL, db);
        model->setTable("event");
        model->generateRoleNames();
        model->setFilter("streamid=" + data.toInt());
        model->select();

        models.append(model);
    }
    delete model;
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("c:\\QtWork\\qml_epg\\tv_002\\data\\app.sqlite");
    bool ret = db.open();
    qDebug() << "db open" << ret;
//    CreateTables(db);
//    db.close();

    QList<QObject*> streamList;
    GenerateStreamModels(db, streamList);

//    QLSqlTableModel * model = new QLSqlTableModel(NULL, db);
//    model->setTable("event");
//    model->generateRoleNames();
//    model->select();



    QtQuick2ApplicationViewer viewer;
    QQmlContext *ctxt = viewer.rootContext();
//    ctxt->setContextProperty("myModel", model);
    ctxt->setContextProperty("myModel", QVariant::fromValue(streamList));
    viewer.setMainQmlFile(QStringLiteral("qml/tv_002/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
