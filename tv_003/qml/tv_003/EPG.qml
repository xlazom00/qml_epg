import QtQuick 2.0

import "utils.js" as Utils

Flickable {
    id : area
    clip : true;

//    property real startOfTime : 1380996000
    property real startOfDataTime : 1111111111
    property real endOfDataTime : 0

//    property real endOfTime : area.contentX + area.width

    property variant channelModel;

    ListModel {
        id: broadcasts
    }

//    flickableDirection: Flickable.HorizontalFlick
//    boundsBehavior: Flickable.DragOverBounds

    contentWidth: 100;
    contentHeight: 100;
    contentX: -1;
    leftMargin: 49800

//    contentWidth: hourSize * (area.endOfTimeline - area.startOfTimeline) / Utils.MS_PER_HOUR
//    contentHeight: channels.count * channelHeight
//    Row{
//        Item {
//            width:
//        }
//    }


    function loadData( startIndex, count){
        for(var i=startIndex; i < startIndex + count; ++i){
            Utils.logThis("-------------------------------------------------------------------------------");
            Utils.logThis("-------------------------------------------------------------------------------");
            Utils.logThis(" " + i);
            var channelEvent = channelModel.get(i);


            Utils.logThis(channelEvent.title + " " + channelEvent.startime + " dur:" + channelEvent.duration);

                        var event = { 'title' : channelEvent.title,
                            'starttime' : Utils.computeTime(channelEvent.startime),
                            'duration' : Utils.computeDuration(channelEvent.duration) };

            broadcasts.append( event);
//            if(event.starttime < area.contentX){
//                area.contentX = event.starttime
//                Utils.logThis("area.contentX:" + area.contentX);
//            }

//            if((event.starttime + event.duration) > area.contentWidth) {
//                area.contentWidth = event.starttime + event.duration
//                Utils.logThis("area.contentWidth:" + area.contentWidth + " event.starttime:" + event.starttime + " event.duration:" + event.duration);
//            }

//            Utils.logThis("starttime:" + event.starttime);

            if(event.starttime + event.duration > area.endOfDataTime) {
                area.endOfDataTime = event.starttime + event.duration;
            }

            if(event.starttime < area.startOfDataTime) {
                area.startOfDataTime = event.starttime;
            }

        }

//        area.leftMargin = area.startOfDataTime;
//        area.contentWidth = area.contentWidth - area.leftMargin;

        Utils.logThis("-------------------------------------------------------------------------------");
        Utils.logThis("-------------------------------------------------------------------------------");

//        Utils.logThis(area.startOfDataTime);
//        Utils.logThis(area.contentWidth);
//        Utils.logThis(contentItem.childrenRect);
        area.leftMargin = -area.startOfDataTime;
        area.contentWidth = area.endOfDataTime;
        if(area.contentY < 0)
        {
            area.contentX = area.startOfDataTime;
        }
    }


//    onChannelModelChanged: {
//        Utils.logThis("channelModel:" + channelModel + " count:" + channelModel.rowCount());
////        Utils.logThis("modelIndex" + channelModel.modelIndex());
////        loadData(0,9);
//    }

//    onContentXChanged: {
//        Utils.logThis("onContentXChanged:" + area.contentX + " contentWidth:" + area.contentWidth + " width:"+ area.width);
//    }
////    onStartOfTimeChanged: {
////        Utils.logThis("onStartOfTimeChanged:" + startOfTime);
////    }

    onContentYChanged: {
        Utils.logThis("onContentYChanged:" + area.contentY);
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

//    Rectangle {
//        width : 50
//        height: 50
//        color: "red"
//    }

//    Row {
//        anchors.fill: parent
        Repeater {
            id : shower
            model: broadcasts;
            delegate:
                Rectangle {
                    x : model.starttime * 1.0
                    width: model.duration; height: 40
                    border.width: 1
                    color: "yellow"

                    Text {
                        text: model.title
                    }
                    Component.onCompleted: {
//                        Utils.logThis("starttime:" + model.starttime + " area.width:" + area.width + " " + area.height + " " + " area.contentWidth:" + area.contentWidth + " " + area.contentHeight);
                        Utils.logThis("starttime:" + model.starttime + " duration:" + model.duration);
//                        Utils.logThis(area.contentItem.childrenRect);
                    }
                }
            Component.onCompleted: {
                Utils.logThis("done");
//                area.originX = area.startOfDataTime;
//                area.contentItem.childrenRect.x =  area.startOfDataTime;
//                area.leftMargin = -area.startOfDataTime;
            }
        }
//    }
}
