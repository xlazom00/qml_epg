import QtQuick 2.1
import QtQuick.Layouts 1.0

Item {
    property real _scaleFactor: root.width/1280;

    id: root
    width: 1280
    height: 720

    Image {
        id: background
        anchors.fill: parent
        source: "images/background.jpg"
    }

    FontLoader {
        id: font0;
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
//            x: 92*_scaleFactor;
//            y:(44.0  + 20.0)*_scaleFactor
            width: 10*_scaleFactor
            height: 22*_scaleFactor
            timerFontSize:30*_scaleFactor
            fontFamily : font0.name
        }


        EPGListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            textFont : font0.name
            id: streamList
            height: 800
//            anchors.fill: parent
//            anchors.right: parent.right
//            anchors.left: parent.left
//            anchors
//            anchors.topMargin: 40*_scaleFactor;
            model : StreamsDataModel {}
        }
    }



    focus: true

    Keys.onDownPressed: {
//        console.log("currentIndex:" + streamList.currentIndex + " count:"+streamList.count + " flicking:" + streamList.flicking + " moving:"+ streamList.moving);
        if(streamList.currentIndex == streamList.count)
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
        if(streamList.currentIndex == 0)
        {
            streamList.currentIndex = streamList.count-1;
            streamList.positionViewAtIndex(streamList.count-1, ListView.SnapPosition)

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
