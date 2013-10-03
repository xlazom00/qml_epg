#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/tv_001/main.qml"));
    viewer.showExpanded();
//    viewer.showFullScreen();

    return app.exec();
}
