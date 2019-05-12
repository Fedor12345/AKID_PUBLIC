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
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50

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

    Rectangle {
        id: rect_status_
        border.color: "LightGray"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: 180
        height: 40
        anchors.margins: 15

        Connections {
                target: managerDB

                onSignalSendGUI_status: {
                    if(message=="begin"){
                        indicatorConnect_0.lightOff();
                        indicatorConnect_1.lightOff();
                        indicatorConnect_local.lightOff();
                    }

                    if(status) {
                        txt_nameConnection.text = currentConnectionName;

                        if(currentConnectionName=="machine 0") {
                            indicatorConnect_0.lightTrue();
                        }
                        if(currentConnectionName=="machine 1") {
                            indicatorConnect_1.lightTrue();
                        }
                        if(currentConnectionName=="0") {
                            indicatorConnect_local.lightTrue();
                            txt_nameConnection.text = "local machine"
                        }

                    }
                    else {
                        if(currentConnectionName=="machine 0") {
                            indicatorConnect_0.lightFalse();
                        }
                        if(currentConnectionName=="machine 1") {
                            indicatorConnect_1.lightFalse();
                        }
                    }


//                    if(status) txt_nameConnection.text = currentConnectionName; //.append(currentConnectionName)
//                    if(currentConnectionName=="0") {
//                        txt_nameConnection.text = "local machine"
//                        indicatorConnect_0.lightOff();
//                        indicatorConnect_1.lightOff();
//                        indicatorConnect_local.lightTrue();
//                    }
//                    if(currentConnectionName=="machine 0") {
//                        indicatorConnect_local.lightOff();
//                        if(status) {
//                            //indicatorConnect_1.lightOff();
//                            indicatorConnect_0.lightOff();
//                            indicatorConnect_0.lightTrue();
//                        }
//                        else {
//                            //indicatorConnect_1.lightOff();
//                            indicatorConnect_0.lightOff();
//                            indicatorConnect_0.lightFalse();
//                        }
//                    }
//                    if(currentConnectionName=="machine 1") {
//                        indicatorConnect_local.lightOff();
//                        if(status) {
//                            //indicatorConnect_0.lightOff();
//                            indicatorConnect_1.lightOff();
//                            indicatorConnect_1.lightTrue();
//                        }
//                        else {
//                            //indicatorConnect_0.lightOff();
//                            indicatorConnect_1.lightOff();
//                            indicatorConnect_1.lightFalse();
//                        }
//                    }
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
                width: 80
                height: 25
                Row {
                    anchors.centerIn: parent
                    spacing: 10
                    LightIndicator { id: indicatorConnect_0;  height: 15; width: 15 }
                    LightIndicator { id: indicatorConnect_1;  height: 15; width: 15 }
                    LightIndicator { id: indicatorConnect_local;  height: 15; width: 15; style: false }

                }
            }

        }



    }


}

























































































/*##^## Designer {
    D{i:0;height:800;width:1200}
}
 ##^##*/
