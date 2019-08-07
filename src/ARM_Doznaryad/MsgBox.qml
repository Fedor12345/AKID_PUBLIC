import QtQuick 2.12
import QtQuick.Controls 2.5
//import QtQuick.Layouts 1.3
//import QtQuick.Controls.Material 2.3

//import Foo 1.0


Item {
    id: msgbox_root
    height: 200//550
    width:  400

    signal clickOK()
    signal clickCancel()

    property alias runnig: mbi.running
    property alias btn_enabled:  ok_button.enabled
    property alias msgtext: msg_text.text

    state: "info"
    states: [
        State {
            name: "info"
            PropertyChanges {
                target: cancel_button
                visible: false
            }
            PropertyChanges {
                target: mbi
                visible: true
            }
        },
        State {
            name: "question"
            PropertyChanges {
                target: cancel_button
                visible: true
            }
            PropertyChanges {
                target: mbi
                visible: false
            }
        }
    ]

    Rectangle {
        //id: header_rectangle
        color:  "mediumseagreen" //"seagreen" //
        width: parent.width
        height: 40
        Label {
            //id: header_caption
            text: "Info"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            font.pixelSize: 16
            color: "White"
            font.bold: true
        }
    }

    MyBusyIndicator {
        id: mbi
        anchors.horizontalCenter: parent.horizontalCenter
        running: true
    }

    Text {
        id: msg_text
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text: qsTr("Запись успешно обновлена")
        font.pixelSize: 16
        visible: (text.length > 0) ? true : false
    }

    Button {
        id: ok_button
        width: 120
        //anchors.margins: 10
        anchors.bottomMargin: 10
        anchors.rightMargin: 20
        text: "OK"
        font.pixelSize: 14
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        enabled: false

        onClicked: {
            console.log("msgbox:"+msgbox_root.state)

            if (msgbox_root.state === "info") {
                clickCancel()
            } else {
                clickOK()
            }
        }
    }

    Button {
        id: cancel_button
        width: 120
        //anchors.margins: 10
        anchors.bottomMargin: 10
        anchors.leftMargin: 20
        text: "Отмена"
        font.pixelSize: 14
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        onClicked: {
            clickCancel()
        }
    }



}
