import QtQuick 2.0

Item {
    property alias model: view.model
    property alias delegate: view.delegate
    property alias currentIndex: view.currentIndex
//    property real itemHeight: 30

//    clip: true
    anchors.fill: parent
    PathView {
        id: view
        anchors.fill: parent
        focus: true
        snapMode: PathView.SnapOneItem

        pathItemCount: 5
//        preferredHighlightBegin: 0.5
//        preferredHighlightEnd: 0.5
//        highlight: Image { source: "spinner-select.png"; width: view.width; height: itemHeight+4 }
//        dragMargin: view.width/2

        path: Path {
//            startX: view.width/2; startY: -itemHeight/2
//            PathLine { x: view.width/2; y: view.pathItemCount*itemHeight + itemHeight }
//            startX: view.width/2;
//            startY: -itemHeight/2
//            PathLine {
//                x: view.width/2;
//                y: view.pathItemCount*itemHeight + itemHeight
//            }
            startX: 0
            startY: 0
            PathLine {
                x: parent.width;
                y: 0;
            }
        }


//        path: Path {
//            startX: 120; startY: 100
//            PathQuad { x: 120; y: 25; controlX: 260; controlY: 75 }
//            PathQuad { x: 120; y: 100; controlX: -20; controlY: 75 }
//        }

    }

    Keys.onDownPressed: view.incrementCurrentIndex()
    Keys.onUpPressed: view.decrementCurrentIndex()
}
