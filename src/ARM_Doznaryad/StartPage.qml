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

    Login {
        id: login
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        onLogin_OK: {
            stackView.push("Doznaryad.qml")
        }
    }

}

