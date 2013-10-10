import QtQuick 2.0

Item {
    width: 1280
    height: 720

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
                listview2.contentX = listview1.contentX
            }

//            contentX: listController.contentX

            orientation: ListView.Horizontal;
            spacing : 5

            model : EPGDataModel {}
            delegate: Rectangle {
                width: 50
                height: 50
                color : ListView.isCurrentItem && listview1.activeFocus ? "Black" : "Red"
            }
//            KeyNavigation.down: listview2;
//            KeyNavigation.up :  listview2;
        }

        ListView {
            id : listview2
            anchors.left: parent.left
            anchors.right: parent.right
            orientation: ListView.Horizontal;
            spacing : 5

            onContentXChanged: {
                listview1.contentX = listview2.contentX
            }

            highlightMoveDuration : 1
            height: 50

            model : EPGDataModel {}
            delegate: Rectangle {
                width: 80
                height: 50
                color : ListView.isCurrentItem && listview2.activeFocus ? "Black" : "Blue"
                Text {
                    anchors.fill: parent
                    anchors.centerIn: parent
                    text: title
                    color : "Black"
                    wrapMode: Text.Wrap
                }
            }

            focus:true
//            Component.onCompleted: {
//                listofViews.push(listview2)
//            }
//            KeyNavigation.down: listview1;
//            KeyNavigation.up :  listview1;
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

                // get currently focused item position
                var currentItem = listOfViews.children[i].currentItem;
                console.log("currentItem x,y", currentItem.x, currentItem.y);
                var nextItemIndex = listOfViews.children[newFocusedItem].indexAt(currentItem.x + currentItem.width*0.5, currentItem.y)
                if(nextItemIndex === -1) {
                    nextItemIndex = listOfViews.children[newFocusedItem].indexAt(currentItem.x + currentItem.width*0.5 + 5, currentItem.y)
                }
                console.log("nextItemIndex ", nextItemIndex);

                listOfViews.children[newFocusedItem].currentIndex = nextItemIndex;
                listOfViews.children[newFocusedItem].focus = true;
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

                listOfViews.children[newFocusedItem].currentIndex = nextItemIndex;
                listOfViews.children[newFocusedItem].focus = true;
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
