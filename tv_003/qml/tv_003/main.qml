import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

import "utils.js" as Utils

Item {
    id : root
    width: 1280
    height: 720

    property int currentStartIndex : 60
    property int currentEndIndex : 60

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
            text : "add content befour"
            onClicked: {
                if(currentStartIndex > 0){
                    epg.loadData(currentStartIndex-10, 10)
                    currentStartIndex-=10;
                }
            }
        }
        Button {
            id : changeTime2;
            text : "add content after"
            onClicked: {
                epg.loadData(currentEndIndex, 10)
                currentEndIndex+=10;
            }
        }

//        Rectangle{
//            color: "yellow"
//            width: nieco.width
//            height: nieco.height
////            anchors.fill: nieco
//            Flickable {
//                id : nieco
//                focus: true
//                clip: true
//                width : 150
//                height: 400
//                contentWidth: content0.x + content0.width + content1.width
//                contentHeight: content0.height
//                contentX: 50
//                leftMargin: -50
////                rightMargin: -50

//                Rectangle {
//                    x: 50
//                    id : content0
//                    width : 100
//                    height: 200
//                    color: "Red"
//                    border.color: "Blue"
//                    border.width: 5
//                }
//                Rectangle {
//                    x: content0.x + content0.width
//                    id : content1
//                    width : 150
//                    height: 200
//                    color: "Green"
//                    border.color: "Blue"
//                    border.width: 5
//                }
//            }
//        }



        EPG {
            focus: true
            width: parent.width
            height: 100
//            anchors.left: parent.left
//            anchors.right: parent.right
            id : epg
            channelModel : epgModel[0].streammodel
        }
    }




}
