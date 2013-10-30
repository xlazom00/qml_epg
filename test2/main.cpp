#include <QCoreApplication>
#include <QDeclarativeEngine>
#include <QDeclarativeComponent>
#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include "person.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

        qmlRegisterType<Person>("People", 1,0, "Person");

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/test2/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
