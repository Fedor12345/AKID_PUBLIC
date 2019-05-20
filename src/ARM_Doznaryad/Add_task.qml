import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

//import Foo 1.0

Item {
    id: item2
    height: 700//550
    width:  800

    property int doznaryad_num: -1

    property ListModel tasks_list_model: ListModel {
        //      ListElement { id_doznaryad; id_blok; id_equipment; id_unit; id_type_of_work; dose_value; measure; people_cnt; current_day;
        //                    chb_rad_state; gamma_value; beta_value; neutron_value; alfa_value;
        //                    rooms: [ ListElement { id_room } ]
        //      }
    }

    signal edit_confirm(var data_record)
    signal edit_cancel()

    signal wizard_next(var data_record)
    signal wizard_back()

    state: "edit" //два состояния: edit, wizard

    states: [
        State {
            name: "edit"
            PropertyChanges {
                target: ok_button
                text: "Сохранить"
            }
            PropertyChanges {
                target: cancel_button
                text: "Отмена"
            }
            PropertyChanges {
                target: header_caption
                text: "Задание"
            }
        },
        State {
            name: "wizard"
            PropertyChanges {
                target: ok_button
                text: "Далее"
            }
            PropertyChanges {
                target: cancel_button
                text: "Назад"
            }
            PropertyChanges {
                target: header_caption
                text: "Новый наряд-допуск: Задание"
            }
        }
    ]

    function clearfields() {
        id_blok.currentIndex = -1
        id_room.currentIndex = -1
        list_of_rooms_model.clear()
        id_equipment.currentIndex = -1
        id_unit.currentIndex = -1

        id_typeofwork.currentIndex = -1
        id_jobtitle.currentIndex = -1
        id_dose_value.text = "0,00"
        id_measure.currentIndex = 0
        id_people_cnt.text = "0"
        id_cur_day.text = "0"

        id_chb_rad.checkState = Qt.Unchecked
        id_rad_gamma.text = "0,00"
        id_rad_neutr.text = "0,00"
        id_rad_beta.text = "0,00"
        id_rad_alfa.text = "0,00"
    }

    function clearAll() {
        clearfields()
        tasks_list_model.clear()
    }

    function formatText(str_source) {
        var str_tmp = str_source
        if (str_tmp.toString().length === 0 ) str_tmp = "00"
        if (str_tmp.toString().length < 2 ) str_tmp = "0"+str_tmp
        return str_tmp
    }

    function load_edit_data(doz_id) {
        var i, len;
        var zr = justquery2.find_records(" SELECT T1.ID, T1.ID_EQUIPMENT, T1.ID_UNIT, T1.ID_TYPE_OF_WORK, T1.ID_JOB_TITLE, T1.DOSE_VALUE,
                                                  T1.PEOPLE_CNT, T1.CURRENT_DAY, T1.GAMMA_VALUE, T1.BETA_VALUE, T1.NEUTRON_VALUE, T1.ALFA_VALUE,
                                                  T1.MEASURE, T1.CHB_RAD_STATE, T1.ID_BLOK,
                                                  T2.EQUIPMENT_NAME, T3.UNIT_NAME, T4.TYPE_NAME, T5.JOB_NAME, T6.ZONE_NAME
                                           FROM (((((TABLE_TASKS T1
                                           LEFT JOIN TABLE_EQUIPMENT T2 ON T1.ID_EQUIPMENT = T2.ID)
                                           LEFT JOIN TABLE_UNITS T3 ON T1.ID_UNIT = T3.ID)
                                           LEFT JOIN TABLE_TYPE_OF_WORK T4 ON T1.ID_TYPE_OF_WORK = T4.ID)
                                           LEFT JOIN TABLE_JOB_TITLE T5 ON T1.ID_JOB_TITLE = T5.ID)
                                           LEFT JOIN TABLE_ZONES T6 ON T1.ID_BLOK = T6.ID)
                                           WHERE T1.ID_DOZNARYAD = "+doz_id)

        if (Object.keys(zr).length > 0) {
            len = Object.keys(zr).length
            for (i = 0; i < len; i++) {
                tasks_list_model.append({"ID": zr[i]["ID"],
                                            "ID_EQUIPMENT": zr[i]["ID_EQUIPMENT"],
                                            "ID_BLOK": zr[i]["ID_BLOK"],
                                            "ID_UNIT": zr[i]["ID_UNIT"],
                                            "ID_TYPE_OF_WORK": zr[i]["ID_TYPE_OF_WORK"],
                                            "ID_JOB_TITLE": zr[i]["ID_JOB_TITLE"],
                                            "DOSE_VALUE": zr[i]["DOSE_VALUE"],
                                            "MEASURE": zr[i]["MEASURE"],
                                            "PEOPLE_CNT": zr[i]["PEOPLE_CNT"],
                                            "CURRENT_DAY": zr[i]["CURRENT_DAY"],
                                            "CHB_RAD_STATE": zr[i]["CHB_RAD_STATE"],
                                            "GAMMA_VALUE": zr[i]["GAMMA_VALUE"],
                                            "BETA_VALUE": zr[i]["BETA_VALUE"],
                                            "NEUTRON_VALUE": zr[i]["NEUTRON_VALUE"],
                                            "ALFA_VALUE": zr[i]["ALFA_VALUE"],
                                            "ZONE_NAME": zr[i]["ZONE_NAME"],
                                            "EQUIPMENT_NAME": zr[i]["EQUIPMENT_NAME"],
                                            "TYPE_WORK": zr[i]["TYPE_NAME"],
                                            "JOB_TITLE": zr[i]["JOB_NAME"],
                                            "UNIT_NAME": zr[i]["UNIT_NAME"],
                                            "ROOMS": []
                                        })

            }

            for (i = 0; i < tasks_list_model.rowCount(); i++) {
                zr = justquery2.find_records(" SELECT T1.ID, T2.ROOM_NAME
                                               FROM (TABLE_TASKS_ROOMS_CON T1
                                               LEFT JOIN TABLE_ROOMS T2 ON T1.ID_ROOM = T2.ID)
                                               WHERE T1.ID_TASK = "+tasks_list_model.get(i)["ID"])

                if (Object.keys(zr).length > 0) {
                    len = Object.keys(zr).length
                    for (var j = 0; j < len; j++) {
                        tasks_list_model.get(i)["ROOMS"].append({"ID": zr[j]["ID"], "ROOM_NAME": zr[j]["ROOM_NAME"]})
                    }
                }
            }
        }
    }

    Rectangle {
        id: header_rectangle
        color: "indianred"
        width: item2.width
        height: 40
        Label {
            id: header_caption
            text: "Задание"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            font.pixelSize: 16
            color: "White"
            font.bold: true
        }

    }

    Frame {
        id:tasklist_menu_frame

        height: 30
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top:  header_rectangle.bottom
        anchors.margins: 10
        padding: 1
        topPadding: 1
        bottomPadding: 1
        leftPadding: 10

        background: Rectangle {
            anchors.fill: parent
            color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
            border.color: "LightGray"
            radius: 7
        }

        Row {
            spacing: 10
            ToolButton {
                id: new_button_tasklist_menu
                height: 30
                text: "Новое задание"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                flat: true
                enabled: frame4.state === "normal" ? true : false
                onClicked: {
                    frame4.state = "minimum"
                    addtask_frame.state = "normal"

                    ok_button.enabled = false
                    cancel_button.enabled = false

                    item2.clearfields()
                }

            }
            ToolSeparator {
                height: 30
            }
            ToolButton {
                id: save_button_tasklist_menu
                height: 30
                text: "Сохранить"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                flat: true
                enabled: frame4.state === "normal" ? false : true

                onClicked: {
                    var maprec = {}

                    //maprec["id_doznaryad"] = doznaryad_num
                    maprec["ID_BLOK"] = id_blok.model.get(id_blok.currentIndex)["ID"]
                    maprec["ID_EQUIPMENT"] = id_equipment.model.get(id_equipment.currentIndex)["ID"]
                    maprec["ID_UNIT"] = id_unit.model.get(id_unit.currentIndex)["ID"]
                    maprec["ID_TYPE_OF_WORK"] = id_typeofwork.model.get(id_typeofwork.currentIndex)["ID"]
                    maprec["ID_JOB_TITLE"] = id_jobtitle.model.get(id_jobtitle.currentIndex)["ID"]
                    maprec["DOSE_VALUE"] = parseFloat(id_dose_value.text.replace(",", "."))
                    maprec["MEASURE"] = id_measure.currentIndex
                    maprec["PEOPLE_CNT"] = parseInt(id_people_cnt.text)
                    maprec["CURRENT_DAY"] = parseInt(id_cur_day.text)

                    if (id_chb_rad.checkState === Qt.Checked) {
                        maprec["CHB_RAD_STATE"] = 1
                        maprec["GAMMA_VALUE"] = parseFloat(id_rad_gamma.text.replace(",", "."))
                        maprec["BETA_VALUE"] = parseFloat(id_rad_beta.text.replace(",", "."))
                        maprec["NEUTRON_VALUE"] = parseFloat(id_rad_neutr.text.replace(",", "."))
                        maprec["ALFA_VALUE"] = parseFloat(id_rad_alfa.text.replace(",", "."))
                    } else {
                        maprec["CHB_RAD_STATE"] = 0
                        maprec["GAMMA_VALUE"] = 0.0
                        maprec["BETA_VALUE"] = 0.0
                        maprec["NEUTRON_VALUE"] = 0.0
                        maprec["ALFA_VALUE"] = 0.0
                    }

                    maprec["ROOMS"] = []
                    for(var i = 0; i < list_of_rooms_model.count; i++) {
                        maprec["ROOMS"][i] = list_of_rooms_model.get(i)
                    }

                    maprec["ZONE_NAME"] =id_blok.currentText
                    maprec["EQUIPMENT_NAME"] = id_equipment.currentText
                    maprec["TYPE_WORK"] = id_typeofwork.currentText
                    maprec["JOB_TITLE"] = id_jobtitle.currentText
                    maprec["UNIT_NAME"] = id_unit.currentText

                    tasks_list_model.append(maprec)

                    ok_button.enabled = true
                    cancel_button.enabled = true

                    item2.clearfields()

                    frame4.state = "normal"
                    addtask_frame.state = "minimum"

                }
            }
            ToolButton {
                id: cancel_button_tasklist_menu
                height: 30
                text: "Отмена"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                flat: true
                enabled: frame4.state === "normal" ? false : true
                onClicked: {
                    ok_button.enabled = true
                    cancel_button.enabled = true

                    item2.clearfields()

                    frame4.state = "normal"
                    addtask_frame.state = "minimum"
                }
            }
//            ToolSeparator {
//                height: 30
//            }
//            ToolButton {
//                id: edit_button_tasklist_menu
//                height: 30
//                text: "Редактировать"
//                anchors.verticalCenter: parent.verticalCenter
//                font.pixelSize: 14
//                flat: true
//                enabled: frame4.state === "normal" ? true : false

//                onClicked: {
//                    frame4.state = "minimum"
//                    addtask_frame.state = "normal"

////                    ID
////                    ID_DOZNARYAD
////                    ID_EQUIPMENT
////                    ID_UNIT
////                    ID_TYPE_OF_WORK
////                    ID_JOB_TITLE
////                    MEASURE
////                    ID_BLOK

//                    console.log("edit task - current_index:" + tasks_list.currentIndex)

//                    id_chb_rad.checkState = tasks_list_model.get(tasks_list.currentIndex)["CHB_RAD_STATE"] ? Qt.Checked : Qt.Unchecked
//                    id_rad_alfa.text=tasks_list_model.get(tasks_list.currentIndex)["ALFA_VALUE"].toFixed(3)
//                    id_rad_beta.text=tasks_list_model.get(tasks_list.currentIndex)["BETA_VALUE"].toFixed(3)
//                    id_rad_gamma.text=tasks_list_model.get(tasks_list.currentIndex)["GAMMA_VALUE"].toFixed(3)
//                    id_rad_neutr.text=tasks_list_model.get(tasks_list.currentIndex)["NEUTRON_VALUE"].toFixed(3)

//                    id_cur_day.text=tasks_list_model.get(tasks_list.currentIndex)["CURRENT_DAY"]
//                    id_people_cnt.text=tasks_list_model.get(tasks_list.currentIndex)["PEOPLE_CNT"]

//                    id_dose_value.text=tasks_list_model.get(tasks_list.currentIndex)["DOSE_VALUE"].toFixed(3)

//                    var i;
//                    list_of_rooms_model.clear()

//                    for (i=0; i < tasks_list_model.get(tasks_list.currentIndex)["ROOMS"].count; i++) {
//                        list_of_rooms_model.append({ "ID": tasks_list_model.get(tasks_list.currentIndex)["ROOMS"].get(i)["ID"],
//                                                     "ROOM_NAME": tasks_list_model.get(tasks_list.currentIndex)["ROOMS"].get(i)["ROOM_NAME"]
//                                                   })
//                    }



////                    var i;
////                    for (i=0; i < id_status.model.rowCount(); i++) {
////                        if (id_status.model.get(i)["ID"] === doz_dataset["DOZ_STATUS"]) {
////                            id_status.currentIndex = i
////                            break;
////                        }
////                    }


//                }
//            }
            ToolSeparator {
                height: 30
            }
            ToolButton {
                id: del_button_tasklist_menu
                height: 30
                text: "Удалить"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                flat: true
                enabled: frame4.state === "normal" ? true : false
                onClicked: {
                    if (tasks_list_model.rowCount() > 0)
                        tasks_list_model.remove(tasks_list.currentIndex)
                }
            }
        }
    }

    Frame {
        id: frame4
        //anchors.margins: 10
        anchors.topMargin: 10
        anchors.leftMargin: 11
        anchors.rightMargin: 11
        anchors.top: tasklist_menu_frame.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        height: 120//540//155

        //padding: 1
        topPadding: 1
        bottomPadding: 1
        leftPadding: 1
        rightPadding: 1
        clip: true
        //property bool add_flg: false

        background: Rectangle {
            anchors.fill: parent
            border.color: Material.color(Material.Grey, Material.Shade500)//"lavender"
            color: Material.color(Material.Grey, Material.Shade50)
            //Material.color(Material.Grey, Material.Shade600)//"whitesmoke"
        }

        state: "normal"
        states: [
            State {
                name: "normal"
                PropertyChanges {
                    target: frame4
                    height: 540//155
                }
                PropertyChanges {
                    target: rect_listheader
                    color: Material.color(Material.Grey, Material.Shade700)
                }
                PropertyChanges {
                    target: label_listheader
                    text: "Список заданий"
                }
                //                PropertyChanges {
                //                    target: tasks_list_pane
                //                    visible: true
                //                }
            },
            State {
                name: "minimum"
                PropertyChanges {
                    target: frame4
                    height: 30
                }
                PropertyChanges {
                    target: rect_listheader
                    color: Material.color(Material.LightBlue, Material.Shade500)//700
                }
                PropertyChanges {
                    target: label_listheader
                    text: "Новое задание"
                }
                //                PropertyChanges {
                //                    target: tasks_list_pane
                //                    visible: false
                //                }
            }
        ]

        transitions: [
            Transition {
                from: "normal"
                to: "minimum"
                NumberAnimation {
                    //target: frame4
                    properties: "height"
                    duration: 300
                }
            },
            Transition {
                from: "minimum"
                to: "normal"
                NumberAnimation {
                    //target: frame4
                    properties: "height"
                    duration: 300
                }
            }
        ]

        //-----------
        ColumnLayout {
            anchors.fill: parent
            spacing: 0
            Rectangle {
                id: rect_listheader
                height: 30
                Layout.fillWidth: true
                color: Material.color(Material.Grey, Material.Shade700)
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                border.width: 0
                Label {
                    id: label_listheader
                    leftPadding: 8
                    text: "Список заданий" //"\ub120"
                    font.pixelSize: 16
                    color: "White"
                    //font.family: "icons\materialdesignicons-webfont.ttf"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Pane {
                id: tasks_list_pane
                Layout.fillWidth: true
                Layout.fillHeight: true
                padding: 0

                //height: 155

                background: Rectangle {
                    anchors.fill: parent
                    color: "Transparent"
                    border.width: 0
                }

                ListView {
                    id: tasks_list
                    anchors.fill: parent
                    model: tasks_list_model

                    focus: true
                    clip: true

                    highlightFollowsCurrentItem: true
                    highlight: Rectangle {
                        color: Material.color(Material.Grey, Material.Shade600)
                        //Material.color(Material.BlueGrey, Material.Shade100)
                        //Material.color(Material.Grey, Material.Shade300)
                    }
                    highlightMoveDuration: 0

                    onCurrentIndexChanged: {
                        if( tasks_list.currentItem !== null)
                            tasks_list.currentItem.checked = true
                    }

                    delegate: ItemDelegate {
                        id: delegate_tasks_list
                        width: tasks_list.width

                        checkable: true
                        checked: false

                        onClicked: {
                            tasks_list.currentItem.checked = false
                            tasks_list.currentIndex = index
                            //checked = true
                        }

                        contentItem:  ColumnLayout {
                            spacing: 10

//                            Rectangle {
//                                width: parent.width
//                                height: 1
//                                color: "Grey"
//                                border.width: 0
//                            }

                            Row {
                                Label {
                                    text: ZONE_NAME//fullName
                                    font.bold: true
                                    font.pixelSize: 14
                                    elide: Text.ElideRight
                                    Layout.fillWidth: true
                                    width: 120
                                    color: delegate_tasks_list.checked ? "white" : "black"
                                }
                                Label {
                                    text: EQUIPMENT_NAME+": "+UNIT_NAME
                                    font.bold: true
                                    font.pixelSize: 14
                                    elide: Text.ElideRight
                                    Layout.fillWidth: true
                                    width: 400
                                    color: delegate_tasks_list.checked ? "white" : "black"
                                }
                                Label {
                                    text: TYPE_WORK//fullName
                                    font.bold: true
                                    font.pixelSize: 14
                                    elide: Text.ElideRight
                                    Layout.fillWidth: true
                                    width: 200
                                    color: delegate_tasks_list.checked ? "white" : "black"
                                }
                            }
                            ColumnLayout {
                                id: ttttt
                                visible: false
                                RowLayout {
                                    spacing: 10
                                    Label {
                                        text: qsTr("помещения:")
                                        Layout.leftMargin: 20
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                    Repeater {
                                        model: ROOMS//tasks_list_model.get()["ROOMS"]

                                        Label {
                                            text: ROOM_NAME +"; "
                                            font.bold: true
                                            elide: Text.ElideRight
                                            //Layout.fillWidth: true
                                            font.pointSize: 10
                                            //color: delegate_tasks_list.checked ? "white" : "black"
                                            color: "white"
                                        }
                                    }
                                }

                                Label {
                                    text: "Радиационная обстановка"
                                    Layout.leftMargin: 508
                                    font.pointSize: 12
                                    //color: delegate_tasks_list.checked ? "white" : "black"
                                    color: "white"
                                }

                                GridLayout {
                                    columns: 4
                                    rowSpacing: 4
                                    columnSpacing: 10


                                    Label {
                                        text: "Наименование: "
                                        Layout.leftMargin: 20
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                    Label {
                                        text: JOB_TITLE
                                        font.bold: true
                                        elide: Text.ElideRight
                                        //Layout.fillWidth: true
                                        Layout.minimumWidth: 350
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                    Label {
                                        text: "Гамма:"
                                        Layout.leftMargin: 20
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                    Label {
                                        text: if (CHB_RAD_STATE){
                                                  GAMMA_VALUE + ((MEASURE == 0) ? " мЗв/ч":" мкЗв/ч")
                                              } else "-"
                                        font.bold: true
                                        elide: Text.ElideRight
                                        //Layout.fillWidth: true
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                    Label {
                                        text: "Доза:"
                                        Layout.leftMargin: 20
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                    Label {
                                        text: DOSE_VALUE + ((MEASURE == 0) ? " мЗв/ч":" мкЗв/ч")
                                        font.bold: true
                                        elide: Text.ElideRight
                                        //Layout.fillWidth: true
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                    Label {
                                        text: "Нейтронная:"
                                        Layout.leftMargin: 20
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                    Label {
                                        text: if (CHB_RAD_STATE){
                                                  NEUTRON_VALUE + ((MEASURE == 0) ? " мЗв/ч":" мкЗв/ч")
                                              } else "-"
                                        font.bold: true
                                        elide: Text.ElideRight
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                    Label {
                                        text: "Кол-во человек:"
                                        Layout.leftMargin: 20
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                    Label {
                                        text: PEOPLE_CNT
                                        font.bold: true
                                        elide: Text.ElideRight
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                    Label {
                                        text: "Бета:"
                                        Layout.leftMargin: 20
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                    Label {
                                        text: if (CHB_RAD_STATE){
                                                  BETA_VALUE + " част./кв.см мин"
                                              } else "-"
                                        font.bold: true
                                        elide: Text.ElideRight
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                    Label {
                                        text: "Текущие сутки:"
                                        Layout.leftMargin: 20
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                    Label {
                                        text: CURRENT_DAY
                                        font.bold: true
                                        elide: Text.ElideRight
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                    Label {
                                        text: "Альфа:"
                                        Layout.leftMargin: 20
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                    Label {
                                        text: if (CHB_RAD_STATE){
                                                  ALFA_VALUE + " част./кв.см мин"
                                              } else "-"
                                        font.bold: true
                                        elide: Text.ElideRight
                                        font.pointSize: 10
                                        //color: delegate_tasks_list.checked ? "white" : "black"
                                        color: "white"
                                    }
                                }
                            }
                        }

                        states: [
                            State {
                                name: "expanded"
                                when: delegate_tasks_list.checked

                                PropertyChanges {
                                    target: ttttt//grid_delegate_tasks_list
                                    visible: true
                                }
                            }
                        ]
                    }
                }
            }
        }
    }


    Frame {
        id: addtask_frame
        //anchors.margins: 10
        anchors.topMargin: 0
        anchors.leftMargin: 11
        anchors.rightMargin: 11

        anchors.top: frame4.bottom//frame3.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        height: 430
        clip: true

        padding: 1
        topPadding: 0
        bottomPadding: 1

        background: Rectangle {
            anchors.fill: parent
            border.color: Material.color(Material.LightBlue, Material.Shade500)//"lavender"
            color: "white"//Material.color(Material.Blue, Material.Shade50)//"whitesmoke"
        }

        state: "minimum"
        states: [
            State {
                name: "normal"
                PropertyChanges {
                    target: addtask_frame
                    height: 430//510//155
                }
            },
            State {
                name: "minimum"
                PropertyChanges {
                    target: addtask_frame
                    height: 00
                }
            }
        ]

        transitions: [
            Transition {
                from: "normal"
                to: "minimum"
                NumberAnimation {
                    properties: "height"
                    duration: 300
                }
            },
            Transition {
                from: "minimum"
                to: "normal"
                NumberAnimation {
                    properties: "height"
                    duration: 300
                }
            }
        ]


        Frame {
            id: frame1
            //            leftPadding: 20
            //            rightPadding: 20
            topPadding: 12
            bottomPadding: 7

            anchors.margins: 10

            //anchors.top: frame4.bottom//header_rectangle.bottom
            anchors.bottom: frame3.top
            anchors.left: parent.left
            //width: 450
            //anchors.right: parent.right
            enabled: frame4.state === "normal" ? false : true
            background: Rectangle {
                anchors.fill: parent
                color: "Transparent"
                border.width: 0
            }
            ColumnLayout {
                RowLayout {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    //Layout.leftMargin:
                    //Layout.topMargin: 10
                    spacing: 25
                    Column {
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Text {
                            text: "Блок"
                            font.pixelSize: 14
                        }

                        ComboBox {
                            id: id_blok
                            width: 150
                            currentIndex: -1
                            font.pixelSize: 14
                            textRole: "ZONE_NAME"
                            model: managerDB.createModel("SELECT ID, ZONE_NAME FROM TABLE_ZONES ORDER BY ZONE_NAME")

                            onCurrentIndexChanged: {
                                id_room.model.query = "SELECT ID, room_name FROM table_rooms WHERE id_zone = "+
                                        id_blok.model.get(id_blok.currentIndex)["ID"]
                                id_room.currentIndex = -1
                                list_of_rooms_model.clear()

                            }
                        }
                    }

                    Column {
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Text {
                            text: "Помещение"
                            font.pixelSize: 14
                        }

                        Row {
                            spacing: 10
                            ComboBox {
                                id: id_room
                                width: 220
                                font.pixelSize: 14
                                textRole: "ROOM_NAME"
                                currentIndex: -1
                                model: managerDB.createModel("")
                            }

                            Rectangle {
                                width: 28
                                height: 28
                                anchors.verticalCenter: parent.verticalCenter
                                radius: 14
                                color: Material.color(Material.Grey, Material.Shade700)
                                border.color: Material.color(Material.Grey, Material.Shade800)//"Black"
                                border.width: 1
                                opacity: (id_room.currentIndex !== -1) ? 0.7 : 0.2
                                enabled: (id_room.currentIndex !== -1) ? true : false

                                Image {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: "icons/plus.svg"
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {

                                        //а нет ли уже в списке такого помещения?
                                        var res_compare = false
                                        for(var i = list_of_rooms_model.rowCount()-1; i >= 0; --i) {
                                            if (id_room.model.get(id_room.currentIndex)["ID"] === list_of_rooms_model.get(i)["ID"]) {
                                                res_compare = true
                                                break
                                            }
                                        }

                                        if (!res_compare) {
                                            list_of_rooms_model.append({"ID": id_room.model.get(id_room.currentIndex)["ID"],
                                                                        "ROOM_NAME": id_room.model.get(id_room.currentIndex)["ROOM_NAME"]});
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                ColumnLayout {
                    spacing: 0
                    Rectangle {
                        height: 30
                        Layout.fillWidth: true
                        color: Material.color(Material.BlueGrey, Material.Shade700)//Material.color(Material.Grey, Material.Shade700)
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                        Label {
                            leftPadding: 8
                            text: "Список помещений"
                            font.pixelSize: 16
                            color: "White"
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Rectangle {
                            id: delete_room_button
                            height: 27
                            width: 27
                            color: "transparent"
                            radius: 2
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: 3

                            Image {
                                id: img_del_room
                                source: "icons/minus.svg"
                                fillMode: Image.PreserveAspectFit
                                sourceSize.height: 25
                                sourceSize.width: 25
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter

                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled : true
                                onClicked: {
                                    if (list_of_rooms_model.rowCount() > 0)
                                        list_of_rooms_model.remove(rooms_list.currentIndex)
                                }

                                onEntered: {
                                    img_del_room.sourceSize.height = 30
                                    img_del_room.sourceSize.width = 30
                                }
                                onExited: {
                                    img_del_room.sourceSize.height = 25
                                    img_del_room.sourceSize.width = 25
                                }

                                onPressed: { parent.border.color = "white" }
                                onReleased: { parent.border.color = "transparent" }
                            }
                        }

                    }
                    Rectangle {
                        Layout.fillWidth: true
                        height: 110
                        border.color: "lavender"
                        color: "whitesmoke"

                        ListModel {
                            id: list_of_rooms_model
                        }

                        ListView {
                            id: rooms_list
                            anchors.fill: parent
                            model: list_of_rooms_model
                            clip: true

                            highlightFollowsCurrentItem: true

                            highlight: Rectangle {
                                color: Material.color(Material.BlueGrey, Material.Shade200)
                            }
                            highlightMoveDuration: 0

                            delegate: ItemDelegate {
                                id: room_delegate
                                text: ROOM_NAME
                                width: parent.width-rooms_list_scroll.width
                                height: 25
                                font.pointSize: 10
                                onClicked: { rooms_list.currentIndex = index }
                            }

                            ScrollBar.vertical: ScrollBar {
                                id: rooms_list_scroll
                                policy: ScrollBar.AlwaysOn
                                anchors.top: parent.top
                                anchors.topMargin: parent.topPadding
                                anchors.right: parent.right
                                anchors.rightMargin: 1
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: parent.bottomPadding
                            }
                        }

                    }

                }

                RowLayout {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    //Layout.leftMargin:
                    //Layout.topMargin: 10
                    spacing: 35
                    Column {
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Text {
                            text: "Оборудование"
                            font.pixelSize: 14
                        }

                        ComboBox {
                            id: id_equipment
                            width: 200
                            font.pixelSize: 14
                            textRole: "EQUIPMENT_NAME"
                            currentIndex: -1
                            model:managerDB.createModel("SELECT ID, equipment_name FROM table_equipment")

                            onCurrentIndexChanged: {
                                id_unit.model.query = "SELECT ID, unit_name FROM table_units WHERE id_equipment = "+
                                        id_equipment.model.get(id_equipment.currentIndex)["ID"]
                                id_unit.currentIndex = -1
                            }
                        }
                    }

                    Column {
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Text {
                            text: "Узел"
                            font.pixelSize: 14
                        }

                        ComboBox {
                            id: id_unit
                            width: 200
                            font.pixelSize: 14
                            textRole: "UNIT_NAME"
                            currentIndex: -1
                            model: managerDB.createModel("SELECT ID, unit_name FROM table_units")
                        }
                    }
                }
            }
        }

        Frame {
            id: frame2
            enabled: frame4.state === "normal" ? false : true
            //            leftPadding: 20
            //            rightPadding: 20
            topPadding: 12
            bottomPadding: 7

            anchors.margins: 10

            //anchors.top: frame4.bottom//header_rectangle.bottom
            anchors.bottom: frame3.top
            anchors.left: frame1.right
            //width: 450
            anchors.right: parent.right
            height: frame1.height
            background: Rectangle {
                anchors.fill: parent
                color: "Transparent"
                border.width: 0
            }
            ColumnLayout {

                Column {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Text {
                        text: "Вид работ"
                        font.pixelSize: 14
                    }

                    ComboBox {
                        id: id_typeofwork
                        width: 260
                        //Layout.fillWidth: true
                        font.pixelSize: 14
                        textRole: "TYPE_NAME"
                        currentIndex: -1
                        model: managerDB.createModel("SELECT ID, type_name FROM table_type_of_work")
                    }
                }
                Column {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Text {
                        text: "Наименование"
                        font.pixelSize: 14
                    }

                    ComboBox {
                        id: id_jobtitle
                        width: 260
                        //Layout.fillWidth: true
                        font.pixelSize: 14
                        textRole: "JOB_NAME"
                        currentIndex: -1
                        model: managerDB.createModel("SELECT ID, job_name FROM table_job_title")
                    }
                }

                Column {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Text {
                        text: "Доза"
                        //anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 14
                    }

                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 20
                        TextField {
                            id: id_dose_value
                            width: 80
                            height: 48
                            bottomPadding: 14
                            topPadding: 8
                            //leftPadding: 8
                            horizontalAlignment: Text.AlignHCenter
                            text: "0,00"
                            font.pixelSize: 16
                            selectByMouse: true

                            validator: DoubleValidator {
                                notation: DoubleValidator.StandardNotation
                            }
                        }

                        ComboBox {
                            id: id_measure
                            width: 100
                            currentIndex: 0
                            model: ["мЗв/ч", "мкЗв/ч"]
                        }
                    }
                }

                RowLayout {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    //Layout.leftMargin: 10
                    Layout.topMargin: 10
                    spacing: 35

                    Column {
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                        Text {
                            text: "Кол-во человек"
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 14
                        }

                        TextField {
                            id: id_people_cnt
                            width: 80
                            //height: 48
                            horizontalAlignment: Text.AlignHCenter
                            text: "0"
                            font.pixelSize: 16
                            selectByMouse: true
                            validator: IntValidator {
                                bottom: 0
                                top: 1000
                            }
                        }
                    }

                    Column {
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                        Text {
                            text: "Текущие сутки"
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 14
                        }

                        TextField {
                            id: id_cur_day
                            width: 80
                            //height: 48
                            horizontalAlignment: Text.AlignHCenter
                            text: "0"
                            font.pixelSize: 16
                            selectByMouse: true
                            validator: IntValidator {
                                bottom: 0
                                top: 1000
                            }
                        }
                    }
                }

            }
        }

        Frame {
            id: frame3
            clip: true
            enabled: frame4.state === "normal" ? false : true
            //            leftPadding: 20
            //            rightPadding: 20
            topPadding: 12
            bottomPadding: 7

            anchors.margins: 10

            anchors.bottom: parent.bottom
            //anchors.top: frame1.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            //width: 450

            //height: frame1.height
            background: Rectangle {
                anchors.fill: parent
                color: "Transparent"
                border.width: 0
            }
            ColumnLayout {
                CheckBox {
                    id: id_chb_rad
                    text: "радиационная обстановка до начала работ"
                    font.pixelSize: 14
                    leftPadding: 0
                    topPadding: 0
                    bottomPadding: 0
                }
                RowLayout {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    //Layout.leftMargin: 10
                    Layout.topMargin: 10
                    spacing: 30

                    Column {
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                        Text {
                            text: "Гамма"
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 14
                        }

                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 10
                            TextField {
                                id: id_rad_gamma
                                width: 80
                                //height: 48
                                horizontalAlignment: Text.AlignHCenter
                                text: "0,00"
                                font.pixelSize: 16
                                selectByMouse: true
                                enabled: id_chb_rad.checked ? true : false
                                validator: DoubleValidator {
                                    notation: DoubleValidator.StandardNotation
                                }
                            }
                            Text {
                                text: id_measure.currentText
                                anchors.bottom: parent.bottom
                                font.pixelSize: 14
                                bottomPadding: 6
                                width: 45
                            }

                        }
                    }

                    Column {
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Text {
                            text: "Нейтронная"
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 14
                        }
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 10
                            TextField {
                                id: id_rad_neutr
                                width: 80
                                //height: 48
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 16

                                text: "0,00"
                                selectByMouse: true
                                enabled: id_chb_rad.checked ? true : false
                                validator: DoubleValidator {
                                    notation: DoubleValidator.StandardNotation
                                }
                            }
                            Text {
                                text: id_measure.currentText
                                font.pixelSize: 14
                                bottomPadding: 6
                                anchors.bottom: parent.bottom
                                width: 45
                            }
                        }
                    }

                    Column {
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Text {
                            text: "Бета"
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 14
                        }
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 10
                            TextField {
                                id: id_rad_beta
                                width: 80
                                //height: 48
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 16

                                text: "0,00"
                                selectByMouse: true
                                enabled: id_chb_rad.checked ? true : false
                                validator: DoubleValidator {
                                    notation: DoubleValidator.StandardNotation
                                }
                            }
                            Text {
                                text: "част./кв.см мин"
                                font.pixelSize: 14
                                bottomPadding: 6
                                anchors.bottom: parent.bottom
                            }
                        }
                    }

                    Column {
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Text {
                            text: "Альфа"
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 14
                        }
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 10
                            TextField {
                                id: id_rad_alfa
                                width: 80
                                //height: 48
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 16

                                text: "0,00"
                                selectByMouse: true
                                enabled: id_chb_rad.checked ? true : false
                                validator: DoubleValidator {
                                    notation: DoubleValidator.StandardNotation
                                }
                            }
                            Text {
                                text: "част./кв.см мин"
                                font.pixelSize: 14
                                bottomPadding: 6
                                anchors.bottom: parent.bottom
                            }
                        }
                    }
                }
            }
        }

    }

    Button {
        id: ok_button
        width: 120
        //anchors.margins: 10
        anchors.bottomMargin: 10
        anchors.rightMargin: 20
        text: "Сохранить"
        font.pixelSize: 14
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        onClicked: {

            switch (item2.state) {
            case "edit":
                item2.edit_confirm(tasks_list_model)
                item2.clearAll()
                break

            case "wizard":
                item2.wizard_next(tasks_list_model)
                break
            }
        }
    }

    Button {
        id: cancel_button
        width: ok_button.width
        anchors.bottomMargin: 10
        anchors.leftMargin: 20
        text: "Отмена"
        font.pixelSize: 14
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        onClicked: {
            switch (item2.state) {
            case "edit":
                item2.edit_cancel()
                //item2.clearfields()
                break

            case "wizard":
                //tasks_list_model.clear()
                item2.wizard_back()
                break
            }
            item2.clearAll()
        }
    }
}
