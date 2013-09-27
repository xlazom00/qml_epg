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

//    Text {
//        text: "Fancy font"
//        font.family: neakyfont.name
//        font.pixelSize: 40
//        color: "Red"
//    }

//    Text {
//        y:50
//        text: "Fancy font"
////        font.family: neakyfont.name
//        font.pixelSize: 40
//        color: "Red"
//    }



    Clock {
        x: 92*_scaleFactor; y:44*_scaleFactor
        width: 10
        height: 22
        timerFontSize:24*_scaleFactor
        fontFamily : neakyfont.name
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
        Item {
            property real selectedFontHeight : 40 * _scaleFactor
            property real fontHeight : 20 * _scaleFactor
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
//                font.bold : true
//                font.bold: epgLineDelegateRoot.ListView.isCurrentItem
                font.pointSize: fontHeight
//                color: epgLineDelegateRoot.ListView.isCurrentItem ? "black" : "white"
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
                anchors.verticalCenterOffset: -4
//                layer.enabled : true
                anchors.left : parent.left
                anchors.leftMargin: 145 * root._scaleFactor
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
//                font.bold : true
//                color: epgLineDelegateRoot.ListView.isCurrentItem ? "black" : "white"
                color : "white"

                text: title

                states: State {
                    name: "Current"
                    when: epgLineDelegateRoot.ListView.isCurrentItem
                    PropertyChanges { target: titleText; font.pointSize: selectedFontHeight }
                }
                transitions: Transition {
                    NumberAnimation { properties: "font.pointSize"; duration: 200 }
                }
            }
        }
    }

    Component {
        id: epgDelegate
        Column {
            id : epgDelegateColumn
            height: ListView.view.height
            spacing : 10
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
                anchors.leftMargin: 173
                source : (epgCurrentProgamDelegate.currentIndex!=-1)?epgData.get(epgCurrentProgamDelegate.currentIndex).img:""
                width : 320
                height: 180
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
                spacing: 15
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

                highlightMoveDuration: 400;
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
            height: 515
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
    Keys.onUpPressed: {
        //            console.log("listview items:", epgList.currentItem.children[1].currentIndex, epgList.currentItem.children[1].count)

        //            for (var i = 0; i < epgList.currentItem.children.length; i++)
        //                        console.log("child:", i, epgList.currentItem.children[i])



        epgList.currentItem.children[1].decrementCurrentIndex();
//        epgList.currentItem.children[0].decrementCurrentIndex();
        event.accepted = true;
    }

    Keys.onDownPressed: {
        //            console.log("listview items:", epgList.currentItem.children[1].currentIndex, epgList.currentItem.children[1].count)

        epgList.currentItem.children[1].incrementCurrentIndex();
        event.accepted = true;
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

