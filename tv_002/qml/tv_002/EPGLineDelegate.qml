import QtQuick 2.0

Component {
    Rectangle {
//            anchors.centerIn: parent
        id: lineDelegateRoot
        height : 55.0 * _scaleFactor;
        width: 220.0 * _scaleFactor;

        color: lineDelegateRoot.ListView.isCurrentItem ? selectedItemColor : defaultItemColor

        Text {
            verticalAlignment: Text.AlignVCenter
            id: tabText
            color: lineDelegateRoot.ListView.isCurrentItem ? selectedFontColor : defaultFontColor
            text: title
//                smooth: true
            font.family: textFont
            font.pointSize: 28.0 * _scaleFactor
            anchors.centerIn: parent
        }
    }
}
