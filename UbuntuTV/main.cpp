#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include "directorymodel.h"
////#include <QQmlEngine>
//#include <QCoreApplication>
////#include <QDeclarativeEngine>
////#include <QDeclarativeComponent>
#include "person.h"
#include "birthdayparty.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

//    qmlRegisterType<DirectoryModel>("People", 1,0, "DirectoryModel");

    qmlRegisterType<BirthdayParty>("People", 1,0, "BirthdayParty");
    qmlRegisterType<ShoeDescription>();
    qmlRegisterType<Person>();
    qmlRegisterType<Boy>("People", 1,0, "Boy");
    qmlRegisterType<Girl>("People", 1,0, "Girl");

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/UbuntuTV/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
