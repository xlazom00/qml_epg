
import Test 1.0

import QtQuick 2.0


Rectangle {
    id : root
    width: 1280
    height: 720

//    Image {
//        id: name
//        source: "file:///C:/QtWork/qml_epg/build-UbuntuTV-Desktop_Qt_5_2_0_MinGW_32bit-Debug/epgdata/channels/parliament/logo.png"
//    }

    EPG {
        focus: true
       width: root.width
       height: root.height
    }
}
