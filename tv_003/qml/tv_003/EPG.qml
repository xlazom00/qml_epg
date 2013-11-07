import QtQuick 2.0

import "utils.js" as Utils

Flickable {
    id : area

    property real startOfTime
//    property real endOfTime : area.contentX + area.width

    property variant channelModel;

    ListModel {
        id: broadcasts
    }

    contentWidth: area.width;
    contentHeight: area.height;
    contentX: startOfTime;

//    contentWidth: hourSize * (area.endOfTimeline - area.startOfTimeline) / Utils.MS_PER_HOUR
//    contentHeight: channels.count * channelHeight
//    Row{
//        Item {
//            width:
//        }
//    }



    onChannelModelChanged: {
        Utils.logThis("channelModel:" + channelModel + " count:" + channelModel.rowCount());
//        Utils.logThis("modelIndex" + channelModel.modelIndex());

        for(var i=0; i< 10; ++i){
            var channelEvent = channelModel.get(i);
            var event = { 'title' : channelEvent.title,
                'start' : channelEvent.starttime,
                'duration' : channelEvent.duration };

            Utils.logThis(channelEvent.title + " " + channelEvent.startime);

            broadcasts.append( event);

        }
    }

    onContentXChanged: {
        Utils.logThis("onContentXChanged:" + contentX);
    }
    onStartOfTimeChanged: {
        Utils.logThis("onStartOfTimeChanged:" + startOfTime);
    }

//    Row {
//        id: dataRepresenter
//        Repeater {
//            model: 3
//            Rectangle {
//                width: 100; height: 40
//                border.width: 1
//                color: "yellow"
//            }
//        }
//    }

//    Row {
//        anchors.fill: parent
        Repeater {
            model: broadcasts;
            delegate:
                Rectangle {
//                    x : model.start * 1.0
                    width: 100; height: 40
                    border.width: 1
                    color: "yellow"

                    Text {
                        text: model.title
                    }
                    Component.onCompleted: {
                        Utils.logThis("start:" + model.start);
                    }
                }
        }
//    }
}
