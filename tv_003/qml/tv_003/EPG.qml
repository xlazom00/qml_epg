import QtQuick 2.0

Flickable {
    id : area
    anchors.fill: parent

    property real startOfTime : area.contentX
    property real endOfTime : area.contentX + area.width
//    property real currentTime;

    contentWidth: area.width;
    contentHeight: area.height;

//    contentWidth: hourSize * (area.endOfTimeline - area.startOfTimeline) / Utils.MS_PER_HOUR
//    contentHeight: channels.count * channelHeight
}
