import QtQuick 2.1
import QtQuick.Layouts 1.0

Item {
    property real _scaleFactor: root.width/1280;
    property int emptyItemsBegin: 4;
    property int emptyItemsEnd: 10;

    id: root
    width: 1280
    height: 720

    Image {
        id: background
        anchors.fill: parent
        source: "background.jpg"
    }

    Clock {
        x: 92*_scaleFactor; y:44*_scaleFactor
        width: 10
        height: 22
        timerFontSize:24*_scaleFactor
    }

    Component {
        id: streamDelegate
        Item {
            id : wrapper
            height: 100
            //            height: ListView.view.height
            width: rectangle1.width

            Rectangle {
                anchors.centerIn: parent
                id: rectangle1
                height: tabText.height + 2*5;
                width: tabText.width + 2*24;

                visible: title!="empty"
                color: wrapper.ListView.isCurrentItem ? "white" : "black"

                Text {
                    verticalAlignment: Text.AlignVCenter
                    id: tabText
                    color: wrapper.ListView.isCurrentItem ? "black" : "white"
                    text: title
                    smooth: true
                    font.pointSize: 30 * _scaleFactor

                    states: State {
                        name: "Current"
                        when: wrapper.ListView.isCurrentItem
                        PropertyChanges { target: tabText; font.pointSize: 36 * _scaleFactor }
                    }
                    transitions: Transition {
                        NumberAnimation { properties: "font.pointSize"; duration: 200 }
                    }


                    anchors.centerIn: parent
                    font.bold: true
                }
            }
        }
    }

    Component {
        id : epgLineDelegate
        Row {
            Text {

            }

            Text {
                id : titleText
                font.bold: titleText.ListView.isCurrentItem
                font.pointSize: 30 * _scaleFactor

                color: titleText.ListView.isCurrentItem ? "black" : "white"

                text: title

                states: State {
                    name: "Current"
                    when: titleText.ListView.isCurrentItem
                    PropertyChanges { target: titleText; font.pointSize: 36 * _scaleFactor }
                }
                transitions: Transition {
                    NumberAnimation { properties: "font.pointSize"; duration: 200 }
                }
            }
        }
    }

    Component{
        id: epgDelegate
        Column {
            id : epgDelegateColumn
            height: ListView.view.height
            // TODO : fix width to proper value
            width : root.width
//            Text {
//                id: name
//                text: "index:"+ index + " title:" + title
//                color: "Red"
//                font.pixelSize: 30
//                font.bold: true
//            }

            ListView {
                id : epgCurrentProgamDelegate
                orientation : ListView.Vertical
                width: parent.width
                height: parent.height
                spacing: 0
//                model : EPGDataModel{}
                model : epgData
                delegate: epgLineDelegate
                highlightFollowsCurrentItem: true

                highlightRangeMode : ListView.ApplyRange
                preferredHighlightBegin: 0 * _scaleFactor
                preferredHighlightEnd: 0 * _scaleFactor

                                            Rectangle{
                                                color: "Red"
                                                y:parent.preferredHighlightBegin ; x:0
                                                height: 1; width: parent.width
                                            }

                                            Rectangle{
                                                color: "Red"
                                                y:parent.preferredHighlightEnd ; x:0
                                                height: 1; width: parent.width
                                            }

                highlightMoveDuration: 400;
                highlightResizeDuration: 200;
                highlightMoveVelocity: 200;

            }
            Component.onCompleted: {
                console.log("epgDelegateColumn: " + epgDelegateColumn.width + " " + epgDelegateColumn.height);
                console.log("ListView.view.height"+ ListView.view.height + " ListView.view.width:" + ListView.view.width)
                //                    currentIndex = 0
                //                    positionViewAtIndex(0, ListView.SnapPosition)
            }
        }
    }

    Column
    {
        anchors.fill: parent
        anchors.topMargin: 50
        spacing: 0

        ListView {
            id: streamList
            height: 100
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.topMargin: 0*_scaleFactor;

            orientation : ListView.Horizontal

            highlightRangeMode : ListView.ApplyRange
            preferredHighlightBegin: 212 * _scaleFactor
            preferredHighlightEnd: 212 * _scaleFactor


            model: StreamsDataModel {}
            delegate: streamDelegate
            highlightFollowsCurrentItem: true
            spacing: 10 * _scaleFactor
            cacheBuffer: 50
            clip:true

            //                        Rectangle{
            //                            color: "Green"
            //                            x:parent.preferredHighlightBegin ; y:0
            //                            height: parent.height; width: 1
            //                        }

            //                        Rectangle{
            //                            color: "Green"
            //                            x:parent.preferredHighlightEnd ; y:0
            //                            height: parent.height; width: 1
            //                        }


            //            Component.onCompleted: {
            //                currentIndex = emptyItemsBegin
            //                positionViewAtIndex(emptyItemsBegin, ListView.SnapPosition)
            //            }

            highlightMoveDuration: 400;
            highlightResizeDuration: 200;
            highlightMoveVelocity: 200;
        }

        ListView {
            id: epgList
            model: StreamsDataModel {}
            anchors.right: parent.right
            anchors.left: parent.left
            height: 300
            orientation : ListView.Horizontal
            cacheBuffer: 10
            clip:true
            spacing : 0
            delegate: epgDelegate

            highlightFollowsCurrentItem: true
            highlightRangeMode : ListView.ApplyRange
            preferredHighlightBegin: 212 * _scaleFactor
            preferredHighlightEnd: 212 * _scaleFactor

            highlightMoveDuration: 400;
            highlightResizeDuration: 200;
            highlightMoveVelocity: 200;


            //                                    Rectangle{
            //                                        color: "Green"
            //                                        x:parent.preferredHighlightBegin ; y:0
            //                                        height: parent.height; width: 1
            //                                    }

            //                                    Rectangle{
            //                                        color: "Green"
            //                                        x:parent.preferredHighlightEnd ; y:0
            //                                        height: parent.height; width: 1
            //                                    }
        }
    }

    focus: true;
    Keys.onUpPressed: {
        //            console.log("listview items:", epgList.currentItem.children[1].currentIndex, epgList.currentItem.children[1].count)

        //            for (var i = 0; i < epgList.currentItem.children.length; i++)
        //                        console.log("child:", i, epgList.currentItem.children[i])



        epgList.currentItem.children[0].decrementCurrentIndex();
    }

    Keys.onDownPressed: {
        //            console.log("listview items:", epgList.currentItem.children[1].currentIndex, epgList.currentItem.children[1].count)

        epgList.currentItem.children[0].incrementCurrentIndex();
    }

    Keys.onRightPressed: {
        console.log("currentIndex:" + streamList.currentIndex + " count:"+streamList.count + " flicking:" + streamList.flicking + " moving:"+ streamList.moving);
        if(streamList.currentIndex == streamList.count-1-emptyItemsEnd)
        {

            streamList.currentIndex = emptyItemsBegin;
            streamList.positionViewAtIndex(emptyItemsBegin, ListView.SnapPosition)
            epgList.currentIndex = emptyItemsBegin;
            epgList.positionViewAtIndex(emptyItemsBegin, ListView.SnapPosition)
        }
        else
        {
            streamList.incrementCurrentIndex()
            epgList.incrementCurrentIndex()
        }
        event.accepted = true;
    }
    Keys.onLeftPressed: {
        console.log("currentIndex:" + streamList.currentIndex + " count:"+streamList.count + " flicking:" + streamList.flicking + " moving:"+ streamList.moving);
        if(streamList.currentIndex == emptyItemsBegin)
        {
            streamList.currentIndex = streamList.count-1-emptyItemsEnd;
            streamList.positionViewAtIndex(streamList.count-1-emptyItemsEnd, ListView.SnapPosition)

            epgList.currentIndex = streamList.count-1-emptyItemsEnd;
            epgList.positionViewAtIndex(streamList.count-1-emptyItemsEnd, ListView.SnapPosition)
        }
        else
        {
            streamList.decrementCurrentIndex()
            epgList.decrementCurrentIndex()
        }
        event.accepted = true;
    }


    Component.onCompleted: {
        //        console.log(Component.url + " " + Component.status +  " width:" + width, " heigth:" + height)
        streamList.currentIndex = emptyItemsBegin;
        streamList.positionViewAtIndex(emptyItemsBegin, ListView.SnapPosition)
        epgList.currentIndex = emptyItemsBegin;
        epgList.positionViewAtIndex(emptyItemsBegin, ListView.SnapPosition)
    }

}

