import QtQuick 2.0


ListView {
    property color defaultItemColor : "#7F000000"
    property color selectedItemColor : "white"
    property color defaultFontColor : "white"
    property color selectedFontColor : "black"
    property string textFont
//    property alias textFont : lineDelegate.rectangle1.tabText.font.family

//    Component {
//        id: lineDelegate
//        Rectangle {
////            anchors.centerIn: parent
//            id: lineDelegateRoot
//            height : 55.0 * _scaleFactor;
//            width: 220.0 * _scaleFactor;

//            color: lineDelegateRoot.ListView.isCurrentItem ? selectedItemColor : defaultItemColor

//            Text {
//                verticalAlignment: Text.AlignVCenter
//                id: tabText
//                color: lineDelegateRoot.ListView.isCurrentItem ? selectedFontColor : defaultFontColor
//                text: title
////                smooth: true
//                font.family: textFont
//                font.pointSize: 28.0 * _scaleFactor
//                anchors.centerIn: parent
//            }
//        }
//    }

    orientation : ListView.Vertical
    highlightRangeMode : ListView.ApplyRange
    preferredHighlightBegin: 0 * _scaleFactor
    preferredHighlightEnd: 0 * _scaleFactor


    delegate: EPGLineDelegate{}
    highlightFollowsCurrentItem: true
    spacing: 10 * _scaleFactor
    cacheBuffer: 128
    clip:true

                    Rectangle{
                        color: "Red"
                        y:parent.preferredHighlightBegin ; x:0
                        height: 1; width: parent.width
                    }

                    Rectangle{
                        color: "Red"
                        y:parent.preferredHighlightEnd ; x:0
                        height: 1; width: parent.width
                    }

    highlightMoveDuration: 400;
    highlightResizeDuration: 200;
    highlightMoveVelocity: 200;
}
