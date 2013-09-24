import QtQuick 2.0

Item {
    id: root
    property string now : Qt.formatTime(new Date(), "hh:mm:ss");
    property int timerFontSize : 24

    Text {
        anchors.centerIn: parent
        text: root.now
        font.pointSize: timerFontSize
        font.bold: true
        color: "white"
    }

    Timer {
        id: clockUpdater
        interval: 1000 // update clock every second
        running: true
        repeat: true
        onTriggered: {
            root.now = Qt.formatTime(new Date(), "hh:mm:ss");
        }
    }
}
