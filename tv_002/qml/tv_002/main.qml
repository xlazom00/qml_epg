import QtQuick 2.1
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.0


Item {
    id : root;
    width: 1280
    height: 720

    readonly property real pixelPerSeconds: 1.0/30.0

    function logThis( something){
        console.log(Qt.formatTime(new Date(), "hh:mm:ss:zzz ") + something);
    }

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

            signal nieco( int shift, variant b)

            onNieco: {
                logThis( "shift:" + shift + " b:" + b);
                move(shift, b, someListView.children[0].children);
            }

            function move(shift, currentListView, listListView)  {
                logThis(shift + " " + currentListView + " " + listListView);
//                logThis(currentListView +" currentListView focus:" + currentListView.focus + " activeFocus:" + currentListView.activeFocus)
//                logThis(listListView.length);
                var validListViews = []
                for (var ii=0; ii<listListView.length-1; ii++){
                    if(listListView[ii].objectName === "0"){
                        validListViews.push(listListView[ii]);
                    }
                }

                for (var i=0; i<validListViews.length; i++){
                    var eventListView = validListViews[i].eventsListView;

                    logThis( i + " " + temp + " activeFocus:" + eventListView.activeFocus + " focus:" + eventListView.focus );
                    if(eventListView.activeFocus) {
                        var newFocusedItem = i + shift;
                        if(newFocusedItem >= validListViews.length) {
                            newFocusedItem = 0;
                        }else if (newFocusedItem < 0) {
                            newFocusedItem =  validListViews.length-1;
                        }

                        var currentItem = listListView[i].currentItem;
                        //                console.log("currentItem x,y", currentItem.x, currentItem.y);

                        var nextItemIndex = validListViews[newFocusedItem].indexAt(currentItem.x + currentItem.width*0.5, currentItem.y)
                        if(nextItemIndex === -1) {
                            nextItemIndex = validListViews[newFocusedItem].indexAt(currentItem.x + currentItem.width*0.5 + 5, currentItem.y)
                        }

                        //                console.log("nextItemIndex ", nextItemIndex);

                        var contX = validListViews[i].contentX;
                        validListViews[newFocusedItem].currentIndex = nextItemIndex;
                        validListViews[newFocusedItem].contentX = contX;
                        validListViews[newFocusedItem].focus = true;
                        validListViews[newFocusedItem].forceLayout();
                        break;
                    }
                }
            }

            delegate:
                Item {
                property alias eventsListView : eventsListView
                id : eventsRoot
                objectName : "0"

                Keys.onPressed: {
                    if(event.isAutoRepeat){
                        logThis( "isAutoRepeat")
                    }

                    if(event.key === Qt.Key_Up) {
                        event.accepted = true;
                        ListView.view.nieco(1, eventsListView);
                    }
                    else if(event.key === Qt.Key_Down) {
                        event.accepted = true;
                        ListView.view.nieco(-1, eventsListView);
                    }
                }

                height: 30
                Text {
                    id: textdata
                    text : model.modelData.name
                    color : "brown"
                }

                ListView {
                    id : eventsListView
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
                            color :  ListView.isCurrentItem && ListView.view.activeFocus ? "Yellow" : "white"
                            border.color: "Green"
                            border.width: 1
                            width : model.duration * pixelPerSeconds
                            height: 50

                            Text {
                                anchors.fill: parent
                                wrapMode: Text.Wrap
                                id : eventTitleText
                                text: model.title
                                color: "Black"
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

//        console.log("someListView:" + someListView + " someListView.model.count:" + someListView.model.count);
        logThis("someListView.children:" + someListView.children + " length:" + someListView.children.length)

        var childrens = someListView.children[0];
        logThis("childrens.children:" + childrens.children + " length:" + childrens.children.length)

        for(var i = 0; i < childrens.children.length; ++i){
            logThis(childrens.children[i]);
            logThis(childrens.children[i].eventsListViewChildren);

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

        event.accepted = false;
    }

    Component.onCompleted: {
        someListView.currentIndex = 0;
        someListView.positionViewAtIndex(0, ListView.SnapPosition)
        someListView.focus = true;

        //            console.log(someListView.currentItem.children.length);
        someListView.currentItem.children[1].currentIndex = 0
        someListView.currentItem.children[1].positionViewAtIndex(0, ListView.SnapPosition)
        someListView.currentItem.children[1].focus = true

    }


}

