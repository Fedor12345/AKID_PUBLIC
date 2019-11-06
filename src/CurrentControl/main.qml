import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

ApplicationWindow {
    id: window
    visible: true
    minimumWidth: 1600
    minimumHeight: 800
    //width: 1600
    //height: 800
    title: qsTr(".: АРМ Текущий контроль")

    Component.onCompleted: console.log("main qml        completed")

    // Блокировка интерфейса с отображающимся индикатором загрузки
    Popup {
        id: popup_wait

        property bool waitON: stackView.popup_waitON

        modal: true
        //focus: true
        closePolicy: Popup.NoAutoClose
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        padding: 0

        Overlay.modal: Rectangle {
            color: "transparent"
        }
        background:
            Rectangle {
            anchors.fill: parent
            color: "Transparent" //"White" Material.color(Material.Grey, Material.Shade200)
        }
        MyBusyIndicator {
            biwidth:  40
            biheight: 40
            biradius: 4
            running: true
            visible: popup_wait.waitON ? true : false
        }
    }

    // Включение и отключение блокировки интерфейса по срабатыванию сигналов
    // из потока с waitDB
    Connections {
        target: managerDB
        onSignalBlockingGUI: {
            ///popup_wait.open();
        }
        onSignalUnlockingGUI: {
           /// popup_wait.close();
        }
    }


    // StackView с начальной загрузкой страницы StartPage.qml с формой
    // для ввода имени/пароля пользователя БД.
    // В случае успешной авторизации загрузка страницы CurrentControl.qml
    StackView {
        id: stackView
        initialItem: "StartPage.qml"
        anchors.fill: parent

        property bool popup_waitON: false


        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 100
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 100
            }
        }
    }

}










