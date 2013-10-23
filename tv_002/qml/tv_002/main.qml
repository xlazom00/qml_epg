import QtQuick 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.0


Item {
    id : root;
    width: 1280
    height: 720
    property real scaleFactor: root.width/1280;

    readonly property real pixelPerSeconds: 1.0/20.0

    property int moveDirection : 1;

    function logThis( something){
        console.log(Qt.formatTime(new Date(), "hh:mm:ss:zzz ") + something);
    }

    ColumnLayout
    {

        anchors.fill: parent


        ListView {
            id: someListView
            Layout.fillWidth : true

            height: 400
            spacing : 0
            model: myModel
            highlightMoveDuration: 200;
            highlightMoveVelocity: 100;
//            highlightRangeMode : ListView.StrictlyEnforceRange
//            preferredHighlightBegin: 50.0*root.scaleFactor;
//            preferredHighlightEnd: height - preferredHighlightBegin
            clip : true

            Rectangle {
                color : "Red"
                width : parent.width
                height :2
                x : 0
                y : parent.preferredHighlightBegin
            }
            Rectangle {
                color : "Red"
                width : parent.width
                height : 2
                x : 0
                y : parent.preferredHighlightEnd
            }

            cacheBuffer: 0

            signal nieco( int shift, variant b)
            signal nieco2( variant originListView, real newContentX)

            onNieco2: {
//                logThis( "newContentX:" + newContentX);
                var localListListView = someListView.children[0].children;

                // check for multiple focused
                var tempFocused = false;
                for (var ii=0; ii<localListListView.length; ii++){
                    if(localListListView[ii].objectName === "0"){
                        if(localListListView[ii].eventsListView.focus){
                            if(tempFocused === true){
                                logThis("multiple focused items");
                            }
                            tempFocused = true;
                        }
                    }
                }

                for (var ii=0; ii<localListListView.length; ii++){
                    if(localListListView[ii].objectName === "0"){
//                        logThis(localListListView[ii].eventsListView + " focus:" + localListListView[ii].eventsListView.focus + " activeFocus" + localListListView[ii].eventsListView.activeFocus);
                        if(localListListView[ii].eventsListView !== originListView){
                            localListListView[ii].eventsListView.contentX = newContentX;
                        }
                    }
                }

                // check for multiple focused
                var tempFocused = false;
                for (var ii=0; ii<localListListView.length; ii++){
                    if(localListListView[ii].objectName === "0"){
                        if(localListListView[ii].eventsListView.focus){
                            if(tempFocused === true){
                                logThis("multiple focused items");
                            }
                            tempFocused = true;
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
                for (var ii=0; ii<aListListView.length; ii++){
                    if(aListListView[ii].objectName === "0"){
                        if(aListListView[ii].eventsListView.highlighting){
//                            logThis("highlighting!!!!!!!!!!!!!!!!!");
                            return;
                        }

                        validListViews.push(aListListView[ii]);
                    }
                }
//                logThis("validListViews:" + validListViews.length);
//                logThis("currentIndex:" + someListView.currentIndex + " " + someListView.model.length);


                for (var i=0; i<validListViews.length; i++){
                    var currentSelectedListView = validListViews[i].eventsListView;


//                    logThis( i + " " + currentSelectedListView + " activeFocus:" + currentSelectedListView.activeFocus + " focus:" + currentSelectedListView.focus );
                    if(currentSelectedListView.focus) {
                        var currentSelectedItem = currentSelectedListView.currentItem;
//                        console.log("currentSelectedItem x,y", currentSelectedItem + " " + currentSelectedItem.x + " " + currentSelectedItem.y);
//                        if(typeof currentSelectedListView == 'undefined'){
//                            logThis("undefined");
//                            break;
//                        }
                        if("x" in currentSelectedItem){

                        } else {
                            logThis("x is not defined");
                            logThis(currentSelectedItem);
                            break;
                        }


                        var newFocusedListViewIndex = someListView.currentIndex + shift;
                        if(newFocusedListViewIndex >= someListView.model.length) {
//                            newFocusedListViewIndex = 0;
//                            console.log("break newFocusedListViewIndex:" + newFocusedListViewIndex);
                            break;
                        }else if (newFocusedListViewIndex < 0) {
//                            newFocusedListViewIndex =  validListViews.length-1;
//                            console.log("break newFocusedListViewIndex:" + newFocusedListViewIndex);
                            break;
                        }
                        var cii = someListView.currentIndex;

                        if(shift > 0) {
                            someListView.incrementCurrentIndex()
                        } else {
                            someListView.decrementCurrentIndex();
                        }

                        var newFocusedListView = someListView.currentItem.eventsListView;
//                        logThis(cii + " " + someListView.currentIndex + " count:" + newFocusedListView.count);
//                        logThis(newFocusedListView);



//                        var nextItem2 = newFocusedListView.itemAt(currentSelectedItem.x + currentSelectedItem.width*0.5, currentSelectedItem.y)
//                        if(nextItem2 === null) {
//                            nextItem2 = newFocusedListView.itemAt(currentSelectedItem.x + currentSelectedItem.width*0.5 + 5, currentSelectedItem.y)
//                        }

//                        if(nextItem2 === null) {
//                            logThis("nextItem2 not found")
//                            break
//                        }

//                        logThis(currentSelectedItem.x);
//                        currentSelectedItem.map

//                        logThis("abs0:" + Math.abs(newFocusedListView.preferredHighlightBegin - currentSelectedItem.x));
//                        logThis("abs1:" + Math.abs(newFocusedListView.preferredHighlightBegin - currentSelectedItem.x));

//                        var prevItemIndex;
//                        // TODO : -1 and +1 and 0
//                        if(root.moveDirection > 0){
//                            prevItemIndex = newFocusedListView.indexAt(nextItem2.x - 5, nextItem2.y)
//                        }else {
//                            prevItemIndex = newFocusedListView.indexAt(nextItem2.x + nextItem2.width + 5, nextItem2.y)
//                        }

//                        if(prevItemIndex === -1) {
//                            logThis("prevItem not found")
//                            break
//                        }else{
//                            logThis("prevItemIndex:"+prevItemIndex);
//                        }

//                        var contX = currentSelectedListView.contentX;
//                        logThis(contX + " " + newFocusedListView.contentX);
//                        newFocusedListView.focus = true;
//                        newFocusedListView.contentX = contX;
////                        newFocusedListView.positionViewAtIndex(prevItemIndex, ListView.Contain );
//                        newFocusedListView.currentIndex = prevItemIndex;
//                        newFocusedListView.contentX = contX;
//                        logThis(contX + " " + newFocusedListView.contentX);
//                        newFocusedListView.animateToItem(root.moveDirection);


//                        newFocusedListView.currentIndex = prevItemIndex + 1;
//                        newFocusedListView.incrementCurrentIndex();
//                        logThis(contX + " " + newFocusedListView.contentX);

//                        newFocusedListView.currentIndex = nextItemIndex2;


                          newFocusedListView.animateToItem(currentSelectedItem.x, currentSelectedItem.width);
                          newFocusedListView.focus = true;
//                        var nextItemIndex2 = newFocusedListView.indexAt(currentSelectedItem.x + currentSelectedItem.width*0.5, currentSelectedItem.y)
//                        if(nextItemIndex2 === -1) {
//                            nextItemIndex2 = newFocusedListView.indexAt(currentSelectedItem.x + currentSelectedItem.width*0.5 + 5, currentSelectedItem.y)
//                        }
//                        if(nextItemIndex2 === -1) {
//                            logThis("nextItemIndex2 not found:" + nextItemIndex2)
//                            break
//                        }

////                        //                console.log("nextItemIndex ", nextItemIndex);

//                        var contX = currentSelectedListView.contentX;
//////                        logThis(nextItemIndex + " current.contentX:" + contX + " newFocusedListView.contentX:" + newFocusedListView.contentX);

//                        newFocusedListView.focus = true;
//                        newFocusedListView.currentIndex = nextItemIndex2;
////                        newFocusedListView.contentX = contX;
                        break;
                    }
                }
            }

            delegate:
                Item {

                property alias eventsListView : eventsListView
                id : eventsRoot
                objectName : "0"
                height: 50
                width : ListView.width;

//                Keys.onPressed: {
//                    if(event.isAutoRepeat){
//                        logThis( "isAutoRepeat")
//                    }
//                    if(eventsListView.moving){
//                        logThis( "moving")
//                        event.accepted = true;
//                        return;
//                    }
//                    if(eventsListView.highlighting){
//                        logThis( "highlighting")
//                        event.accepted = true;
//                        return;
//                    }

//                    if(event.key === Qt.Key_Up) {
////                        logThis("highlighting:" + eventsListView.highlighting);
//                        event.accepted = true;
//                        ListView.view.nieco(-1, eventsListView);
//                    }
//                    else if(event.key === Qt.Key_Down) {
////                        logThis("highlighting:" + eventsListView.highlighting);
//                        event.accepted = true;
//                        ListView.view.nieco(1, eventsListView);
//                    }
//                }

                function moveUp() {
                    ListView.view.nieco(-1, eventsListView);
                }
                function moveDown() {
                    ListView.view.nieco(1, eventsListView);
                }

                Rectangle {
                    border.color : "green"
                    border.width: 5;
                    anchors.fill: textdata
                }
                Text {
                    id: textdata
                    text : model.modelData.name
                    color : "brown"
                    width : 100
                    height : eventsRoot.height
                }

                ListView {
                    id : eventsListView
                    anchors.left: textdata.right
//                    anchors.leftMargin: 150
                    width : eventsRoot.ListView.view.width - textdata.width
                    height : eventsRoot.height
                    orientation: ListView.Horizontal
                    model : streammodel
                    spacing : 0
                    clip: true
                    cacheBuffer : 0

                    property int moveDirection : 0;
                    property real nextItemX: 0
                    property real nextItemWidth: 0
                    property alias activeMove : shiftTimer.running

                    highlightMoveDuration: 200;
                    highlightMoveVelocity: 100;
                    highlightFollowsCurrentItem: true
                    highlightRangeMode : ListView.NoHighlightRange
//                    highlightRangeMode : ListView.StrictlyEnforceRange
                    preferredHighlightBegin: 50.0*root.scaleFactor;
                    preferredHighlightEnd: width - preferredHighlightBegin

                    signal animateToItem(real itemX, real itemWidth)

                    onAnimateToItem: {
                        nextItemX = itemX;
                        nextItemWidth = itemWidth;
                        shiftTimer.start()
                    }
                    Timer {
                        id : shiftTimer
                        interval: 10; repeat: false
                        onTriggered: {
                            logThis(eventsListView.nextItemX);
                            var nextItemIndex2 = eventsListView.indexAt(eventsListView.nextItemX + eventsListView.nextItemWidth*0.5, 5)
                            if(nextItemIndex2 === -1) {
                                nextItemIndex2 = eventsListView.indexAt(eventsListView.nextItemX + eventsListView.nextItemWidth*0.5 + 5.0, 5)
                            }
                            if(nextItemIndex2 === -1) {
                                eventsListView.forceLayout();
                                logThis("force layout");
                                nextItemIndex2 = eventsListView.indexAt(eventsListView.nextItemX + eventsListView.nextItemWidth*0.5, 5)
                                if(nextItemIndex2 === -1) {
                                    nextItemIndex2 = eventsListView.indexAt(eventsListView.nextItemX + eventsListView.nextItemWidth*0.5 + 5.0, 5)
                                }
                            }

                            if(nextItemIndex2 === -1) {
                                logThis("nextItemIndex2 not found:" + nextItemIndex2 + " x:" + eventsListView.nextItemX + " width:"+ eventsListView.nextItemWidth);
                                return;
                            }

                            eventsListView.currentIndex = nextItemIndex2;
                        }
                    }

                    Timer {
                        id : moveTimer
                        interval: 1; repeat: false
                        onTriggered: {
                            if(eventsListView.highlighting){
                                logThis( "moveTimer highlighting")
                                return;
                            }
                            if(eventsListView.moveDirection === 6){
                                eventsListView.incrementCurrentIndex();
                            } else if(eventsListView.moveDirection === 4){
                                eventsListView.decrementCurrentIndex();
                            }else if(eventsListView.moveDirection === 8) {
                                eventsRoot.moveUp();
                            }else if(eventsListView.moveDirection === 2) {
                                eventsRoot.moveDown();
                            }
                        }
                    }

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
                            eventsRoot.ListView.view.nieco2(eventsListView, contentX);
                        }
                    }

                    Keys.onPressed: {
                        if(eventsListView.moving || eventsListView.flicking){
                            event.accepted = true;
//                            logThis("moving");
                            return;
                        }
                        if(eventsListView.highlighting){
//                            logThis( "highlighting")
                            event.accepted = true;
                            return;
                        }

                        if(event.key === Qt.Key_Left) {
                            eventsListView.moveDirection = 4;
                            moveTimer.start();
                            event.accepted = true;

                        }else if(event.key === Qt.Key_Right) {
                            eventsListView.moveDirection = 6;
                            moveTimer.start();
                            event.accepted = true;
                        } if(event.key === Qt.Key_Up) {
                            eventsListView.moveDirection = 8;
                            moveTimer.start();
                            event.accepted = true;

                        }else if(event.key === Qt.Key_Down) {
                            eventsListView.moveDirection = 2;
                            moveTimer.start();
                            event.accepted = true;
                        }
                    }
                    Keys.onReleased: {
                        if(eventsListView.moving || eventsListView.flicking){
//                            logThis("moving");
                            event.accepted = true;
                        }
                        if(eventsListView.highlighting){
//                            logThis( "highlighting")
                            event.accepted = true;
                            return;
                        }
                        event.accepted = true;
                    }

                    delegate:
                        Rectangle {
                            id :streamText;
                            color :  ListView.isCurrentItem && ListView.view.activeFocus && !ListView.view.activeMove ? "Yellow" : "white"
                            border.color: "Green"
                            border.width: 1
                            width : Math.min(model.duration * pixelPerSeconds, 400)
                            height: 50

                            Text {
                                anchors.fill: parent
                                wrapMode: Text.Wrap
                                id : eventTitleText
                                text: streamText.x  +" "+  model.title
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
//        logThis("someListView.children:" + someListView.children + " length:" + someListView.children.length)

//        var childrens = someListView.children[0];
//        logThis("childrens.children:" + childrens.children + " length:" + childrens.children.length)

//        for(var i = 0; i < childrens.children.length; ++i){
//            logThis(childrens.children[i]);
//            logThis(childrens.children[i].eventsListViewChildren);

//        }



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
        someListView.currentItem.eventsListView.currentIndex = 0
        someListView.currentItem.eventsListView.positionViewAtIndex(0, ListView.SnapPosition)
        someListView.currentItem.eventsListView.focus = true

    }


}

