import QtQuick 2.0

Item {
    width: 1280
    height: 720
    id : root

    Column {
        id : listOfViews
        anchors.fill: parent
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

            focus:true
        }
    }

    function getClosesItem() {

    }

//    focus: true

    Keys.onUpPressed: {
        console.log("up")
        // focus next item

        for (var i=0; i<listOfViews.children.length; i++){
            if(listOfViews.children[i].activeFocus) {
                var newFocusedItem = i - 1;
                if(newFocusedItem < 0) {
                    newFocusedItem =  listOfViews.children.length-1;
                }

                var currentItem = listOfViews.children[i].currentItem;
                console.log("currentItem x,y", currentItem.x, currentItem.y);

                var nextItemIndex = listOfViews.children[newFocusedItem].indexAt(currentItem.x + currentItem.width*0.5, currentItem.y)
                if(nextItemIndex === -1) {
                    nextItemIndex = listOfViews.children[newFocusedItem].indexAt(currentItem.x + currentItem.width*0.5 + 5, currentItem.y)
                }

                console.log("nextItemIndex ", nextItemIndex);

                var contX = listOfViews.children[i].contentX;
                listOfViews.children[newFocusedItem].currentIndex = nextItemIndex;
                listOfViews.children[newFocusedItem].contentX = contX;
                listOfViews.children[newFocusedItem].focus = true;
                listOfViews.children[newFocusedItem].forceLayout();
                break;
            }
        }

        event.accepted = true;
    }
    Keys.onDownPressed: {
        console.log("down")
        // focus next item
        for (var i=0; i<listOfViews.children.length; i++){
            if(listOfViews.children[i].activeFocus) {
                var newFocusedItem = i + 1;
                if(newFocusedItem >= listOfViews.children.length) {
                    newFocusedItem = 0;
                }
                var currentItem = listOfViews.children[i].currentItem;
                console.log("currentItem x,y", currentItem.x, currentItem.y);

                var nextItemIndex = listOfViews.children[newFocusedItem].indexAt(currentItem.x + currentItem.width*0.5, currentItem.y)
                if(nextItemIndex === -1) {
                    nextItemIndex = listOfViews.children[newFocusedItem].indexAt(currentItem.x + currentItem.width*0.5 + 5, currentItem.y)
                }

                console.log("nextItemIndex ", nextItemIndex);

                var contX = listOfViews.children[i].contentX;
                listOfViews.children[newFocusedItem].currentIndex = nextItemIndex;
                listOfViews.children[newFocusedItem].contentX = contX;
                listOfViews.children[newFocusedItem].focus = true;
                listOfViews.children[newFocusedItem].forceLayout();
                break;
            }
        }

        event.accepted = true;
    }

//    function epgUp()
//    {
//        //            console.log("listview items:", epgList.currentItem.children[1].currentIndex, epgList.currentItem.children[1].count)

//        if(epgList.currentItem.children[1].currentIndex  !== 0)
//        {
//            epgList.currentItem.children[1].currentIndex--;
//        }

//        //        epgList.currentItem.children[1].decrementCurrentIndex();

//        //        epgList.currentItem.children[0].decrementCurrentIndex();
//    }
//    function epgDown() {
//        //            console.log("listview items:", epgList.currentItem.children[1].currentIndex, epgList.currentItem.children[1].count)

////        epgList.currentItem.children[1].incrementCurrentIndex();
//        if(epgList.currentItem.children[1].currentIndex  !== epgList.currentItem.children[1].count-1)
//        {
//            epgList.currentItem.children[1].currentIndex++;
//        }
//    }


//    Flickable {
//        id: listController
//        anchors.fill: parent
//        contentHeight: listview1.contentHeight
//        contentWidth: listview1.contentWidth
//    }



//    Text {
//        text: qsTr("Hello World")
//        anchors.centerIn: parent
//    }
//    MouseArea {
//        anchors.fill: parent
//        onClicked: {
//            Qt.quit();
//        }
//    }
}
