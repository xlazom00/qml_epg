import QtQuick 2.1
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.0


Item {
    id : root;
    width: 1280
    height: 720
    property real scaleFactor: root.width/1280;

    readonly property real pixelPerSeconds: 1.0/20.0

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
            signal nieco2( real newContentX)

            onNieco2: {
//                logThis( "newContentX:" + newContentX);
                var localListListView = someListView.children[0].children
                for (var ii=0; ii<localListListView.length-1; ii++){
                    if(localListListView[ii].objectName === "0"){
//                        logThis(localListListView[ii].eventsListView + " focus:" + localListListView[ii].eventsListView.focus + " activeFocus" + localListListView[ii].eventsListView.activeFocus);
                        if(localListListView[ii].eventsListView.focus === false){
                            localListListView[ii].eventsListView.contentX = newContentX;
                        }
                    }
                }
            }

            onNieco: {
//                logThis( "shift:" + shift + " b:" + b);
                move(shift, b, someListView.children[0].children);
            }

            function move(shift, currentListView, aListListView)  {
//                logThis(shift + " " + aListListView + " " + aListListView);
//                logThis(currentListView +" currentListView focus:" + currentListView.focus + " activeFocus:" + currentListView.activeFocus)
//                logThis(listListView.length);
                var validListViews = []
                for (var ii=0; ii<aListListView.length-1; ii++){
                    if(aListListView[ii].objectName === "0"){
                        validListViews.push(aListListView[ii]);
                    }
                }

                for (var i=0; i<validListViews.length; i++){
                    var currentSelectedListView = validListViews[i].eventsListView;

//                    logThis( i + " " + currentSelectedListView + " activeFocus:" + currentSelectedListView.activeFocus + " focus:" + currentSelectedListView.focus );
                    if(currentSelectedListView.focus) {
                        var currentSelectedItem = currentSelectedListView.currentItem;
                        console.log("currentSelectedItem x,y", currentSelectedItem + " " + currentSelectedItem.x + " " + currentSelectedItem.y);

                        var newFocusedListViewIndex = i + shift;
                        if(newFocusedListViewIndex >= validListViews.length) {
                            newFocusedListViewIndex = 0;
                            break;
                        }else if (newFocusedListViewIndex < 0) {
                            newFocusedListViewIndex =  validListViews.length-1;
                            break;
                        }
//                        console.log("newFocusedListViewIndex:" + newFocusedListViewIndex);
                        var newFocusedListView = validListViews[newFocusedListViewIndex].eventsListView;






                        var nextItemIndex = newFocusedListView.indexAt(currentSelectedItem.x + currentSelectedItem.width*0.5, currentSelectedItem.y)
                        if(nextItemIndex === -1) {
                            nextItemIndex = newFocusedListView.indexAt(currentSelectedItem.x + currentSelectedItem.width*0.5 + 5, currentSelectedItem.y)
                        }

                        //                console.log("nextItemIndex ", nextItemIndex);

                        var contX = currentSelectedListView.contentX;
                        logThis(nextItemIndex + " current.contentX:" + contX + " newFocusedListView.contentX:" + newFocusedListView.contentX);
                        if(shift > 0) {
                            someListView.incrementCurrentIndex()
                        } else {
                            someListView.decrementCurrentIndex();
                        }
                        newFocusedListView.focus = true;
                        newFocusedListView.currentIndex = nextItemIndex;
                        newFocusedListView.contentX = contX;

//                        someListView.cu
//                        newFocusedListView.forceLayout();
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
                        if(!eventsListView.moving){
                            ListView.view.nieco(-1, eventsListView);
                        }
                    }
                    else if(event.key === Qt.Key_Down) {
                        event.accepted = true;
                        if(!eventsListView.moving){
                            ListView.view.nieco(1, eventsListView);
                        }
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

                    highlightMoveDuration: 200;
                    highlightMoveVelocity: 100;
                    highlightFollowsCurrentItem: true
                    highlightRangeMode : ListView.ApplyRange
                    preferredHighlightBegin: 50.0*root.scaleFactor;
                    preferredHighlightEnd: width - preferredHighlightBegin

                    Rectangle {
                        color : "Red"
                        width : 2
                        height :50
                        x : parent.preferredHighlightBegin
                        y : 0
                    }
                    Rectangle {
                        color : "Red"
                        width : 2
                        height :50
                        x : parent.preferredHighlightEnd
                        y : 0
                    }

                    onContentXChanged: {
        //                console.log("contentX:" + contentX + " originX:" + originX);
                        if(focus){
                            eventsRoot.ListView.view.nieco2(contentX);
                        }
                    }


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

        //                    var currentSelectedItem = listOfViews.children[i].currentSelectedItem;
        //                    console.log("currentSelectedItem x,y", currentSelectedItem.x, currentSelectedItem.y);

        //                    var nextItemIndex = listOfViews.children[newFocusedItem].indexAt(currentSelectedItem.x + currentSelectedItem.width*0.5, currentSelectedItem.y)
        //                    if(nextItemIndex === -1) {
        //                        nextItemIndex = listOfViews.children[newFocusedItem].indexAt(currentSelectedItem.x + currentSelectedItem.width*0.5 + 5, currentSelectedItem.y)
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

        console.log(someListView.currentItem);
        someListView.currentItem.children[1].currentIndex = 0
        someListView.currentItem.children[1].positionViewAtIndex(0, ListView.SnapPosition)
        someListView.currentItem.children[1].focus = true

    }


}

