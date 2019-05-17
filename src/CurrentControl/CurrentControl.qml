import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

Page {
    id: page_d1
    visible: true
    //property int space_margin: 15
    //    width: 1200
    //    height: 800


    Pane {
        id: frame1
        //wheelEnabled: true
        width: 350
        anchors.margins: 0//8
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        padding: 0

        background: Rectangle {
            anchors.fill: parent
            color: Material.color(Material.Grey, Material.Shade800)
        }

        MyListViewUnfolding {
            anchors.fill: parent

            model:
                ListModel {
                    //id: animalsModel

                ListElement { name: "Карточка работника";           header: "" }

                //ListElement { name: "Касетница";                    header: "" }
                //ListElement { name: "Масс. выдача/ сдача дозиметр"; header: "" }
                //ListElement { name: "Конфигурация";                 header: "" }

                ListElement { name: "Типы дозиметров";    header: "Справочная информация" }
                ListElement { name: "Дозиметры";          header: "Справочная информация" }
                ListElement { name: "Касетницы";          header: "Справочная информация" }
                ListElement { name: "Зоны контроля";      header: "Справочная информация" }
                ListElement { name: "Подразделения";      header: "Справочная информация" }

                ListElement { name: "Ввод доз ТЛД";          header: "Ввод доз" }
                ListElement { name: "Ввод архивных доз ТЛД"; header: "Ввод доз" }

                ListElement { name: "Отчеты";                       header: "" }
                }

//            onCurrentName: {
//                //if(name === "Касетница") { stackview_mainwindow.replace(".qml")
//                if(name === "Карточка работника") { stackview_mainwindow.replace("WorkersCard.qml") }
//                else {stackview_mainwindow.replace("TestPage.qml")}
//            }

            onCurrentName: {
                var namePage
                switch(name) {
                case "Карточка работника":
                    namePage = "WorkersCard.qml";
                    break;

                case "Отчеты":
                    namePage = "Report_ESKID.qml";
                    break;

                default:
                    namePage = "TestPage.qml"
                    break;
                }
                stackview_mainwindow.replace(namePage)
                //if(name === "Касетница") { stackview_mainwindow.replace(".qml") }
            }


        }

    }

    StackView {
        id: stackview_mainwindow
        anchors.left: frame1.right
        anchors.right: parent.right
        //anchors.rightMargin: 250
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 70

        initialItem: "WorkersCard.qml"

        replaceEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 0
            }
        }
        replaceExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 0
            }
        }

    }


    /// индикаторы сосотояний подключения
    Rectangle {
        anchors.bottom: rect_status_.top
        anchors.margins: 10
        anchors.right: parent.right
        anchors.rightMargin: 15

        width: 1120
        height: 1
        color: "LightGray"

    }
    Rectangle {
        id: rect_status_
        border.color: "LightGray"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: 170
        height: 40
        anchors.margins: 15

        Connections {
                target: managerDB

                onSignalSendGUI_status: {
                    //txt_statusConnection.text = message;
                    if(message=="begin"){
                        txt_statusConnection.append("<p style='color:#9cc17f'>" + message + "</p>") //txt_statusConnection.text = message;
                        indicatorConnect_0.lightOff();
                        indicatorConnect_1.lightOff();
                        //indicatorConnect_local.lightOff();
                    }
                    else
                    {
                        txt_statusConnection.append(message);
                    }

                    if(status) {
                        txt_nameConnection.text = currentConnectionName;
                        //indicatorConnect_local.lightOff();

                        if(currentConnectionName=="machine 0") {
                            indicatorConnect_0.lightTrue();
                        }
                        if(currentConnectionName=="machine 1") {
                            indicatorConnect_1.lightTrue();
                        }
                        if(currentConnectionName=="0") {
                            //indicatorConnect_local.lightTrue();
                            txt_nameConnection.text = "local machine"
                        }

                    }
                    else {
                        //indicatorConnect_local.lightOff();
                        if(currentConnectionName=="machine 0") {
                            indicatorConnect_0.lightFalse();
                        }
                        if(currentConnectionName=="machine 1") {
                            indicatorConnect_1.lightFalse();
                        }
                    }



                }

         }


        Rectangle {
            id: rect_statusConnection
            property bool isButton_clear: false
            anchors.right: parent.left
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            //anchors.top: parent.top
            width: 300
            height: 40
            border.color: "LightGray"

            Flickable {
                id: flickable_txt_STATUSCONNECT
                anchors.fill: parent
                //anchors.margins: 2
                anchors.leftMargin: 20

                TextArea.flickable: TextArea {
                    id: txt_statusConnection
                    font.pointSize: 10
                    textFormat: Text.RichText /// для использования html форматирования текста
                    //anchors.fill: parent
                    wrapMode: TextArea.Wrap
                    color: Material.color(Material.Grey)
                }

                ScrollBar.vertical: ScrollBar { }
            }
            MouseArea {
                anchors.fill:parent
                hoverEnabled: true

                //onClicked: {rect_statusConnection.height = 400}
                onEntered: {
                    rect_statusConnection.height = 400
                    flickable_txt_STATUSCONNECT.anchors.margins = 20
                    txt_statusConnection.font.pointSize = 9
                    txt_button_clear.opacity = 0.2
                }
                onExited:  {
                    rect_statusConnection.height = 40
                    flickable_txt_STATUSCONNECT.anchors.margins = 0
                    txt_statusConnection.font.pointSize = 10
                    txt_button_clear.opacity = 0.0
                }
                onPositionChanged: {
                    if(    mouseX >= button_clear.x && mouseX <= (button_clear.x+button_clear.width)
                        && mouseY >= button_clear.y && mouseY <= (button_clear.y+button_clear.height) )
                    {
                        button_clear.border.color = "LightGray"
                        txt_button_clear.opacity = 0.6
                        rect_statusConnection.isButton_clear = true
                    }
                    else {
                        button_clear.border.color = "transparent"
                        txt_button_clear.opacity = 0.2
                        rect_statusConnection.isButton_clear = false
                    }
                }
                onClicked: {
                    if(rect_statusConnection.isButton_clear) {txt_statusConnection.clear()}
                }

            }
            Rectangle {
                id: button_clear
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.margins: 14
                width: 50
                height: 20
                Text {
                    id: txt_button_clear
                    anchors.centerIn: parent
                    text: qsTr("Clear")
                    opacity: 0.0
                }

            }
        }




        Item {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right

            TextEdit {
                id: txt_nameConnection
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10



                font.pixelSize: 12
                text: "-"
                color: Material.color(Material.Grey)
                selectByMouse: true
                //selectionColor: Material.color(Material.Red)
            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10

                border.color: "LightGray"
                radius: 5
                width: 70
                height: 25
                Row {
                    anchors.centerIn: parent
                    spacing: 10
                    LightIndicator { id: indicatorConnect_0;  height: 15; width: 15 }
                    LightIndicator { id: indicatorConnect_1;  height: 15; width: 15 }
//                    Rectangle      { height: 15; width: 1; color: "LightGray" }
//                    LightIndicator { id: indicatorConnect_local;  height: 15; width: 15; style: false }

                }
            }

        }

    }


}

