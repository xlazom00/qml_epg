import QtQuick 2.1
import QtQuick.Layouts 1.0

Item {
    property real _scaleFactor: root.width/1280;
    property int emptyItemsBegin: 4;
    property int emptyItemsEnd: 10;

    id: root
    width: 1280
    height: 800

    Image {
        id: background
        anchors.fill: parent
        source: "bolt.png"
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

    //    Spinner {
    //        anchors.right: parent.right
    //        anchors.left: parent.left
    //        anchors.top: parent.top
    //        anchors.topMargin: 300
    //        anchors.bottom: parent.bottom
    ////        height: 164
    ////        y:208
    //        model: DataModel {}
    //        delegate: streamDelegate
    //    }


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
            //            anchors.leftMargin: 0
            //            anchors.rightMargin: 0
            y:0 * _scaleFactor
            //        height:64
            //            height:50

            orientation : ListView.Horizontal

            //        move: Transition {
            //            enabled: false
            //            id: moveTransition
            //            NumberAnimation { properties: "x,y"; duration: 1000 }
            //        }

            //        highlightRangeMode : ListView.StrictlyEnforceRange
            highlightRangeMode : ListView.ApplyRange
            preferredHighlightBegin: 212 * _scaleFactor
            preferredHighlightEnd: 212 * _scaleFactor


            model: StreamsDataModel {}
            delegate: streamDelegate
            //        snapMode: ListView.SnapToItem
            //        focus: true
            highlightFollowsCurrentItem: true
            spacing: 10 * _scaleFactor
            //        keyNavigationWraps: true
            cacheBuffer: 50
            clip:true

//            Rectangle{
//                color: "Red"
//                x:parent.preferredHighlightBegin ; y:0
//                height: parent.height; width: 1
//            }

//            Rectangle{
//                color: "Red"
//                x:parent.preferredHighlightEnd ; y:0
//                height: parent.height; width: 1
//            }


            Component.onCompleted: {
                streamList.currentIndex = emptyItemsBegin
                streamList.positionViewAtIndex(emptyItemsBegin, ListView.SnapPosition)
            }

            highlightMoveDuration: 400;
            highlightResizeDuration: 200;
            highlightMoveVelocity: 200;
        }
    }



    focus: true;
    Keys.onRightPressed: {
        console.log("currentIndex:" + streamList.currentIndex + " count:"+streamList.count + " flicking:" + streamList.flicking + " moving:"+ streamList.moving);
        if(streamList.currentIndex == streamList.count-1-emptyItemsEnd)
        {
            streamList.currentIndex = emptyItemsBegin;
            streamList.positionViewAtIndex(emptyItemsBegin, ListView.SnapPosition)
        }
        else
        {
            streamList.incrementCurrentIndex()
        }
        event.accepted = true;
    }
    Keys.onLeftPressed: {
        console.log("currentIndex:" + streamList.currentIndex + " count:"+streamList.count + " flicking:" + streamList.flicking + " moving:"+ streamList.moving);
        if(streamList.currentIndex == emptyItemsBegin)
        {
            streamList.currentIndex = streamList.count-1-emptyItemsEnd;
            streamList.positionViewAtIndex(streamList.count-1-emptyItemsEnd, ListView.SnapPosition)
        }
        else
        {
            streamList.decrementCurrentIndex()
        }
        event.accepted = true;
    }


    //    RowLayout {
    //        id: grid
    //            Image {
    //                width:320
    //                height: 240
    //                fillMode: Image.PreserveAspectFit
    //                source: "bolt.png"
    //            }

    ////            ListView {
    ////                id: currentprogram

    ////            }
    //    }

}

