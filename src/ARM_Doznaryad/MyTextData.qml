import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    id: labeltext
    property string label1_name: ""
    property string text1_value: ""
    property string label2_name: ""
    property string text2_value: ""

    property alias l1width: l1.width
    property alias l2width: l2.width
    property alias t1width: t1.width
    property alias t21width: t2.width

    property int font_pointsize: 10
    height: l1.height
    width: l1.width + t1.width + l2.width + t2.width//360
    Row {

        Label {
            id: l1
            //Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            width: 120
            text: label1_name
            horizontalAlignment: Text.AlignLeft
            //verticalAlignment: Text.AlignVCenter
            font.pointSize: font_pointsize
            rightPadding: 5
        }

        Text {
            id: t1
            width: 100
            //Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            //leftPadding: 10
            text: text1_value
            //verticalAlignment: Text.AlignVCenter
            font.pointSize: font_pointsize
            color: "steelblue"
            //anchors.left: l1.right

        }

        Label {
            id: l2
            //Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            text: label2_name
            //verticalAlignment: Text.AlignVCenter
            font.pointSize: font_pointsize
            leftPadding: 30
            rightPadding: 5
            //anchors.left: t1.right
        }

        Text {
            id: t2
            //Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            text: text2_value
            //verticalAlignment: Text.AlignVCenter
            font.pointSize: font_pointsize
            color: "steelblue"
            //anchors.left: l2.right
        }
    }
}
