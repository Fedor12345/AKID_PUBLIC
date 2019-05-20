import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: window
    visible: true
    width: 1200
    height: 800
    title: qsTr(".: АРМ Электронный дознаряд")

    Connections {
            target: managerDB
            onSignalBlockingGUI: {
                popup_wait.open();
            }
            onSignalUnlockingGUI: {
                popup_wait.close();
            }
    }

    Popup {
        id: popup_wait
        modal: true
        //focus: true
        closePolicy: Popup.NoAutoClose
        parent: Overlay.overlay
        x: parent.width-50    //Math.round((parent.width - width) / 2)
        y: -2   //Math.round((parent.height - height) / 2)
        padding: 0

        Overlay.modal: Rectangle {
            color: "transparent"
        }

        background: Rectangle {
            anchors.fill: parent
            color: "Transparent"//"White" Material.color(Material.Grey, Material.Shade200)
        }

        MyBusyIndicator {
            biwidth:  40
            biheight: 40
            biradius: 4
            running:  true
        }
    }

    StackView {
        id: stackView
        initialItem: "StartPage.qml"
        anchors.fill: parent
    }
}
