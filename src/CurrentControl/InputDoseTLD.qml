import QtQuick 2.12
import QtQuick.Controls 2.5

import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

import QtQuick.Dialogs 1.2

Page {
    id: main_
    property int space_margin: 15

    property var id_currentPerson: 0
    property int sizeHeader: 14
    property int sizeTxt: 14
    property int heightAll: 60
    property int widthAll: 400


//    TextField {
//        id:txt_startInputDoseTLD
//        anchors.centerIn: parent
//        text: "_TLD dose input_"
//    }


//    Button {
//        anchors.bottom: parent.bottom
//        anchors.horizontalCenter: parent.horizontalCenter

//        text: "testVar_"

//        onClicked: {
//            //txt_startInputDoseTLD.text =  main_.id_currentPerson;
//            console.log("id_currentPerson = ", main_.id_currentPerson);
//            //console.log("model_adm_status: ", model_adm_status.get(0)["STATUS"]);
//        }

//    }

    Item {
        id: main_2
        anchors.left: parent.left
        anchors.right: parent.right
        //anchors.rightMargin: 260
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        Frame {
            id:frame_InsertDoseMenu

            height: 50
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: space_margin
            padding: 1
            topPadding: 1
            bottomPadding: 1
            leftPadding: 10

            background: Rectangle {
                anchors.fill: parent
                color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
                border.color: "LightGray"
                radius: 7
                //border.width: 1
            }


            Connections {
                id: inputDoseTLD_query
                target: Query1

                //(const QString& owner_name, const bool& res)
                onSignalSendResult: {
                    if (owner_name === "InputDoseTLD") {
                        //console.log(" >>>>>>>>>>>>>>>>>>>>>>>>> InputDoseTLD ", res);
                        if(!res) {
                            popup_checkAdd.isAdd = false
                            popup_checkAdd.messageError = owner_name + ": " + messageError
                        }
                        else {
                            popup_checkAdd.isAdd = true
                            popup_checkAdd.messageError = ""
                        }
                        popup_checkAdd.open()
                    }
//                    if (owner_name === "ChekAddDose") {
//                        console.log(" >>>>>>>>>>>>>>>>>>>>>>>>> ChekAddDose ", main_.id_currentPerson, " ", var_res);
//                        if(res) {
//                             if(main_.id_currentPerson == var_res) {
//                                 popup_checkAdd.isAdd = true
//                                 popup_checkAdd.messageError = ""
//                             }
//                             else {
//                                popup_checkAdd.isAdd = false
//                                popup_checkAdd.messageError = owner_name + ": " + "Проверка провалилась " + messageError
//                             }
//                        }
//                        else {
//                            popup_checkAdd.isAdd = false
//                            popup_checkAdd.messageError = owner_name + ": " + messageError
//                        }
//                        popup_checkAdd.open()
//                    }
                }
            }



            Row {
                id: row
                spacing: 10
                ToolButton {
                    text: "Добавить"
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 14
                    flat: true
                    Material.foreground: Material.Blue

                    onClicked: {
                        var data_arr = {}

                        data_arr["ID_PERSON"]       = parseInt(main_.id_currentPerson,10)
                        data_arr["TLD_HOLDER"]      = inputDose_tld_holder.currentText
                        data_arr["DATE_FROM"]       = calendar_date_from.date_val
                        data_arr["DATE_UNTIL"]      = calendar_date_until.date_val
                        data_arr["TLD_G_HP10"]      = parseInt(inputDose_tld_g_hp10.text,10)
                        data_arr["TLD_G_HP10_DOWN"] = parseInt(inputDose_tld_g_hp10_down.text,10)
                        data_arr["TLD_G_HP3"]       = parseInt(inputDose_tld_g_hp3.text,10)
                        data_arr["TLD_G_HP007"]     = parseInt(inputDose_tld_g_hp007.text,10)
                        data_arr["TLD_N_HP10"]      = parseInt(inputDose_tld_n_hp10.text,10)
                        data_arr["TLD_N_HP10_DOWN"] = parseInt(inputDose_tld_n_hp10_down.text,10)
                        data_arr["TLD_B_HP3"]       = parseInt(inputDose_tld_b_hp3.text,10)
                        data_arr["TLD_B_HP007"]     = parseInt(inputDose_tld_b_hp007.text,10)
                        data_arr["FON_DOSE"]        = parseInt(inputDose_fon_dose.text,10)
                        data_arr["BURN_DATE"]       = calendar_burn_date.date_val

                        Query1.insertRecordIntoTable("InputDoseTLD", "EXT_DOSE", data_arr)

//                        var query = " SELECT ID_PERSON FROM EXT_DOSE "
//                                    " WHERE ID_PERSON = "     + data_arr["ID_PERSON"]
//                                    " WHERE TLD_HOLDER = "    + data_arr["TLD_HOLDER"]
//                                    " AND DATE_FROM  = "      + data_arr["DATE_FROM"]
//                                    " AND DATE_UNTIL = "      + data_arr["DATE_UNTIL"]
//                                    " AND TLD_G_HP10 = "      + data_arr["TLD_G_HP10"]
//                                    " AND TLD_G_HP10_DOWN = " + data_arr["TLD_G_HP10_DOWN"]
//                                    " AND TLD_G_HP3 = "       + data_arr["TLD_G_HP3"]
//                                    " AND TLD_G_HP007 = "     + data_arr["TLD_G_HP007"]
//                                    " AND TLD_N_HP10 = "      + data_arr["TLD_N_HP10"]
//                                    " AND TLD_N_HP10_DOWN = " + data_arr["TLD_N_HP10_DOWN"]
//                                    " AND TLD_B_HP3 = "       + data_arr["TLD_B_HP3"]
//                                    " AND TLD_B_HP007 = "     + data_arr["TLD_B_HP007"]
//                                    " AND FON_DOSE = "        + data_arr["FON_DOSE"]
//                                    " AND BURN_DATE = "       + data_arr["BURN_DATE"]
//                                    " ) "
//                         Query1.setQueryWithName("ChekAddDose", query)


                    }
                }
                ToolSeparator {}
                ToolButton {
                    text: "Очистить поля"
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 14
                    flat: true
                    Material.foreground: Material.Green
                    onClicked: {
                        popup_clearFilds.open()
                    }
                }
                ToolSeparator {}
                ToolButton {
                    text: "Обновить"
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 14
                    flat: true
                    enabled: false
                    onClicked: {
                        popup_clearFilds.open()
                    }
                }


            }
        }

        Popup {
            id: popup_checkAdd
            property bool isAdd: false
            property string messageError: ""
            width: checkAdd.width + padding*2
            height: checkAdd.height + padding*2
            modal: true
            focus: true
            closePolicy: Popup.NoAutoClose
            parent: Overlay.overlay
            x: Math.round((parent.width - width) / 2)
            y: Math.round((parent.height - height) / 2)
            padding: 0



            Item {
                id: checkAdd
                height: popup_checkAdd.isAdd ? 120 : 150
                width:  popup_checkAdd.isAdd ? 300 : 600 //implicitContentWidth

                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 10
                    border.color: popup_checkAdd.isAdd ? "#8BC34A" : "#F44336"
                }

                Rectangle {
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: 20
                    width: 50
                    height: 80
                    border.color: "#F44336"
                    visible: popup_checkAdd.isAdd ? false : true
                    Text {
                        anchors.centerIn: parent
                        text: qsTr("!")
                        font.bold: true
                        color: "#F44336"
                        font.pixelSize: 50
                    }

                }

                Text {
                    //id: txt_checkAdd
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    text: popup_checkAdd.isAdd ? "Данные успешно добавлены" : "Ошибка добавления данных"
                    color: popup_checkAdd.isAdd ? "#8BC34A" : "#F44336"
                    font.pixelSize: 15
                }
                TextInput {
                    //id: txt_checkAddERROR
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 60
                    //color: popup_checkAdd.isAdd ? "#8BC34A" : "#F44336"
                    font.pixelSize: 12
                    text: popup_checkAdd.messageError
                }
                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    width: 100
                    text: "OK"
                    onClicked: {
                        popup_checkAdd.close();
                    }

                }


            }


        }


        Popup {
            id: popup_clearFilds
            width: clearFilds.width + padding*2
            height: clearFilds.height + padding*2
            modal: true
            focus: true
            closePolicy: Popup.NoAutoClose
            parent: Overlay.overlay
            x: Math.round((parent.width - width) / 2)
            y: Math.round((parent.height - height) / 2)
            padding: 0

            Item {
                id: clearFilds
                height: 100
                width:  200
                Column {
                    anchors.centerIn: parent
                    spacing: 10
                    Text {
                        text: qsTr("Очистить поля?")
                        font.pixelSize: 15
                    }
                    Row {
                        spacing: 10
                        Button {
                            text: "Очистить"
                            onClicked: {
                                inputDose_tld_holder.currentIndex = -1
                                inputDose_fon_dose.text         = 0
                                inputDose_tld_g_hp10.text       = 0
                                inputDose_tld_g_hp10_down.text  = 0
                                inputDose_tld_g_hp3.text        = 0
                                inputDose_tld_g_hp007.text      = 0
                                inputDose_tld_n_hp10.text       = 0
                                inputDose_tld_n_hp10_down.text  = 0
                                inputDose_tld_b_hp3.text        = 0
                                inputDose_tld_b_hp007.text      = 0
                                calendar_date_from.ready  = false
                                calendar_date_until.ready = false
                                calendar_burn_date.ready  = false

                                popup_clearFilds.close();
                            }
                        }
                        Button {
                            text: "Отмена"
                            onClicked: {
                                popup_clearFilds.close();
                            }
                        }
                    }
                }

            }


        }

        Frame {
            id:frame_InsertDose

            //height: 50
            height: implicitContentHeight + 30
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: frame_InsertDoseMenu.bottom
            anchors.topMargin: 20
            anchors.margins: space_margin

            padding: 1
            topPadding: 1
            bottomPadding: 1
            leftPadding: 10

            background: Rectangle {
                anchors.fill: parent
                color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
                border.color: "LightGray"
                radius: 7
                //border.width: 1
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10

                Row {
                    spacing: 10
                    Label {
                        text: qsTr("id_person:")
                        font.pixelSize: main_.sizeTxt
                    }
                    TextEdit {
                        id: inputDose_id_person
                        font.pixelSize: main_.sizeTxt
                        font.bold: true
                        color: Material.color(Material.Teal)
                        selectByMouse: true
                        selectionColor: Material.color(Material.Red)
                        text: main_.id_currentPerson
                    }
                }

                Row {
                    spacing: 10
                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Идентификатор кассетницы:")
                        font.pixelSize: main_.sizeTxt
                    }
                    ComboBox {
                        id: inputDose_tld_holder
                        currentIndex: -1
                        model: ["0001", "0002", "0003", "0004", "0005"]
                    }
//                    TextEdit {
//                        id: inputDose_tld_holder
//                        font.pixelSize: main_.sizeTxt
//                        font.bold: true
//                        color: Material.color(Material.Teal)
//                        selectByMouse: true
//                        selectionColor: Material.color(Material.Red)
//                        text: main_.id_currentPerson
//                    }
                }


                Row {
                    Layout.topMargin: 10
                    spacing: 40
                    Column {
                        spacing: 10
                        Label {
                            text: qsTr("Начальная дата отчетного периода")
                            font.pixelSize: main_.sizeTxt
                        }
                        MyCalendar {
                            id: calendar_date_from
                            date_val: new Date()
                            enabled: true
                        }
                    }

                    Column {
                        spacing: 10
                        Label {
                            text: qsTr("Конечная дата отчетного периода")
                            font.pixelSize: main_.sizeTxt
                        }
                        MyCalendar {
                            id: calendar_date_until
                            date_val: new Date()
                            enabled: true
                        }
                    }

                    Column {
                        spacing: 10
                        Label {
                            text: qsTr("Дата отжига")
                            font.pixelSize: main_.sizeTxt
                        }
                        MyCalendar {
                            id: calendar_burn_date
                            date_val: new Date()
                            enabled: true
                        }
                    }
                    Column {
                        spacing: 10
                        Label {
                            text: qsTr("Фон считывателя")
                            font.pixelSize: main_.sizeTxt
                        }
                        Row {
                            TextField {
                                id: inputDose_fon_dose
                                font.pixelSize: main_.sizeTxt
                                font.bold: true
                                color: Material.color(Material.Teal)
                                selectByMouse: true
                                selectionColor: Material.color(Material.Red)
                                horizontalAlignment: Text.AlignHCenter
                                text: "0"
                            }
                            Label {
                                //leftPadding: 5
                                text: qsTr("мЗв <i> (???) </i>")
                                //text: qsTr("мЗв <p style='color:#d60e0e'> (???) </p>")
                                font.pixelSize: main_.sizeTxt
                            }
                        }



                    }

                }

                ///////////////////////////////////////////////
                RowLayout {
                    Layout.topMargin: 10
                    spacing: 5
                    Rectangle {
                        height: 1
                        width: 50
                        color: "LightGray"
                    }
                    Label {
                        text: qsTr("ИЭД гамма излучения")
                        font.pixelSize: main_.sizeTxt
                        color: "#8e8e8e"
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: "LightGray"
                    }
                }

                Row {
                    Layout.topMargin: 5
                    spacing: 50
                    Column {
                        spacing: 10
                        Row {
                            //Layout.topMargin: 5
                            spacing: 10
                            Label {
                                width: 220
                                text: qsTr("ИЭД гамма излучения")
                                font.pixelSize: main_.sizeTxt
                            }
                                TextField {
                                    id: inputDose_tld_g_hp10
                                    font.pixelSize: main_.sizeTxt
                                    font.bold: true
                                    color: Material.color(Material.Teal)
                                    selectByMouse: true
                                    selectionColor: Material.color(Material.Red)
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "0"
                                }

                                Label {
                                    //leftPadding: 5
                                    text: qsTr("мЗв")
                                    font.pixelSize: main_.sizeTxt
                                }
                        }

                        Row {
                            spacing: 10
                            Label {
                                //leftPadding: 20
                                width: 220
                                text: qsTr("Низ живота женщин (до 45 лет)")
                                font.pixelSize: main_.sizeTxt
                            }
                                TextField {
                                    id: inputDose_tld_g_hp10_down
                                    font.pixelSize: main_.sizeTxt
                                    font.bold: true
                                    color: Material.color(Material.Teal)
                                    selectByMouse: true
                                    selectionColor: Material.color(Material.Red)
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "0"
                                }
                                Label {
                                    //leftPadding: 5
                                    text: qsTr("мЗв")
                                    font.pixelSize: main_.sizeTxt
                                }
                        }

                    }

                    Rectangle {
                        width: 1
                        height: parent.height
                        color: "LightGray"
                    }

                    Column {
                        spacing: 10
                        Row {
                            Layout.topMargin: 5
                            spacing: 10
                            Label {
                                width: 150 //220
                                text: qsTr("Xрусталик глаза")
                                font.pixelSize: main_.sizeTxt
                            }
                                TextField {
                                    id: inputDose_tld_g_hp3
                                    font.pixelSize: main_.sizeTxt
                                    font.bold: true
                                    color: Material.color(Material.Teal)
                                    selectByMouse: true
                                    selectionColor: Material.color(Material.Red)
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "0"

                                }
                                Label {
                                    //leftPadding: 5
                                    text: qsTr("мЗв")
                                    font.pixelSize: main_.sizeTxt
                                }
                        }

                        Row {
                            spacing: 10
                            Label {
                                //leftPadding: 20
                                width: 150 //220
                                text: qsTr("Кожа, кисти и стопы")
                                font.pixelSize: main_.sizeTxt
                            }
                                TextField {
                                    id: inputDose_tld_g_hp007
                                    font.pixelSize: main_.sizeTxt
                                    font.bold: true
                                    color: Material.color(Material.Teal)
                                    selectByMouse: true
                                    selectionColor: Material.color(Material.Red)
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "0"
                                }
                                Label {
                                    //leftPadding: 5
                                    text: qsTr("мЗв")
                                    font.pixelSize: main_.sizeTxt
                                }
                        }

                    }


                }

                ///////////////////////////////////////////////
                RowLayout {
                    Layout.topMargin: 10
                    spacing: 5
                    Rectangle {
                        height: 1
                        width: 50
                        color: "LightGray"
                    }
                    Label {
                        text: qsTr("ИЭД нейтронного излучения")
                        font.pixelSize: main_.sizeTxt
                        color: "#8e8e8e"
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: "LightGray"
                    }
                }

                Row {
                    Layout.topMargin: 5
                    spacing: 10
                    Label {
                        width: 220
                        text: qsTr("ИЭД нейтронного излучения")
                        font.pixelSize: main_.sizeTxt
                    }
                    TextField {
                        id: inputDose_tld_n_hp10
                        font.pixelSize: main_.sizeTxt
                        font.bold: true
                        color: Material.color(Material.Teal)
                        selectByMouse: true
                        selectionColor: Material.color(Material.Red)
                        horizontalAlignment: Text.AlignHCenter
                        text: "0"

                    }
                    Label {
                        //leftPadding: 5
                        text: qsTr("мЗв")
                        font.pixelSize: main_.sizeTxt
                    }

//                    Rectangle {
//                        width: 1
//                        height: parent.height
//                        color: "LightGray"
//                    }


                    Label {
                        leftPadding: 91
                        width: 240
                        text: qsTr("Низ живота женщин\n(до 45 лет лет)")
                        font.pixelSize: main_.sizeTxt
                        //background: Rectangle {color: "red"}
                    }
                    TextField {
                        id: inputDose_tld_n_hp10_down
                        font.pixelSize: main_.sizeTxt
                        font.bold: true
                        color: Material.color(Material.Teal)
                        selectByMouse: true
                        selectionColor: Material.color(Material.Red)
                        horizontalAlignment: Text.AlignHCenter
                        text: "0"

                    }
                    Label {
                        //leftPadding: 5
                        text: qsTr("мЗв")
                        font.pixelSize: main_.sizeTxt
                    }


                }


                ///////////////////////////////////////////////
                RowLayout {
                    Layout.topMargin: 10
                    spacing: 5
                    Rectangle {
                        height: 1
                        width: 50
                        color: "LightGray"
                    }
                    Label {
                        text: qsTr("ИЭД бета излучения")
                        font.pixelSize: main_.sizeTxt
                        color: "#8e8e8e"
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: "LightGray"
                    }

                }


                Row {
                    Layout.topMargin: 5
                    spacing: 10
                    Label {
                        width: 220
                        text: qsTr("Хрусталик глаза")
                        font.pixelSize: main_.sizeTxt
                    }
                    TextField {
                        id: inputDose_tld_b_hp3
                        font.pixelSize: main_.sizeTxt
                        font.bold: true
                        color: Material.color(Material.Teal)
                        selectByMouse: true
                        selectionColor: Material.color(Material.Red)
                        horizontalAlignment: Text.AlignHCenter
                        text: "0"

                    }
                    Label {
                        //leftPadding: 5
                        text: qsTr("мЗв")
                        font.pixelSize: main_.sizeTxt
                    }
                }
                Row {
                    spacing: 10
                    Label {
                        //leftPadding: 91
                        width: 220 //240
                        text: qsTr("Кожа, кисти и стопы")
                        font.pixelSize: main_.sizeTxt
                        //background: Rectangle {color: "red"}
                    }
                    TextField {
                        id: inputDose_tld_b_hp007
                        font.pixelSize: main_.sizeTxt
                        font.bold: true
                        color: Material.color(Material.Teal)
                        selectByMouse: true
                        selectionColor: Material.color(Material.Red)
                        horizontalAlignment: Text.AlignHCenter
                        text: "0"

                    }
                    Label {
                        //leftPadding: 5
                        text: qsTr("мЗв")
                        font.pixelSize: main_.sizeTxt
                    }


                }




            }

        }


    }






}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
