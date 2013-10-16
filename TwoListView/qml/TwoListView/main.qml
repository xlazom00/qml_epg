import QtQuick 2.1
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.0

Item {
    width: 1280
    height: 720
    id : root

    Column {
    anchors.fill: parent
        Button {
            onClicked: {
                console.log("listview1:" + listview1 + " listview1.model.count:" + listview1.model.count);
                console.log("listview1.children:" + listview1.children + " length:" + listview1.children.length)

                console.log("listview1.children[0].children:" + listview1.children[0].children + " length:" + listview1.children[0].children.length)
            }
        }

        Column {
            id : listOfViews
//            anchors.fill: parent
            width : parent.width;
            height: parent.height -100;
            spacing: 2



            ListView {
                id : listview1
                anchors.left: parent.left
                anchors.right: parent.right

                height: 50
                onContentXChanged: {
    //                console.log("contentX:" + contentX + " originX:" + originX);
                    if(activeFocus){
                        listview2.contentX = listview1.contentX
                    }
                }

                orientation: ListView.Horizontal;
                spacing : 5

                model : EPGDataModel {}
                delegate: Rectangle {
                    width: 120
                    height: 50
                    color : ListView.isCurrentItem && listview1.activeFocus ? "Yellow" : "Red"
                    Text {
                        anchors.fill: parent
                        anchors.centerIn: parent
                        text: title
                        color : "Black"
                        wrapMode: Text.Wrap
                    }
                }

                highlightMoveDuration: 200;
    //            highlightResizeDuration: 200;
                highlightMoveVelocity: 100;
                highlightFollowsCurrentItem: true
                highlightRangeMode : ListView.ApplyRange
                preferredHighlightBegin: 212
                preferredHighlightEnd: root.width - preferredHighlightBegin

                focus:true
            }

            ListView {
                id : listview2
                anchors.left: parent.left
                anchors.right: parent.right
                orientation: ListView.Horizontal;
                spacing : 5

                onContentXChanged: {
    //                console.log("contentX:" + contentX + " originX:" + originX);
                    if(activeFocus){
                        listview1.contentX = listview2.contentX
                    }
                }

    //            highlightMoveDuration : 1
                height: 50

                model : EPGDataModel {}
                delegate: Rectangle {
                    width: 180
                    height: 50
                    color : ListView.isCurrentItem && listview2.activeFocus ? "Yellow" : "Blue"
                    Text {
                        anchors.fill: parent
                        anchors.centerIn: parent
                        text: title
                        color : "Black"
                        wrapMode: Text.Wrap
                    }
                }

                highlightMoveDuration: 200;
    //            highlightResizeDuration: 200;
                highlightMoveVelocity: 100;
                highlightFollowsCurrentItem: true
                highlightRangeMode : ListView.ApplyRange
                preferredHighlightBegin: 212
                preferredHighlightEnd: root.width - preferredHighlightBegin
            }
        }
        Keys.onUpPressed: {
            console.log("up")
            // focus next item

            move(-1);

            event.accepted = true;
        }
        Keys.onDownPressed: {
            console.log("down")

            // focus next item
            move(1);
            event.accepted = true;
        }
        function move(shift)  {
            for (var i=0; i<listOfViews.children.length; i++){
                if(listOfViews.children[i].activeFocus) {
                    var newFocusedItem = i + shift;
                    if(newFocusedItem >= listOfViews.children.length) {
                        newFocusedItem = 0;
                    }else if (newFocusedItem < 0) {
                        newFocusedItem =  listOfViews.children.length-1;
                    }

                    var currentItem = listOfViews.children[i].currentItem;
    //                console.log("currentItem x,y", currentItem.x, currentItem.y);

                    var nextItemIndex = listOfViews.children[newFocusedItem].indexAt(currentItem.x + currentItem.width*0.5, currentItem.y)
                    if(nextItemIndex === -1) {
                        nextItemIndex = listOfViews.children[newFocusedItem].indexAt(currentItem.x + currentItem.width*0.5 + 5, currentItem.y)
                    }

    //                console.log("nextItemIndex ", nextItemIndex);

                    var contX = listOfViews.children[i].contentX;
                    listOfViews.children[newFocusedItem].currentIndex = nextItemIndex;
                    listOfViews.children[newFocusedItem].contentX = contX;
                    listOfViews.children[newFocusedItem].focus = true;
                    listOfViews.children[newFocusedItem].forceLayout();
                    break;
                }
            }
        }
    }

}
