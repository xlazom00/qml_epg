import QtQuick 2.0

import "utils.js" as Utils

Flickable {
    id : area
    clip : true;

    property int startOfDataTimeInt
    property int endOfDataTimeInt

    property real startOfDataTime : -1
    property real endOfDataTime : -1

    property bool started : false

    property variant channelModel;

    flickableDirection : Flickable.HorizontalFlick

    onAtXEndChanged: {
        Utils.logThis("atXEnd:" + atXEnd);
        if(atXEnd && started) {
            loadNextDay();
        }
    }

    ListModel {
        id: broadcasts
    }

    Component.onCompleted: {
        // load data
        loadNextDay();
        started = true;
    }

    contentWidth: 100;
    contentHeight: area.height;
    contentX: -1;
    leftMargin: 0

//    contentWidth: hourSize * (area.endOfTimeline - area.startOfTimeline) / Utils.MS_PER_HOUR
//    contentHeight: channels.count * channelHeight

    function loadNextDay() {
        channelModel.setFrom(endOfDataTimeInt, Utils.ONEDAYSECONDS);
        loadData(0, channelModel.rowCount());
        endOfDataTimeInt  = endOfDataTimeInt + Utils.ONEDAYSECONDS;
    }

    function loadData( startIndex, count){
        channelModel.rowCount();
        var newEndOfDataTime = area.endOfDataTime;
        var newStartOfDataTime = area.startOfDataTime;
        for(var i=startIndex; i < (startIndex + count); ++i){
//            Utils.logThis("-------------------------------------------------------------------------------");
//            Utils.logThis("-------------------------------------------------------------------------------");
//            Utils.logThis(" " + i);
            var channelEvent = channelModel.get(i);


//            Utils.logThis(channelEvent.title + " " + channelEvent.startime + " dur:" + channelEvent.duration);

                        var event = { 'title' : channelEvent.title,
                            'startTime' : Utils.computeTime(channelEvent.startime),
                            'startTimeInt' : channelEvent.startime,
                            'duration' : Utils.computeDuration(channelEvent.duration),
                            'durationInt': channelEvent.duration};

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

            if((newEndOfDataTime < 0) || (event.startTime + event.duration > newEndOfDataTime)) {
                newEndOfDataTime = event.startTime + event.duration;
            }

            if((newStartOfDataTime < 0) || (event.startTime < newStartOfDataTime)) {
                newStartOfDataTime = event.startTime;
            }

        }

//        area.leftMargin = area.startOfDataTime;
//        area.contentWidth = area.contentWidth - area.leftMargin;

        Utils.logThis("-------------------------------------------------------------------------------");
        Utils.logThis("-------------------------------------------------------------------------------");

//        Utils.logThis(area.startOfDataTime);
//        Utils.logThis(area.contentWidth);
//        Utils.logThis(contentItem.childrenRect);
        area.startOfDataTime = newStartOfDataTime;
        area.endOfDataTime = newEndOfDataTime;

        area.leftMargin = -newStartOfDataTime;
        area.contentWidth = newEndOfDataTime;
        if(area.contentX < 0)
        {
            area.contentX = newStartOfDataTime;
        }
    }
        Repeater {
            id : shower
            model: broadcasts;
            delegate:
                Rectangle {
                    x : model.startTime * 1.0
                    width: model.duration; height: 40
                    border.width: 5
                    border.color: "green"
                    color: "yellow"

                    Text {
                        text: model.title +"\n"+ Qt.formatTime(channelModel.toDate(model.startTimeInt), "hh:mm:ss");
                    }
                    Component.onCompleted: {
//                        Utils.logThis("starttime:" + model.starttime + " area.width:" + area.width + " " + area.height + " " + " area.contentWidth:" + area.contentWidth + " " + area.contentHeight);
//                        Utils.logThis("starttime:" + model.startTime + " duration:" + model.duration);
//                        Utils.logThis(area.contentItem.childrenRect);
                    }
                }
        }

}
