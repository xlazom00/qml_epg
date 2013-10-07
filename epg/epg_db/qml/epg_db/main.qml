import QtQuick 2.1
import QtQuick.Controls 1.0
import com.mdragon.epg 1.0

Rectangle {
    width: 360
    height: 360


    Button {
        id: button1
        x: 14
        y: 8
        text: "Button"
        onClicked: {
            epgLoader.loadEpgFile();
        }

    }

    EpgLoader {
        id: epgLoader


    }
}
