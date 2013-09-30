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
        source: "images/background.jpg"
    }

    FontLoader {
        id: neakyfont;
        source: "fonts/DnCeBd__.ttf"
        onStatusChanged: {
            console.log("status:" + neakyfont.status);
        }
    }

    ColumnLayout
    {
        anchors.fill: parent
        anchors.topMargin: 60
        spacing: 10

        Clock {
            x: 92*_scaleFactor; y:44*_scaleFactor
            width: 200
            height: 22
            timerFontSize:24*_scaleFactor
            fontFamily : neakyfont.name
        }


        ListView {
            id: streamList
            height: 800
//            anchors.fill: parent
            anchors.right: parent.right
            anchors.left: parent.left
//            anchors
//            anchors.topMargin: 40*_scaleFactor;

            orientation : ListView.Vertical

            highlightRangeMode : ListView.ApplyRange
            preferredHighlightBegin: 0 * _scaleFactor
            preferredHighlightEnd: 0 * _scaleFactor


            model: StreamsDataModel {}
            delegate: Rectangle{
                color : "Red"
                width : 100
                height : 100
            }
            highlightFollowsCurrentItem: true
            spacing: 10 * _scaleFactor
            cacheBuffer: 128
            clip:true

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

            highlightMoveDuration: 400;
            highlightResizeDuration: 200;
            highlightMoveVelocity: 200;
        }
    }



    focus: true

    Keys.onDownPressed: {
//        console.log("currentIndex:" + streamList.currentIndex + " count:"+streamList.count + " flicking:" + streamList.flicking + " moving:"+ streamList.moving);
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

    Keys.onUpPressed: {
//        console.log("currentIndex:" + streamList.currentIndex + " count:"+streamList.count + " flicking:" + streamList.flicking + " moving:"+ streamList.moving);
        if(streamList.currentIndex == emptyItemsBegin)
        {
            streamList.currentIndex = streamList.count-1-emptyItemsEnd;
            streamList.positionViewAtIndex(streamList.count-1-emptyItemsEnd, ListView.SnapPosition)

//            epgList.currentIndex = streamList.count-1-emptyItemsEnd;
//            epgList.positionViewAtIndex(streamList.count-1-emptyItemsEnd, ListView.SnapPosition)
        }
        else
        {
            streamList.decrementCurrentIndex()
//            epgList.decrementCurrentIndex()
        }
        event.accepted = true;
    }

}
