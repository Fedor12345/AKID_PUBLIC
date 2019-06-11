import QtQuick 2.12
import QtQuick.Controls 2.5

import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

import QtQuick.Dialogs 1.2


Page {
    id: page_reports
    property int space_margin: 15
    property var model_SQLQiueries

//    Label {
//        anchors.centerIn: parent
//        text:"report_ESKID_&"
//    }

    Rectangle {
        id: rect_page_header
        height: 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: space_margin

        color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
        border.color: "LightGray"
        radius: 7

        Label {
            anchors.centerIn: parent
            text: "ОТЧЕТЫ"
            font.pixelSize: 14
            font.bold: true
        }

    }

    Rectangle {
        id: rectMain_SQLQueries
        anchors.top: rect_page_header.bottom
        anchors.topMargin: 20
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 20
        width: 350

        //border.color: "LightGray"
        color: "transparent"

        Rectangle {
            id: rect_SQLQueries_header
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 50


            color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
            border.color: "LightGray"
            radius: 7

            Label {
                anchors.centerIn: parent
                text: "Список SQL запросов"
                font.pixelSize: 14
                font.bold: true
            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                width: 40
                height: 40
                color: "transparent"
                border.color: "LightGray"
                radius: 7
                Text {
                    id: txtButton_addQuery
                    anchors.centerIn: parent
                    text: "+"
                    font.pixelSize: 20
                    color: "LightGray"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered:  { parent.border.color = "#35dd89";   txtButton_addQuery.color = "#35dd89" }
                    onExited:   { parent.border.color = "LightGray"; txtButton_addQuery.color = "LightGray" }
                    onPressed:  { parent.color = "#f6ffed";          popup_addQuery.open() }
                    onReleased: { parent.color = "transparent" }
                    //onClicked:  {}
                }

            }
//            Button {
//                anchors.verticalCenter: parent.verticalCenter
//                anchors.right: parent.right
//                anchors.rightMargin: 10
//                width: 30
//                height: 40
//                text: "+"
//                font.pixelSize: 30
//            }

            Popup {
                id: popup_addQuery
                width: addQuery.width + padding*2
                height: addQuery.height + padding*2
                modal: true
                focus: true
                closePolicy: Popup.CloseOnEscape
                parent: Overlay.overlay
                x: Math.round((parent.width - width) / 2)
                y: Math.round((parent.height - height) / 2)
                padding: 0
                Item {
                    id: addQuery
                    height: 200
                    width:  900

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 10
                        color: "LightGray"
                        border.color: "LightGray"
                    }
                    RowLayout {
                        id: row_SQL
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        //anchors.topMargin: 20
                        anchors.margins: 20
                        spacing: 40

                        Label {
                            id: lebelQuerySQL
                            Layout.minimumWidth: 50
                            Layout.preferredWidth: 50
                            text: "SQL вопрос:"

                        }
                        TextField {
                            id: txtFieldQuerySQL
                            Layout.fillWidth: true
                            Layout.preferredWidth: 100
                            anchors.margins: 5
                            selectByMouse: true
                            wrapMode: TextEdit.WordWrap
                            //color: "#eeeeee"
                        }
                    }

                    RowLayout {
                        id: row_description
                        anchors.top: row_SQL.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.margins: 20
                        spacing: 40

                        Label {
                            Layout.minimumWidth: 50
                            Layout.preferredWidth: 50
                            text: "Описание:"
                        }
                        TextField {
                            id: txtFieldQueryDescription
                            Layout.fillWidth: true
                            Layout.preferredWidth: 100
                            anchors.margins: 5
                            selectByMouse: true
                            wrapMode: TextEdit.WordWrap
                            //color: "#333333"
                        }
                    }

                    Button {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.horizontalCenter
                        anchors.margins: 20
                        anchors.rightMargin: 5
                        Material.background: Material.LightGreen
                        //Material.foreground: Material.Orange
                        text: "Добавить запрос"
                        font.pixelSize: 14
                    }
                    Button {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.horizontalCenter
                        anchors.right: parent.right
                        anchors.margins: 20
                        anchors.leftMargin: 5
                        highlighted: true
                        Material.background: Material.LightBlue
                        //Material.foreground: Material.Orange
                        text: "Отмена"
                        font.pixelSize: 14
                        //highlighted: true
                        //Material.accent: Material.Orange
                        onClicked: {
                            popup_addQuery.close()
                        }
                    }
                }
            }

        }

        Rectangle {
            id: rect_SQLQueriesList
            anchors.top: rect_SQLQueries_header.bottom
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
            border.color: "LightGray"
            radius: 7

            ListView {
                id: list_SQLQueries
                anchors.fill: parent
                anchors.margins: 5
                currentIndex: -1 //0
                property var id_currentPerson //: page_reports.model_SQLQiueries.getId(currentIndex)

                highlightFollowsCurrentItem: true

                model: page_reports.model_SQLQiueries

                ScrollBar.vertical: ScrollBar {
                    policy: "AlwaysOn"
                }

                clip: true
                delegate:
                    ItemDelegate {
                    id: delegate_SQLqueryList
                    width: list_SQLQueries.width - 20 // 210
                    height: txt_delegate_SQLqueryList_1.height + txt_delegate_SQLqueryList_2.height + 15 //60 //implicitContentHeight
                    Row {
                        spacing: 5
                        Rectangle {
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            width: 15
                            color: "transparent"
                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                //anchors.rightMargin: 5
                                text: index
                                font.pixelSize: 15
                                color: "#999999"
                            }
                        }

                        Rectangle {
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            width: 1
                            color: "Lightgray"
                        }
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        Column {
                            Text {
                                id: txt_delegate_SQLqueryList_1
                                text: DESCRIPTION
                                font.pixelSize: 14
                                width: delegate_SQLqueryList.width - 30
                                color: {
                                 if (list_SQLQueries.currentIndex == index) { "#FF5722" }
                                 else { "#4c4c4c" }
                                }
                                wrapMode: Text.WordWrap
                                //font.bold: true
                            }
                            Text {
                                id: txt_delegate_SQLqueryList_2
                                text: SQLQUERY
                                font.pixelSize: 10
                                width: delegate_SQLqueryList.width - 30
                                color: "#777777"
                                wrapMode: Text.WordWrap
                            }
                        }

                    }

                    onClicked: {
                        if (list_SQLQueries.currentIndex !== index) {
                            list_SQLQueries.currentIndex = index
                        }
                        list_SQLQueries.id_currentPerson = page_reports.model_SQLQiueries.getId(index)
                        //id_currentPersonChange(list_SQLQueries.id_currentPerson)
                    }
                }

                highlight: Rectangle {
                    color: "transparent" // "#FF5722" //"#c9c9c9" // "#B0BEC5" //Material.color(Material.Grey, Material.Shade700)
                    border.color: "#FF5722"
                }
                highlightMoveDuration: 200

            }

        }



    }


    Rectangle {
        id: rectMain_Table
        anchors.top: rect_page_header.bottom
        //anchors.topMargin: 20
        anchors.bottom: parent.bottom
        anchors.left: rectMain_SQLQueries.right
        //anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.margins: 20

        color: "transparent"
        //border.color: "LightGray"


        Rectangle {
            id: rect_Table_header
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 50


            color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
            border.color: "LightGray"
            radius: 7

            Label {
                anchors.centerIn: parent
                text: "Данные по запросу"
                font.pixelSize: 14
                font.bold: true
            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                width: 170
                height: 40
                color: "transparent"
                border.color: "LightGray"
                radius: 7
                Text {
                    id: txtButton_CreateFileReport
                    anchors.centerIn: parent
                    text: "Оформить в виде файла"
                    font.pixelSize: 14
                    color: "LightGray"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered:  { parent.border.color = "#35dd89";   txtButton_CreateFileReport.color = "#35dd89" }
                    onExited:   { parent.border.color = "LightGray"; txtButton_CreateFileReport.color = "LightGray" }
                    onPressed:  { parent.color = "#f6ffed" }
                    onReleased: { parent.color = "transparent" }
                    //onClicked:  {}
                }

            }
        }


        Rectangle {
            id: rect_Table
            anchors.top: rect_Table_header.bottom
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
            border.color: "LightGray"
            radius: 7


        }





    }






}
