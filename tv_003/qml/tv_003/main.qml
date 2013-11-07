import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

import "utils.js" as Utils

Item {
    id : root
    width: 1280
    height: 720

//    property list<QtObject> epgModel : epgData;
    property variant epgModel : epgData;
//    : someData

//    property variant epgModel;

//    ListModel {
//        id: epgModel
//    }

//    ListView {
//        id : aa
////        model: epgModel

//        Component.onCompleted: {
////            Utils.logThis("model:" + aa.model.length);
//        }
//    }

    Column {
        anchors.fill: parent
        TextField {
            id : startTime
            text : "540000"
        }

        Button {
            id : changeTime;
            text : "change time"
            onClicked: {
//                epg.startOfTime = startTime.text;
                Utils.logThis("model:" + epgModel);
                Utils.logThis("model:" + epgModel.length);
            }
        }

        EPG {
            width: 100
            height: 50
//            anchors.left: parent.left
//            anchors.right: parent.right
            id : epg
            channelModel : epgModel[0].streammodel
        }
    }




}
