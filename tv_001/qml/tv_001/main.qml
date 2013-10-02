import QtQuick 2.1
import QtQuick.Layouts 1.0

Item {
    property real _scaleFactor: root.width/1280;
    property int emptyItemsBegin: 4;
    property int emptyItemsEnd: 10;
    property color transparentBlack : "#7F000000"

    id: root
    width: 1280
    height: 720

    Image {
        id: background
        anchors.fill: parent
        source: "images/background.jpg"
    }

    FontLoader {
        id: normalFont;
        source: "fonts/DnCeRg__.ttf"
        onStatusChanged: {
            console.log("status:" + neakyfont.status);
        }
    }

    FontLoader {
        id: boldFont;
        source: "fonts/DnCeBd__.ttf"
        onStatusChanged: {
            console.log("status:" + neakyfont.status);
        }
    }

    Clock {
        x: 92*_scaleFactor;
        y:(44.0  + 20.0)*_scaleFactor
        width: 10*_scaleFactor
        height: 22*_scaleFactor
        timerFontSize:30*_scaleFactor
        fontFamily : boldFont.name
    }

    Component {
        id: streamDelegate
        Item {
//            color : "Red"
            id : wrapper
            height: 70*_scaleFactor
            //            height: ListView.view.height
            width: rectangle1.width

            Rectangle {
                anchors.centerIn: parent
                id: rectangle1
                height : 56.0 * _scaleFactor;
                width: tabText.width + 2*(20.0 * _scaleFactor);

                visible: title!="empty"
                color: wrapper.ListView.isCurrentItem ? "white" : transparentBlack

                states: State {
                    name: "Current"
                    when: wrapper.ListView.isCurrentItem
                    PropertyChanges { target: rectangle1; height: 70.0 * _scaleFactor }
                }
                transitions: Transition {
                    NumberAnimation { properties: "height"; duration: 200 }
                }

                Text {
                    verticalAlignment: Text.AlignVCenter
                    id: tabText
                    color: wrapper.ListView.isCurrentItem ? "black" : "white"
                    text: title
                    smooth: true
                    font.family: boldFont.name
                    font.pointSize: 28.0 * _scaleFactor

                    states: State {
                        name: "Current"
                        when: wrapper.ListView.isCurrentItem
                        PropertyChanges { target: tabText; font.pointSize: 28.0 * _scaleFactor * 1.5 }
                    }
                    transitions: Transition {
                        NumberAnimation { properties: "font.pointSize"; duration: 200 }
                    }
                    anchors.centerIn: parent
                }
            }
        }
    }

    Component {
        id : epgLineDelegate
        Item {
            property real selectedFontHeight : 42 * _scaleFactor
            property real fontHeight : selectedFontHeight * 0.5
//            color : "Green"
//            width : root.width
            width : 1024 * root._scaleFactor
//            height: 50
            height: titleTime.height;
            id : epgLineDelegateRoot

            Text {
                anchors.left : parent.left
                anchors.leftMargin: 50* root._scaleFactor
                width: 90 * root._scaleFactor
                horizontalAlignment : Text.AlignRight
                id : titleTime
                font.pointSize: fontHeight
                font.family: boldFont.name

                color : "white"
                text : startTime

                states: State {
                    name: "Current"
                    when: epgLineDelegateRoot.ListView.isCurrentItem
                    PropertyChanges { target: titleTime; font.pointSize: selectedFontHeight }
                }
                transitions: Transition {
                    NumberAnimation { properties: "font.pointSize"; duration: 200 }
                }
            }

            Rectangle {
                visible: epgLineDelegateRoot.ListView.isCurrentItem
                color : "blue"
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -4 *_scaleFactor
//                layer.enabled : true
                anchors.left : parent.left
                anchors.leftMargin: 150 * root._scaleFactor
//                anchors.top: parent.top
//                anchors.topMargin: 5
//                width : 16
//                height: 16
                width : children.width
                height: children.height
                SelectTriangle{
                }
            }

            Text {
                anchors.left : parent.left
                anchors.leftMargin: 170 * root._scaleFactor
                width : epgLineDelegateRoot.width - titleTime.width
                horizontalAlignment : Text.AlignLeft
                id : titleText
                font.pointSize: fontHeight
                font.family: boldFont.name
                color : "white"

                text: title

                states: State {
                    name: "Current"
                    when: epgLineDelegateRoot.ListView.isCurrentItem
                    PropertyChanges { target: titleText; font.pointSize: selectedFontHeight }
                }
                transitions: Transition {
                    NumberAnimation { properties: "font.pointSize"; duration: 100 }
                }
            }
        }
    }

    Component {
        id: epgDelegate
        Column {
            id : epgDelegateColumn
            height: ListView.view.height
            spacing : 10*_scaleFactor
            // TODO : fix width to proper value
            width : root.width
//                        Text {
//                            id: name
//                            text: "index:"+ index + " title:" + title + " img:" + epgData.get(epgCurrentProgamDelegate.currentIndex).img
//                            color: "Red"
//                            font.pixelSize: 30
//                            font.bold: true
//                        }
            Image {
//                id : titleImage
                BusyIndicator {
                    anchors.centerIn: parent;
                    on: parent.status != Image.Ready
                }
                anchors.left: parent.left
                anchors.leftMargin: 173*_scaleFactor
                source : (epgCurrentProgamDelegate.currentIndex!=-1)?epgData.get(epgCurrentProgamDelegate.currentIndex).img:""
                width : 320 *_scaleFactor
                height: 180 *_scaleFactor
                asynchronous : true
                fillMode: Image.PreserveAspectCrop
//                states: State {
//                    name: "Current"
//                    when: epgLineDelegateRoot.ListView.isCurrentItem
//                    PropertyChanges { target: titleText; font.pointSize: selectedFontHeight }
//                }
//                transitions: Transition {
//                    NumberAnimation { properties: "font.pointSize"; duration: 200 }
//                }
            }


            ListView {
                cacheBuffer : 128
                clip : true
                id : epgCurrentProgamDelegate
                orientation : ListView.Vertical
                width: parent.width
                height: parent.height
                spacing: 15 *_scaleFactor
                model : epgData
                delegate: epgLineDelegate
                highlightFollowsCurrentItem: true

                highlightRangeMode : ListView.ApplyRange
                preferredHighlightBegin: 0 * _scaleFactor
                preferredHighlightEnd: 0 * _scaleFactor

//                Rectangle{
//                    color: "Red"
//                    y:parent.preferredHighlightBegin ; x:0
//                    height: 1; width: parent.width
//                }

//                Rectangle{
//                    color: "Red"
//                    y:parent.preferredHighlightEnd ; x:0
//                    height: 1; width: parent.width
//                }

                highlightMoveDuration: 300;
                highlightResizeDuration: 200;
                highlightMoveVelocity: 200;

            }
//            Component.onCompleted: {
//                console.log("epgDelegateColumn: " + epgDelegateColumn.width + " " + epgDelegateColumn.height);
//                console.log("ListView.view.height"+ ListView.view.height + " ListView.view.width:" + ListView.view.width)
//                //                    currentIndex = 0
//                //                    positionViewAtIndex(0, ListView.SnapPosition)
//            }
        }
    }

    Column
    {
        anchors.fill: parent
        anchors.topMargin: (84 + 20) *_scaleFactor
        spacing: 10 *_scaleFactor

        ListView {
            id: streamList
            height: 70 *_scaleFactor
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
            anchors.leftMargin: -210.0 * root._scaleFactor
            height: 515 *_scaleFactor
            orientation : ListView.Horizontal
            cacheBuffer: 0
            clip:true
            spacing : 0
            delegate: epgDelegate

            highlightFollowsCurrentItem: true
            highlightRangeMode : ListView.ApplyRange
            preferredHighlightBegin: 250 * _scaleFactor
            preferredHighlightEnd: 250 * _scaleFactor


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
//    Keys.onPressed: {
//        console.log("Key Pres" + event.key);
//        event.accepted = true;
//    }

    function epgUp()
    {
        //            console.log("listview items:", epgList.currentItem.children[1].currentIndex, epgList.currentItem.children[1].count)

        if(epgList.currentItem.children[1].currentIndex  !== 0)
        {
            epgList.currentItem.children[1].currentIndex--;
        }

        //        epgList.currentItem.children[1].decrementCurrentIndex();

        //        epgList.currentItem.children[0].decrementCurrentIndex();
    }
    function epgDown() {
        //            console.log("listview items:", epgList.currentItem.children[1].currentIndex, epgList.currentItem.children[1].count)

//        epgList.currentItem.children[1].incrementCurrentIndex();
        if(epgList.currentItem.children[1].currentIndex  !== epgList.currentItem.children[1].count-1)
        {
            epgList.currentItem.children[1].currentIndex++;
        }
    }
    function changeChannelPlus() {
        //        console.log("currentIndex:" + streamList.currentIndex + " count:"+streamList.count + " flicking:" + streamList.flicking + " moving:"+ streamList.moving);
                if(streamList.currentIndex === streamList.count-1-emptyItemsEnd)
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
    }

    function changeChannelMinus() {
        //        console.log("currentIndex:" + streamList.currentIndex + " count:"+streamList.count + " flicking:" + streamList.flicking + " moving:"+ streamList.moving);
        if(streamList.currentIndex === emptyItemsBegin)
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
    }

    Keys.onUpPressed: {
        epgUp()
        event.accepted = true;
    }

    Keys.onDownPressed: {
        epgDown()
        event.accepted = true;
    }

    Keys.onRightPressed: {
        changeChannelPlus()
        event.accepted = true;
    }
    Keys.onLeftPressed: {
        changeChannelMinus()
        event.accepted = true;
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_PageUp) {
            changeChannelPlus()
            event.accepted = true;
            return;
        }
        if (event.key === Qt.Key_PageDown) {
            changeChannelMinus()
            event.accepted = true;
            return;
        }
    }


    Component.onCompleted: {
        //        console.log(Component.url + " " + Component.status +  " width:" + width, " heigth:" + height)
        streamList.currentIndex = emptyItemsBegin;
        streamList.positionViewAtIndex(emptyItemsBegin, ListView.SnapPosition)
        epgList.currentIndex = emptyItemsBegin;
        epgList.positionViewAtIndex(emptyItemsBegin, ListView.SnapPosition)
    }

}

