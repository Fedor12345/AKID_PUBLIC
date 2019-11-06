import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    id: login_page

    header: ToolBar {
        Label {
            text: qsTr("Регистрация")
            anchors.centerIn: parent
            font.pointSize: 16
        }
    }

    Text {
        id: txt_1231
        anchors.top: parent.top
        font.pixelSize: 20
        text: qsTr("text")
    }

    Login {
        id: login
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        onLogin_OK: {
            stackView.popup_waitON = true
            txt_1231.text = "OK! " + stackView.popup_waitON
            stackView.push("CurrentControl.qml")
        }
    }

}
