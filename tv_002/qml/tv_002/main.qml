import QtQuick 2.1
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.0


Item {
    id : root;
    width: 1280
    height: 720

    property real pixelPerSeconds: 1.0/10.0

        ColumnLayout
        {

            anchors.fill: parent
            Button{
                text: "ahoj"
                onClicked: {
//                    console.log(myModel);
                    myModel[0].streammodel.setFilter("streamid=2")
                }
            }

            Text {
                id: name
//                text: myModel[0].streammodel
            }

            ListView {
                id: someListView
                width: 300; height: 700
            //    anchors.fill: parent
                spacing : 15
                model: myModel

                cacheBuffer: 50

                delegate:
                    Item {
                        height: 30
                        Text {
                            id: textdata
                            text : model.modelData.name
                        }

                        ListView {
                            anchors.left: parent.left
                            anchors.leftMargin: 150
                            width : root.width - someListView.width
                            height : 50
                            orientation: ListView.Horizontal
                            model : streammodel
                            spacing : 0
                            clip: true
                            delegate:
                                Rectangle {
                                    color : "Yellow"
                                    border.color: "Green"
                                    border.width: 1
                                    width : model.duration * pixelPerSeconds
                                    height: 50

                                    Text {
                                        anchors.fill: parent
                                        wrapMode: Text.Wrap
                                        id : eventTitleText
                                        text: model.title
                                        color: "Blue"
                                        maximumLineCount : 2
                                    }
                            }
                        }
                }
            }
        }
        focus : true;
        Keys.onUpPressed: {
            console.log("up")

            for (var i=0; i<someListView.children.length; i++){
                console.log("" + someListView.children[i]);
            }

            for (var i=0; i<someListView.children[0].length; i++){
                console.log("" + someListView.children[0].children[i]);
            }

//            // focus next item

//            for (var i=0; i<listOfViews.children.length; i++){
//                if(listOfViews.children[i].activeFocus) {
//                    var newFocusedItem = i - 1;
//                    if(newFocusedItem < 0) {
//                        newFocusedItem =  listOfViews.children.length-1;
//                    }

//                    var currentItem = listOfViews.children[i].currentItem;
//                    console.log("currentItem x,y", currentItem.x, currentItem.y);

//                    var nextItemIndex = listOfViews.children[newFocusedItem].indexAt(currentItem.x + currentItem.width*0.5, currentItem.y)
//                    if(nextItemIndex === -1) {
//                        nextItemIndex = listOfViews.children[newFocusedItem].indexAt(currentItem.x + currentItem.width*0.5 + 5, currentItem.y)
//                    }

//                    console.log("nextItemIndex ", nextItemIndex);

//                    var contX = listOfViews.children[i].contentX;
//                    listOfViews.children[newFocusedItem].currentIndex = nextItemIndex;
//                    listOfViews.children[newFocusedItem].contentX = contX;
//                    listOfViews.children[newFocusedItem].focus = true;
//                    listOfViews.children[newFocusedItem].forceLayout();
//                    break;
//                }
//            }

            event.accepted = true;
        }
}

