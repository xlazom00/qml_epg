#include <QtGui/QGuiApplication>
#include <QQmlComponent>
#include <QQmlEngine>
#include "qtquick2applicationviewer.h"

#include "epgloader.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<EpgLoader>("com.mdragon.epg", 1, 0, "EpgLoader");

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/epg_db/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
