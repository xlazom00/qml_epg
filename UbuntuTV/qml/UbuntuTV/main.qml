
import Test 1.0

import QtQuick 2.0

import "../common/utils.js" as Utils

Rectangle {
    id : root
    width: 1280
    height: 720
    color: Utils.lightAubergine

    FpsItem {
        id:fps
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
////        enabled : true
//        Component.onCompleted: {
//            fps.toggle();
//        }
    }

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
