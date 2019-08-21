import QtQuick 2.12
import QtQuick.Controls 2.5

import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

import QtQuick.Dialogs 1.2


Page {
    id: page_report_ESKID
    property int space_margin: 15
    property var id_currentPerson

//    Label {
//        anchors.centerIn: parent
//        text:"report_ESKID_&"
//    }
    Frame {
        id: frame_header

        height: 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: space_margin
        padding: 1
        topPadding: 1
        bottomPadding: 1
        leftPadding: 30

        background: Rectangle {
            anchors.fill: parent
            color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
            border.color: "LightGray"
            radius: 7
            //border.width: 1
        }

        Row {
            id: row
            spacing: 10
            Text {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20 //main_.sizeTxt
                font.bold: true
                color: "#808080"
                text: "ОТЧЕТЫ"
            }
            ToolSeparator {}
            Text {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20 //main_.sizeTxt
                font.bold: true
                color: "#808080"
                text: "№ 1-ДОЗ"
            }
        }
    }




    Rectangle {
        id: rect_WORKERorWORKERS
        width: 300
        height: 210
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: frame_header.bottom
        anchors.topMargin: space_margin

        property string state: "one"

        color: "White"
        border.color: "LightGray"


        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            font.pixelSize: 18
            text: "Один или несколько сотрудников" //"Количество сотрудников"
        }


        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 55

            Rectangle {
                id: rect_ONE
                width: 115
                height: 130

                border.color: "LightGray"

                Image {
                    id: img_ONE
                    opacity: 0.2
                    sourceSize.height: 100
                    sourceSize.width: 100
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "icons/face.svg"
                }

                MouseArea {
                    id: ma_ONE
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered:  { img_ONE.opacity = 0.5; rect_ONE.border.color = "Gray" }
                    onExited:   { img_ONE.opacity = 0.2; rect_ONE.border.color= "LightGray" }
                    onPressed:  img_ONE.opacity = 0.6
                    onReleased: img_ONE.opacity = 0.5
                    onClicked: rect_WORKERorWORKERS.state = "one"
                }

                //всплывающая подсказка
                ToolTip {
                    id: toolTip_ONE
                     parent: rect_ONE //.handle
                     text: qsTr("Один сотрудник")
                     y: rect_ONE.y + rect_ONE.height + 5
                     font.pixelSize: 15

                     //anchors.centerIn: parent
                     visible: ma_ONE.containsMouse //"Один сотрудник" ? ma_ONE.containsMouse : false //hovered
                     delay: 800 //задержка
                     contentItem: Text {
                         text: toolTip_ONE.text
                         font: toolTip_ONE.font
                         color: "white" //"#21be2b"
                     }

 //                    background: Rectangle {
 //                        border.color: "#21be2b"
 //                    }
                }
//                ToolTip.text: "Один сотрудник"
//                ToolTip.visible: "Один сотрудник" ? ma_ONE.containsMouse : false

            }

            Rectangle {
                id: rect_MANY
                width: 115
                height: 130

                border.color: "LightGray"

                Image {
                    id: img_MANY
                    opacity: 0.2
                    sourceSize.height: 100
                    sourceSize.width: 100
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "icons/faces_2.svg"

                }

                MouseArea {
                    id: ma_MANY
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered:  { img_MANY.opacity = 0.5; rect_MANY.border.color = "Gray" }
                    onExited:   { img_MANY.opacity = 0.2; rect_MANY.border.color= "LightGray" }
                    onPressed:  img_MANY.opacity = 0.6
                    onReleased: img_MANY.opacity = 0.5
                    onClicked: rect_WORKERorWORKERS.state = "many"
                }

                //всплывающая подсказка
                ToolTip {
                    id: toolTip_MANY
                    parent: rect_MANY //.handle
                    text: qsTr("Подразделение")
                    font.pixelSize: 15

                    y: rect_MANY.y + rect_MANY.height + 5
                    //anchors.centerIn: parent
                    visible: ma_MANY.containsMouse // "Подразделение" ? ma_MANY.containsMouse : false //hovered
                    delay: 800 //задержка

                    contentItem: Text {
                        text: toolTip_MANY.text
                        font: toolTip_MANY.font
                        color: "white" //"#21be2b"
                    }

//                    background: Rectangle {
//                        border.color: "#21be2b"
//                    }
                }
            }


//            RadioButton {
//                checked: true
//                text: qsTr("Один")
//                onClicked: {rect_WORKERorWORKERS.state = "one"; console.log("state = ") + rect_WORKERorWORKERS.state}
//            }
//            RadioButton {
//                text: qsTr("Несколько")
//                onClicked: {rect_WORKERorWORKERS.state = "many"; console.log("state = ") + rect_WORKERorWORKERS.state}
//            }
        }

    }

    Rectangle {
        id: rect_TABorDEPARTMENT
        width: 300
        height: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: rect_WORKERorWORKERS.bottom
        anchors.topMargin: space_margin

        color: "White"
        border.color: "LightGray"

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            font.pixelSize: 18
            text: (rect_WORKERorWORKERS.state==="one") ? "Табельный номер сотрудника" : "Номер подразделения"
        }
        TextField {
            id: idWorker
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 40
            selectByMouse : true
            font.pixelSize: 16
        }

    }

    Rectangle {
        id: rect_YEAR
        width: 300
        height: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: rect_TABorDEPARTMENT.bottom
        anchors.topMargin: space_margin

        color: "White"
        border.color: "LightGray"

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            font.pixelSize: 18
            text: "Выберите год"
        }

        Rectangle {
            id: year_
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 50
            width: 100
            height: 30
            //visible: false
            border.color: "LightGray"
            Text {
                anchors.centerIn: parent
                font.pixelSize: 18
                text: popup_findYear.selectYear // qsTr("2019")
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    model_year.clear()
                    var thisYear = 2019 // брать из календаря
                    for(var i_year = thisYear; i_year > 1900; i_year --) {
                        model_year.append({ name: i_year })
                    }
                    popup_findYear.open();
                    console.log("Index = ", gridYear.currentIndex);
                }

                hoverEnabled: true
                onEntered:  { year_.color = Material.color(Material.Lime) }
                onExited:   { year_.color = "White" }
                onPressed:  { year_.color = "#E6EE9C"  /*Material.color(Material.LightGreen) */}
                onReleased: { year_.color = "White" }

            }
        }

        Popup {
            id: popup_findYear
            width:  380 //year_.width
            height: 350 //(listview_popup.contentHeight > 200) ? 200 : (listview_popup.contentHeight + popup_findYear.padding*2)

            y: year_.y - 80 //+year_.height
            x: year_.x + 180  //- 100
            padding: 8

            property var selectYear: 2019 //изначально должен определяться текущий год


            Rectangle {
                //anchors.fill: parent;
                anchors.bottom: parent.top
                height: 50
                width: 50
                border.color:  "LightGray"

                Image {
                    id: img_Year
                    //opacity: 0.7
                    anchors.fill: parent
                    anchors.margins: 10
                    source: "icons/calendar.svg"
                }


            }


            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

                Row {
                    id: row_selectYears
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 2
                    Rectangle {
                        width:  30
                        height: 30
                        //border.color: "LightGray"
                        Image {
                            anchors.centerIn: parent
                            source: "icons/menu-left.svg"
                        }
                    }
                    Rectangle {
                        width:  300
                        height: 30
                        //border.color: "LightGray"
                        Text {
                            id: txt_deltaYears
                            anchors.centerIn: parent
                            font.pixelSize: 20
                            font.bold: true
                            text: {
                                var from   = Math.floor(popup_findYear.selectYear/10) * 10;
                                var before = Math.ceil (popup_findYear.selectYear/10) * 10 - 1;
                                //console.log("from - before = " + from + " - " + before);
                                return (from + " - " + before);
                            }
                        }
                    }
                    Rectangle {
                        width:  30
                        height: 30
                        //border.color: "LightGray"
                        Image {
                            anchors.centerIn: parent
                            source: "icons/menu-right.svg"
                        }
                    }
                }


                ListModel { // года добавляются в модель по нажатию на элемент year_
                    id: model_year
                    ListElement {
                        name: 2019
                    }
                }
                Rectangle {
                    anchors.top: row_selectYears.bottom
                    anchors.topMargin: 10
                    anchors.left: parent.left
                    //anchors.leftMargin: 10
                    anchors.right: parent.right
                    //anchors.rightMargin: 10
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    border.color: "LightGray"
                    layer.enabled: true
                    GridView {
                        id: gridYear
                        anchors.fill: parent
                        anchors.margins: 10
//                        currentIndex: 2
                       // highlightRangeMode: GridView.StrictlyEnforceRange  //ListView.StrictlyEnforceRange
                        cellWidth: 85; cellHeight: 85
                        //ScrollBar.horizontal: ScrollBar { }

                        model: model_year
                        delegate: ItemDelegate {
                            width: 85
                            height: 85
                            Text {
                                anchors.centerIn: parent
                                text:name
                                font.pixelSize: 20
                            }
                            onClicked: {
                                if (gridYear.currentIndex !== index) {
                                    gridYear.currentIndex = index
                                }
                                popup_findYear.close()
                                popup_findYear.selectYear = name
                            }
                        }

                        highlight: Rectangle { color: "LightGray"}
                        //focus: true
                        //highlightMoveDuration: 200

                    }
                }
        }

    }




    Connections {
        id: report_query
        target: Query1

        onSignalSendResult: {
            if (res) {
                //completedZ = 0;
                if (owner_name == "Report_1DOZ") {
                    console.log("Генерируем отчет...");
                    console.log(" var_res ==== ", var_res, " ", var_res["Z1"], var_res["Z2"], var_res["Z3"], var_res["Z4"]);
                    report.setZ(var_res);
                    report.beginCreateReport1DOZ();
                    report.showZ();
                    report.clearZ();
                }
            }
        }
    }
    Button {
        id: button_CREATEREPORT
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: rect_YEAR.bottom
        anchors.topMargin: space_margin

        width: 200
        font.pointSize: 16
        text: "СОЗДАТЬ ОТЧЕТ"
        onClicked: {
            //report.createReport(idWorker.text)
            report.setTypeReport(12);
            var querySQL =
                    " SELECT SNILS Z1, BIRTH_DATE Z2, " +
                    " ADM_ASSIGNEMENT.ASSIGNEMENT_CODE Z3, ADM_ASSIGNEMENT.ASSIGNEMENT Z4," +
                    " STATUS_CODE Z5, SEX Z6, "  +
                    " ( COALESCE(EXT_DOSE.TLD_B_HP3,0) + COALESCE(EXT_DOSE.TLD_B_HP007,0) + COALESCE(OP_DOSE.EPD_B_HP3,0) + COALESCE(OP_DOSE.EPD_B_HP007,0) ) Z7, " +
                    " ( COALESCE(EXT_DOSE.TLD_G_HP10,0) + COALESCE(OP_DOSE.EPD_G_HP10,0) ) Z8, "  +
                    " ( COALESCE(EXT_DOSE.TLD_N_HP10,0) + COALESCE(OP_DOSE.EPD_N_HP10,0) ) Z9, "  +
                    " ( COALESCE(IN_CONTROL.EXP_EFF_DOSE_C,0) + COALESCE(IN_MEASURE.EXP_EFF_DOSE_M,0) + COALESCE(IN_IODINE.EXP_EFF_DOSE_I,0) ) Z10 " +
                    " ( COALESCE(EXT_DOSE.TLD_G_HP007,0) + COALESCE(EXT_DOSE.TLD_N_HP007,0) + COALESCE(EXT_DOSE.TLD_B_HP007,0) + COALESCE(OP_DOSE.EPD_G_HP007,0) + COALESCE(OP_DOSE.EPD_N_HP007,0)  + COALESCE(OP_DOSE.EPD_B_HP007,0) ) Z11 " +

                    " FROM EXT_PERSON "  +
                    " LEFT JOIN EXT_DOSE ON EXT_PERSON.ID_PERSON = EXT_DOSE.ID_PERSON "               +
                    " LEFT JOIN ADM_ASSIGNEMENT ON EXT_PERSON.ID_ASSIGNEMENT = ADM_ASSIGNEMENT.ID "   +
                    " LEFT JOIN OP_DOSE ON EXT_PERSON.ID_PERSON = OP_DOSE.ID_PERSON "                 +
                    " LEFT JOIN IN_CONTROL ON EXT_PERSON.ID_PERSON = IN_CONTROL.ID_PERSON "           +
                    " LEFT JOIN IN_MEASURE ON EXT_PERSON.ID_PERSON = IN_MEASURE.ID_PERSON "           +
                    " LEFT JOIN IN_IODINE ON EXT_PERSON.ID_PERSON = IN_IODINE.ID_PERSON "             +

                    " WHERE EXT_PERSON.ID_PERSON IN (" + page_report_ESKID.id_currentPerson + ") ";
            Query1.setQueryAndName(querySQL, "Report_1DOZ");

        }

        //всплывающая подсказка
        ToolTip {
            id: toolTip_CRETEREPORT
            //parent: button_CREATEREPORT //.handle
            text: qsTr("Напечатать отчет с заданными параметрами")
            font.pixelSize: 15

            //y: button_CREATEREPORT.y // + button_CREATEREPORT.height + 5
            visible: button_CREATEREPORT.hovered //"Подразделение" ? ma_MANY.containsMouse : false //hovered
            delay: 800 //задержка

            contentItem: Text {
                text: toolTip_CRETEREPORT.text
                font: toolTip_CRETEREPORT.font
                color: "white" //"#21be2b"
            }
//                    background: Rectangle {
//                        border.color: "#21be2b"
//                    }
        }

    }




}





/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2;anchors_x:28;anchors_y:30}
}
 ##^##*/
