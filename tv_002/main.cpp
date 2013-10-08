#include <QtGui/QGuiApplication>
#include <QSqlDatabase>
#include "qtquick2applicationviewer.h"

//bool :openDB(QSqlDatabase & db)
//{
//    db = QSqlDatabase::addDatabase("QSQLITE");
//    db.setDatabaseName("app.sqlite");
//    // Open databasee
//    return db.open();
//}

//void closeDB(QSqlDatabase & db)
//{
//    db.close();
//}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("app.sqlite");


//    SqlQueryModel *model1 = new SqlQueryModel(0);
//    model1->setQuery("SELECT * FROM table WHERE column='value'");
//    SqlQueryModel *model2 = new SqlQueryModel(0);
//    model2->setQuery("SELECT * FROM anothertable WHERE anothercolumn='value'");

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/tv_002/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
