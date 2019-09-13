import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

import Qt.labs.calendar 1.0
//import Foo 1.0

Page {
    id: page_d1
    visible: true

        width: 1200
        height: 900
    property int space_margin: 15


    property variant wizard_doznaryad: ({}) //все поля при создании нового дознаряда [doz_main, doz_tasks, doz_workers]
    property int current_doz_ID: -1

    function wizard_save_to_DB() {
        var maprec = {}
        var res1, res2, i, j

        console.log("- - - - - wizard save to DB - - - - -")

        if (!justquery2.setpoint()) {
            return -1
        };

        console.log("- - - - - MAIN - - - - -")
        wizard_doznaryad["DOZ_MAIN"]["SPECIAL_COMMENT"] = wizard_doznaryad["DOZ_WORKERS"]["COMMENT"]
        if ( justquery2.insertRecordIntoTable("Doznaryad", "TABLE_DOZNARYAD", wizard_doznaryad["DOZ_MAIN"]) ) {

            res1 = justquery2.getMaxID("Doznaryad", "TABLE_DOZNARYAD", "DOZ_NUMBER", wizard_doznaryad["DOZ_MAIN"]["DOZ_NUMBER"])

            if (res1 === -1 ) {
                //database.rollback()
                return -1;
            }
            console.log(" > insert new record into TABLE_DOZNARYAD, record ID: " + res1)

            console.log("- - - - - TASKS - - - - -")
            for(i = 0; i < wizard_doznaryad["DOZ_TASKS"].count; i++) {
                maprec["ID_BLOK"] = wizard_doznaryad["DOZ_TASKS"].get(i)["ID_BLOK"]
                maprec["ID_EQUIPMENT"] = wizard_doznaryad["DOZ_TASKS"].get(i)["ID_EQUIPMENT"]
                maprec["ID_UNIT"] = wizard_doznaryad["DOZ_TASKS"].get(i)["ID_UNIT"]
                maprec["ID_TYPE_OF_WORK"] = wizard_doznaryad["DOZ_TASKS"].get(i)["ID_TYPE_OF_WORK"]
                maprec["ID_JOB_TITLE"] = wizard_doznaryad["DOZ_TASKS"].get(i)["ID_JOB_TITLE"]
                maprec["DOSE_VALUE"] = wizard_doznaryad["DOZ_TASKS"].get(i)["DOSE_VALUE"]
                maprec["MEASURE"] = wizard_doznaryad["DOZ_TASKS"].get(i)["MEASURE"]
                maprec["PEOPLE_CNT"] = wizard_doznaryad["DOZ_TASKS"].get(i)["PEOPLE_CNT"]
                maprec["CURRENT_DAY"] = wizard_doznaryad["DOZ_TASKS"].get(i)["CURRENT_DAY"]

                maprec["CHB_RAD_STATE"] = wizard_doznaryad["DOZ_TASKS"].get(i)["CHB_RAD_STATE"]
                maprec["GAMMA_VALUE"] = wizard_doznaryad["DOZ_TASKS"].get(i)["GAMMA_VALUE"]
                maprec["BETA_VALUE"] = wizard_doznaryad["DOZ_TASKS"].get(i)["BETA_VALUE"]
                maprec["NEUTRON_VALUE"] = wizard_doznaryad["DOZ_TASKS"].get(i)["NEUTRON_VALUE"]
                maprec["ALFA_VALUE"] = wizard_doznaryad["DOZ_TASKS"].get(i)["ALFA_VALUE"]

                maprec["ID_DOZNARYAD"] = res1

                //сохраняем в БД, в res2 получаем ID добавленной записи
                if ( !justquery2.insertRecordIntoTable("Doznaryad", "TABLE_TASKS", maprec) ) {
                    //database.rollback()
                    return -1;
                }

                res2 = justquery2.getMaxID("Doznaryad", "TABLE_TASKS", "ID_DOZNARYAD", res1)
                if (res2 === -1) {
                    //database.rollback()
                    return -1;
                }
                console.log("insert new record into TABLE_TASKS, record ID: " + res2)

                maprec = {}

                if (typeof wizard_doznaryad["DOZ_TASKS"].get(i)["ROOMS"] !== undefined) {
                    for(j = 0; j < wizard_doznaryad["DOZ_TASKS"].get(i)["ROOMS"].count; j++) {
                        maprec["ID_TASK"] = res2
                        maprec["ID_ROOM"] = wizard_doznaryad["DOZ_TASKS"].get(i)["ROOMS"].get(j)["ID"]

                        if ( !justquery2.insertRecordIntoTable("Doznaryad", "TABLE_TASKS_ROOMS_CON", maprec) ) {
                            //database.rollback()
                            return -1;
                        }
                        console.log("    room id: " + wizard_doznaryad["DOZ_TASKS"].get(i)["ROOMS"].get(j)["ID"])
                    }
                    maprec = {}
                }
            }

            console.log("- - - - - WORKERS - - - - -")
            maprec["ID_DOZNARYAD"] = res1
            for(i = 0; i < wizard_doznaryad["DOZ_WORKERS"]["WORKERS"].count; i++) {
                maprec["id_worker"] = wizard_doznaryad["DOZ_WORKERS"]["WORKERS"].get(i)["ID_PERSON"]

                if ( !justquery2.insertRecordIntoTable("Doznaryad","TABLE_BRIGADE_CON", maprec) ) {
                    //database.rollback()
                    return -1;
                }
                console.log("    worker id: " + wizard_doznaryad["DOZ_WORKERS"]["WORKERS"].get(i)["ID_PERSON"])
            }
            maprec = {}


            console.log("- - - - - SIZ - - - - -")
            maprec["ID_DOZNARYAD"] = res1
            for(i = 0; i < wizard_doznaryad["DOZ_WORKERS"]["SIZ"].count; i++) {
                maprec["ID_SPECIALS"] = wizard_doznaryad["DOZ_WORKERS"]["SIZ"].get(i)["ID"]

                if ( !justquery2.insertRecordIntoTable("Doznaryad","TABLE_DOZNARYAD_SPECIALS_CON", maprec) ) {
                    //database.rollback()
                    return -1;
                }
                console.log("    SIZ id: " + wizard_doznaryad["DOZ_WORKERS"]["SIZ"].get(i)["ID"])
            }

            console.log("- - - - - RB - - - - -")
            for(i = 0; i < wizard_doznaryad["DOZ_WORKERS"]["RB"].count; i++) {
                maprec["ID_SPECIALS"] = wizard_doznaryad["DOZ_WORKERS"]["RB"].get(i)["ID"]

                if ( !justquery2.insertRecordIntoTable("Doznaryad", "TABLE_DOZNARYAD_SPECIALS_CON", maprec) ) {
                    //database.rollback()
                    return -1;
                }
                console.log("    RB id: " + wizard_doznaryad["DOZ_WORKERS"]["RB"].get(i)["ID"])
            }
            maprec = {}

            if ( !justquery2.commit()) {
                //justquery.rollback()
                return -1;
            }

            delete wizard_doznaryad["DOZ_MAIN"]
            delete wizard_doznaryad["DOZ_TASKS"]
            delete wizard_doznaryad["DOZ_WORKERS"]
            wizard_doznaryad = {}

            return res1

        } else {
            //database.rollback()
            return -1;
        }
    }

    //сделать активным элемент списка
    function select_doznaryad(id_index) {
        listview.currentIndex = -1;
        for(var i = dozModel.rowCount()-1; i >= 0; --i) {
            if (dozModel.get(i)["ID"] === id_index) {
                listview.currentIndex = i;
                break;
            }
        }
    }

    header: ToolBar {
        leftPadding: 8
        font.pointSize: 12

        RowLayout {
            ToolButton {
                id: newButton
                text: "Новый"
                //font.pointSize: 12
                onClicked: {
                    newdoznaryad.state = "wizard"
                    addtask.state = "wizard"
                    addworker.state = "wizard"
                    create_new_popup.open()
                }
            }
            ToolButton {
                id: copyButton
                text: "Копия"
                //font.pointSize: 12
                enabled: false
                onClicked: {

                }
            }
            ToolButton {
                id: delButton
                text: "Удалить"
                //enabled: false
                onClicked: {
                    mymsgbox_popup.operation_name = "delete"
                    mymsgbox_popup.anyquestion("Вы уверены, что хотите удалить запись?")
                }
            }

            ToolSeparator {
            }
            ToolButton {
                text: "Выборки"
                enabled: false
            }
            ToolButton {
                text: "Справочники"
                enabled: false
            }
            ToolButton {
                text: "ТЛД"
                enabled: false
            }
            ToolSeparator {
            }
            ToolButton {
                text: "Обновить"
                onClicked: {
                    dozModel.updateModel()
                }
            }
            ToolButton {
                text: "Печать"
                enabled: false
            }
            ToolSeparator {
            }

            ToolButton {
                text: "Очередь"
                enabled: false
            }
        }
    }

    Connections{
        target: dozModel
        onSignalUpdateDone: {
            //console.log("- - - - - dozModel row count: "+dozModel.rowCount())
            if (current_doz_ID === -1)  {
                if (dozModel.rowCount() > 0) {
                    select_doznaryad(dozModel.get(dozModel.rowCount()-1)["ID"])
                }
            } else
                select_doznaryad(current_doz_ID)
        }
    }

    Popup {
        id: mymsgbox_popup
        width: mymsgbox.width + padding*2   // 500
        height: mymsgbox.height + padding*2// 500

        modal: true
        focus: true
        closePolicy: Popup.NoAutoClose
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        padding: 0

        property string operation_name: ""

        function pleasewait () {
            mymsgbox.state = "info"
            mymsgbox.runnig = true
            mymsgbox.btn_enabled = false
            mymsgbox.msgtext = ""

            if (!mymsgbox_popup.opened)
                mymsgbox_popup.open()
        }

        function iamready (txt_string) {
            mymsgbox.state = "info"
            mymsgbox.runnig = false
            mymsgbox.btn_enabled = true
            mymsgbox.msgtext = txt_string
        }

        function anyquestion(txt_string) {
            mymsgbox.state = "question"
            mymsgbox.btn_enabled = true
            mymsgbox.msgtext = txt_string
            mymsgbox_popup.open()
        }

        MsgBox {
            id: mymsgbox
            onClickOK: {
                if (mymsgbox_popup.operation_name === "delete") {

                    mymsgbox_popup.operation_name === "info"

                    mymsgbox_popup.pleasewait()
                    justquery2.deleteDose(dozModel.get(listview.currentIndex)["ID"])

                    dozModel.updateModel()
                    mymsgbox_popup.iamready("Запись успешно удалена")

                    //--

                    //--

                }

                if (mymsgbox_popup.operation_name === "add new") {
                    mymsgbox_popup.close()
                }
            }
            onClickCancel: {
                mymsgbox_popup.close()
            }
        }
    }

    Popup {
        id: create_new_popup
        width: newdoznaryad.width + padding*2   // 500
        height: newdoznaryad.height + padding*2// 500

        modal: true
        focus: true
        closePolicy: Popup.NoAutoClose
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        padding: 0

        New_doznaryad {
            id: newdoznaryad

            //нажатие кнопки "Next"
            onWizard_next: {
                wizard_doznaryad["DOZ_MAIN"] = data_record
                create_new_popup.close()
                add_task_popup.open()
            }

            onWizard_cancel: { create_new_popup.close() }
            onEdit_cancel: { create_new_popup.close() }

            onEdit_confirm: {
                create_new_popup.close()
                mymsgbox_popup.operation_name = "add new"
                mymsgbox_popup.pleasewait()

                data_record["ID"] = dozModel.get(listview.currentIndex)["ID"]
                current_doz_ID = dozModel.get(listview.currentIndex)["ID"]

                if (justquery.updateRecord("Doznarayd","TABLE_DOZNARYAD", data_record)) {
                    dozModel.updateModel() //.update_data()

                    mymsgbox_popup.iamready("Запись успешно обновлена")
                    //select_doznaryad(data_record["ID"])
                } else {
                    /* Ошибка */
                    mymsgbox_popup.iamready("ОШИБКА обновления !")
                };


            }
        }
    }

    Popup {
        id:add_task_popup
        width: addtask.width + padding*2
        height: addtask.height + padding*2

        modal: true
        focus: true
        closePolicy: Popup.NoAutoClose
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        padding: 0

        Add_task {
            id: addtask

            //нажатие кнопки "Next"
            onWizard_next: {
                wizard_doznaryad["DOZ_TASKS"] = data_record
                add_task_popup.close()
                add_worker_popup.open()
            }

            //нажатие кнопки "Назад"
            onWizard_back: {
                delete wizard_doznaryad["DOZ_MAIN"]

                add_task_popup.close()
                create_new_popup.open()
            }

            onEdit_cancel: {
                add_task_popup.close()
            }

            onEdit_confirm: {
                add_task_popup.close()
                mymsgbox_popup.operation_name = "add new"
                mymsgbox_popup.pleasewait()

                var tmap = {}, i = 0, j=0, res;

                console.log("Insert records count: "+data_record.rowCount())

                for (i=0; i < data_record.rowCount(); i++) {
                    console.log("edit ID task: "+data_record.get(i)["ID"])
                    tmap["ID_TASK"] = data_record.get(i)["ID"]
                    justquery2.deleteRecord("addtask_edit", "TABLE_TASKS_ROOMS_CON", tmap)
                }
                tmap = {}

                tmap["ID_DOZNARYAD"] = dozModel.get(listview.currentIndex)["ID"]
                justquery2.deleteRecord("addtask_edit", "TABLE_TASKS", tmap)
                tmap = {}

                for(i=0; i < data_record.rowCount(); i++) {
                    tmap["ID_DOZNARYAD"] = dozModel.get(listview.currentIndex)["ID"]

                    tmap["ID_BLOK"] = data_record.get(i)["ID_BLOK"]
                    tmap["ID_EQUIPMENT"] = data_record.get(i)["ID_EQUIPMENT"]
                    tmap["ID_UNIT"] = data_record.get(i)["ID_UNIT"]
                    tmap["ID_TYPE_OF_WORK"] = data_record.get(i)["ID_TYPE_OF_WORK"]
                    tmap["ID_JOB_TITLE"] = data_record.get(i)["ID_JOB_TITLE"]
                    tmap["DOSE_VALUE"] = data_record.get(i)["DOSE_VALUE"]
                    tmap["MEASURE"] = data_record.get(i)["MEASURE"]
                    tmap["PEOPLE_CNT"] = data_record.get(i)["PEOPLE_CNT"]
                    tmap["CURRENT_DAY"] = data_record.get(i)["CURRENT_DAY"]
                    tmap["CHB_RAD_STATE"] = data_record.get(i)["CHB_RAD_STATE"]
                    tmap["GAMMA_VALUE"] = data_record.get(i)["GAMMA_VALUE"]
                    tmap["BETA_VALUE"] = data_record.get(i)["BETA_VALUE"]
                    tmap["NEUTRON_VALUE"] = data_record.get(i)["NEUTRON_VALUE"]
                    tmap["ALFA_VALUE"] = data_record.get(i)["ALFA_VALUE"]

                    //сохраняем в БД, в res2 получаем ID добавленной записи
                    if ( !justquery2.insertRecordIntoTable("addtask_edit", "TABLE_TASKS", tmap) ) {
                        //database.rollback()
                        return -1;
                    }
                    res = justquery2.getMaxID("addtask_edit", "TABLE_TASKS", "ID_DOZNARYAD", tmap["ID_DOZNARYAD"])
                    if (res === -1) {
                        //database.rollback()
                        return -1;
                    }
                    tmap = {}

                    console.log("insert new record into TABLE_TASKS, record ID: " + res)

                    if (typeof data_record.get(i)["ROOMS"] !== undefined) {
                        for(j = 0; j < data_record.get(i)["ROOMS"].count; j++) {
                            tmap["ID_TASK"] = res
                            tmap["ID_ROOM"] = data_record.get(i)["ROOMS"].get(j)["ID"]

                            if ( !justquery2.insertRecordIntoTable("Doznaryad", "TABLE_TASKS_ROOMS_CON", tmap) ) {
                                //database.rollback()
                                return -1;
                            }
                        }
                        tmap = {}
                    }

                }

                dozModel.updateModel()
                mymsgbox_popup.iamready("Запись успешно обновлена")
            }
        }
    }

    Popup {
        id:add_worker_popup
        width: addtask.width + padding*2
        height: addtask.height + padding*2

        modal: true
        focus: true
        closePolicy: Popup.NoAutoClose
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        padding: 0

        Add_worker {
            id: addworker

            //нажатие кнопки "Next/Сохранить"
            onWizard_next: {
                add_worker_popup.close()
                mymsgbox_popup.operation_name = "add new"
                mymsgbox_popup.pleasewait()

                wizard_doznaryad["DOZ_WORKERS"] = data_record //["workers", "siz", "rb", "comment"]
                var res = page_d1.wizard_save_to_DB()

                if (res !== -1) {
                    current_doz_ID = res
                    //console.log("! Запись добавлена !")
                    dozModel.updateModel() //.update_data()
                    mymsgbox_popup.iamready("Запись успешно добавлена")
                } else {
                    //console.log("! ОШИБКА записи в основную БД !")
                    mymsgbox_popup.iamready("ОШИБКА записи в Базу Данных !")
                }

                //Очистить все формы
                addworker.clearfields()
                addtask.clearAll()
                newdoznaryad.clearfields()
            }

            //нажатие кнопки "Назад"
            onWizard_back: {
                delete wizard_doznaryad["DOZ_TASKS"]

                add_worker_popup.close()
                add_task_popup.open()
            }

            onEdit_cancel: {
                add_worker_popup.close()
            }

            onEdit_confirm: {
                add_worker_popup.close()
                mymsgbox_popup.pleasewait()

                var tmap={}, i=0

                tmap["ID_DOZNARYAD"] = dozModel.get(listview.currentIndex)["ID"]
                justquery2.deleteRecord("addworker_edit", "TABLE_BRIGADE_CON", tmap)
                justquery2.deleteRecord("addworker_edit", "TABLE_DOZNARYAD_SPECIALS_CON", tmap)
                tmap = {};

                tmap["ID"] = dozModel.get(listview.currentIndex)["ID"]
                tmap["SPECIAL_COMMENT"] = data_record["COMMENT"]
                justquery2.updateRecord("addworker_edit","TABLE_DOZNARYAD", tmap)
                tmap = {};

                tmap["ID_DOZNARYAD"] = dozModel.get(listview.currentIndex)["ID"]
                for(i = 0; i < data_record["WORKERS"].count; i++) {
                    tmap["ID_WORKER"] = data_record["WORKERS"].get(i)["ID_PERSON"]
                    justquery2.insertRecordIntoTable("addworker_edit", "TABLE_BRIGADE_CON", tmap)
                }
                tmap = {}

                tmap["ID_DOZNARYAD"] = dozModel.get(listview.currentIndex)["ID"]
                for(i = 0; i < data_record["SIZ"].count; i++) {
                    tmap["ID_SPECIALS"] = data_record["SIZ"].get(i)["ID"]
                    justquery2.insertRecordIntoTable("addworker_edit", "TABLE_DOZNARYAD_SPECIALS_CON", tmap)
                }
                for(i = 0; i < data_record["RB"].count; i++) {
                    tmap["ID_SPECIALS"] = data_record["RB"].get(i)["ID"]
                    justquery2.insertRecordIntoTable("addworker_edit", "TABLE_DOZNARYAD_SPECIALS_CON", tmap)
                }
                tmap = {}

                dozModel.updateModel() //.update_data()

                mymsgbox_popup.iamready("Запись успешно обновлена")
            }
        }
    }

    //Оперативная доза
    Popup {
        id: op_dose_popup

        width: addtask.width + padding*2
        height: addtask.height + padding*2

        modal: true
        focus: true
        closePolicy: Popup.NoAutoClose
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        padding: 0

        Add_oper_dose {
            id: addopdose

            onSet_OK: {
                op_dose_popup.close()
            }

            onSet_Cancel: {
                op_dose_popup.close()
            }
        }
    }

    Pane {
        id: frame1
        wheelEnabled: true
        width: 215
        anchors.margins: 0//8
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        padding: 0

        background: Rectangle {
            anchors.fill: parent
            color: Material.color(Material.Grey, Material.Shade800)
        }

        //модель для колонок таблицы | название колонки и ширина
        ListModel {
            id: header_model
            ListElement { name: "Номер"; width_val: 170; trole: "DOZ_NUMBER"}
        }

        //компонент - строка в таблице
        Component {
            id: listitem_delegate

            ItemDelegate {
                id: listitem_wrapper
                width: parent.width-20

                //property int row: index

                onClicked: {
                    listview.currentIndex = index
                }

                Column {
                    id: column
                    anchors.margins: 0
                    spacing: 0
                    Rectangle {
                        width: r1.width-22
                        height: 1
                        color: "Grey"//Material.color(Material.Grey, Material.shade800)
                        border.width: 0
                    }
                    Row {
                        id: row
                        spacing: 0

                        Rectangle {
                            id: color_state
                            width:  (listview.currentIndex === index) ? 12 : 5
                            height: listitem_wrapper.height
                            color: STATE_COLOR

                            border.color: "Transparent"
                            border.width: 0
                        }

                        Rectangle {
                            width: 1
                            height: listitem_wrapper.height
                            color: Material.color(Material.Grey, Material.Shade800) //
                            border.color: "Transparent"
                            border.width: 0
                        }

                        Column {
                            height: listitem_wrapper.height
                            spacing: 3

                            Text {
                                text: DOZ_NUMBER

                                width: 170
                                leftPadding: 10
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: 16
                                color: (listview.currentIndex === index) ? "DeepBlue" : "White"
                            }
                            Text {
                                text: STATE_NAME

                                leftPadding: 10
                                color: (listview.currentIndex === index) ? "darkslategrey" : "grey"
                                font.pixelSize: 14
                            }
                        }
                    }
                }
            }
        }

        //заголовок
        Rectangle {
            id: r1
            anchors.top: parent.top
            width: parent.width
            height: 48//fnumbertext.height//+20

            color: Material.color(Material.Grey, Material.Shade100)//Material.color(Material.BlueGrey, Material.Shade500)//Material.color(Material.LightBlue, Material.Shade300)

            SwitchDelegate {
                id: sw_filter
                text: "Включить фильтр"
                anchors.right: parent.right
                highlighted: false
                font.pixelSize: 14
            }

//            TextField {
//                id: fnumbertext
//                horizontalAlignment: Text.AlignHCenter
//                font.pixelSize: 16
//                anchors.centerIn: parent
//                placeholderText: "Поиск"

//                //font.family: materialFont.name //"materialdesignicons-webfont"
//                color: "White"

//                onTextChanged: {
//                    //mytimer.restart()
//                }

//                onActiveFocusChanged: {
//                    if (!activeFocus) {
//                        img_findnumber.activst = false
//                    } else
//                        img_findnumber.activst = true
//                }
//            }

//            Image {
//                id: img_findnumber
//                property bool activst: false
//                width: 32
//                height: 32
//                opacity: 0.6
//                sourceSize.height: 32
//                sourceSize.width: 32
//                fillMode: Image.Stretch
//                source: activst ? "icons/close.svg" : "icons/magnify.svg"
//                anchors.right: parent.right
//                anchors.rightMargin: 10
//                anchors.verticalCenter: parent.verticalCenter

//                MouseArea {
//                    anchors.fill: parent

//                    onClicked: {
//                        if (img_findnumber.activst) {
//                            fnumbertext.text = ""
//                            img_findnumber.activst = false
//                            fnumbertext.focus = false
//                        }
//                    }
//                }
//            }
        } // - конец заголовок

        Rectangle {
            id: r_filter
            anchors.top: r1.bottom
            width: parent.width
            height: sw_filter.checked ? 120:0 //fnumbertext.height//+20
            //height:200
            clip: true
            color: Material.color(Material.Grey, Material.Shade300)
            Column {
                Text {
                    id: name
                    text: qsTr("Отображать")
                    font.pixelSize: 12
                }
                ComboBox {
                    model: ["1 месяц", "3 месяца", "6 месяцев", "1 год", "все"]
                    currentIndex: 0
                }
                CheckBox {
                    text: "только распоряжения"
                }
            }
       }
        ListView {
            id: listview
            anchors.top: r_filter.bottom//r1.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            model: dozModel
            clip: true
            focus: true

            leftMargin: 3
            topMargin: 3

            delegate: listitem_delegate

            highlight: Rectangle {
                color: Material.color(Material.Grey, Material.Shade200)
            }
            highlightMoveDuration: 0

            onCurrentIndexChanged: {
                //console.log("- listview : current index changed")

                if (currentIndex !== -1) {
                    addtask.doznaryad_num = dozModel.get(currentIndex)["ID"]

                    //обновление модели заданий
                    task_listview.update_model(dozModel.get(currentIndex)["ID"])

                    //обновление модели Бригады
                    workers_table.update_model(dozModel.get(currentIndex)["ID"])

                    lb_status.text = dozModel.get(currentIndex)["STATE_NAME"]

                    lb_name.text = dozModel.get(currentIndex)["DOZ_DIRECTIVE"] ? "Распоряжение №:" : "Наряд-допуск №:"//ID
                    txt_name.text = dozModel.get(currentIndex)["DOZ_NUMBER"]

                    d1.text1_value = dozModel.get(currentIndex)["DEPARTMENT"]
                    d2.text1_value = dozModel.get(currentIndex)["RESPONSIBLE"]
                    d2.text2_value = Qt.formatDate(dozModel.get(currentIndex)["DOZ_GET_DATE"], "dd.MM.yyyy")
                    d3.text1_value = dozModel.get(currentIndex)["LEADER"]
                    d4.text1_value = dozModel.get(currentIndex)["PRODUCER"]
                    d5.text1_value = dozModel.get(currentIndex)["OPEN_WORKER"]
                    d5.text2_value = Qt.formatDate(dozModel.get(currentIndex)["OPEN_DATE"], "dd.MM.yyyy")
                    d6.text1_value = dozModel.get(currentIndex)["CLOSE_WORKER"]
                    d6.text2_value = Qt.formatDate(dozModel.get(currentIndex)["CLOSE_DATE"], "dd.MM.yyyy")
                    d7.text1_value = dozModel.get(currentIndex)["AGREED"]

                    d8.text1_value = dozModel.get(currentIndex)["PERMITTED_DOSE"].toFixed(3) + " мЗв"
                    d9.text1_value = Qt.formatDateTime(dozModel.get(currentIndex)["START_OF_WORK"], "hh:mm dd.MM.yyyy")
                    d10.text1_value = Qt.formatDateTime(dozModel.get(currentIndex)["END_OF_WORK"], "hh:mm dd.MM.yyyy")
                    d11.text1_value = dozModel.get(currentIndex)["PERMITTED_TIME"] + " мин."
                    d12.text1_value = dozModel.get(currentIndex)["SUM_DOSE"].toFixed(3) + " мЗв"
                    d13.text1_value = dozModel.get(currentIndex)["OVER_DOSE"].toFixed(3) + " мЗв"
                    d14.text1_value = dozModel.get(currentIndex)["COLLECTIVE_DOSE"].toFixed(3) + " мЗв"

                    txt_rb_options.text = dozModel.get(currentIndex)["RB_OPTION_LIST"]
                    txt_siz_options.text = dozModel.get(currentIndex)["SIZ_OPTION_LIST"]

                    txt_special_conditions.text = dozModel.get(currentIndex)["SPECIAL_COMMENT"]
                }
            }

            ScrollBar.vertical: ScrollBar {
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

    Frame {
        id: frame2
        //height: contentHeight+24 //190
        width: 400
        anchors.margins: space_margin
        anchors.left: frame1.right
        anchors.top: frame4.bottom

        background: Rectangle {
            anchors.fill: parent
            color: "White"
            border.color: "LightGray"
            radius: 2
        }
        Column {
            spacing: 5

            MyTextData {
                id: d1
                label1_name: "Цех:"
                text1_value: ""
                label2_name: ""
                text2_value: ""
            }
            MyTextData {
                id:d2
                label1_name: "Выдал:"
                text1_value: ""
                label2_name: "Дата:"
                text2_value: ""
            }
            MyTextData {
                id:d3
                label1_name: "Руководитель:"
            }
            MyTextData {
                id:d4
                label1_name: "Производитель:"
            }
            MyTextData {
                id:d5
                label1_name: "Открыл:"
                label2_name: "Дата:"
            }
            MyTextData {
                id:d6
                label1_name: "Закрыл:"
                label2_name: "Дата:"
            }

            MyTextData {
                id:d7
                label1_name: "Согласовано:"
            }
        }
    }

    //задание
    Frame {
        id: frame3
        height: 193
        anchors.margins: space_margin
        anchors.right: parent.right
        anchors.left: frame1.right
        anchors.top: frame2.bottom
        //anchors.bottom: frame6.top
        padding: 1
        topPadding: 1
        bottomPadding: 1


        background: Rectangle {
            anchors.fill: parent
            color: "White"
            border.color: "LightGray"
            radius: 2
        }

        //-----------
        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                height: 30
                Layout.fillWidth: true
                color: Material.color(Material.BlueGrey, Material.Shade500)

                Label {
                    leftPadding: 8
                    text: "Задание"
                    font.pixelSize: 16
                    color: "White"
                    //font.family: "icons\materialdesignicons-webfont.ttf"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle {
                    id: add_task_button
                    height: 27
                    width: 27//120
                    color: "transparent"//"LightGray"
                    border.color: "transparent"
                    //border.width: 2
                    radius: 2//12
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 3

                    Image {
                        id: edit_task_button_img
                        sourceSize.height: 25
                        sourceSize.width: 25
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                        fillMode: Image.PreserveAspectFit
                        source: "icons/settings.svg"//"icons/plus.svg"

                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled : true

                        onClicked: {
                            addtask.state = "edit"
                            //addtask.taskn_txt = (task_listview.model.rowCount()+1).toString()
                            addtask.load_edit_data(dozModel.get(listview.currentIndex)["ID"])
                            add_task_popup.open()
                        }

                        onEntered: {
                            edit_task_button_img.sourceSize.height = 30
                            edit_task_button_img.sourceSize.width = 30
                        }
                        onExited: {
                            edit_task_button_img.sourceSize.height = 25
                            edit_task_button_img.sourceSize.width = 25
                        }

                        onPressed: { add_task_button.border.color = "White" }
                        onReleased: { add_task_button.border.color = "transparent" }
                    }
                }

            }

            Pane {
                Layout.fillWidth: true
                Layout.fillHeight: true
                padding: 0

                background: Rectangle {
                    anchors.fill: parent
                    color: "Transparent"
                    border.width: 0
                }

                ListView {
                    id: task_listview
                    anchors.top: parent.top//r1.bottom
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    width: 150
                    clip: true
                    focus: true
                    leftMargin: 3
                    topMargin: 3
                    model: managerDB.createModel("")
//                    SqlQueryModel {
//                        id: doznaryad_tasks_model
//                    }
                    Connections {
                        target: task_listview.model
                        onSignalUpdateDone: {
                            task_listview.update_fields(0)
                        }
                    }
                    function update_model(doz_id_value) {
                        task_listview.model.query =
                        "SELECT T1.ID, T1.DOSE_VALUE, T1.PEOPLE_CNT, T1.CURRENT_DAY,
                        T1.GAMMA_VALUE, T1.BETA_VALUE, T1.NEUTRON_VALUE, T1.ALFA_VALUE,
                        T1.MEASURE, T1.CHB_RAD_STATE,
                        T2.EQUIPMENT_NAME, T3.UNIT_NAME, T5.JOB_NAME, T4.TYPE_NAME, T6.ZONE_NAME,
                        (
                         SELECT LISTAGG(Z0.ROOM_NAME, ', ') WITHIN GROUP (ORDER BY Z0.ROOM_NAME)
                         FROM TABLE_ROOMS Z0
                         INNER JOIN TABLE_TASKS_ROOMS_CON Z1 ON Z0.ID = Z1.ID_ROOM
                         WHERE Z1.ID_TASK = T1.ID
                        ) AS ROOMS_LIST
                        FROM (((((TABLE_TASKS T1
                        LEFT JOIN TABLE_EQUIPMENT T2 ON T1.ID_EQUIPMENT = T2.ID)
                        LEFT JOIN TABLE_UNITS T3 ON T1.ID_UNIT = T3.ID)
                        LEFT JOIN TABLE_TYPE_OF_WORK T4 ON T1.ID_TYPE_OF_WORK = T4.ID)
                        LEFT JOIN TABLE_JOB_TITLE T5 ON T1.ID_JOB_TITLE = T5.ID)
                        LEFT JOIN TABLE_ZONES T6 ON T1.ID_BLOK = T6.ID)
                        WHERE (T1.ID_DOZNARYAD = "+doz_id_value+")"
                    }

                    function update_fields(task_indx) {
                        task_listview.currentIndex = task_indx

                        if (task_listview.model.rowCount() === 0) {
                            id_tasks_rooms.text1_value = ""
                            //tasks_rooms.model.query = ""//clear()

                            id_task_blok.text1_value = ""
                            id_task_equipment.text1_value = ""
                            id_task_unit.text1_value = ""
                            id_task_typeofwork.text1_value = ""
                            id_task_jobtitle.text1_value = ""
                            id_task_people_curday.text1_value = ""
                            id_task_people_curday.text2_value = ""
                            id_task_dose.text1_value =""

                            id_task_gamma.text1_value = ""
                            id_task_beta.text1_value = ""
                            id_task_neutr.text1_value = ""
                            id_task_alfa.text1_value = ""
                        } else {
//                            tasks_rooms.model.query = "SELECT t0.room_name
//                                                       FROM table_rooms t0
//                                                       INNER JOIN table_tasks_rooms_con t1 ON t0.ID = t1.id_room
//                                                       WHERE t1.id_task = " + model.get(currentIndex)["ID"]
                            id_tasks_rooms.text1_value = model.get(currentIndex)["ROOMS_LIST"]

                            var tmeasure = (model.get(currentIndex)["MEASURE"] === 0) ? " мЗв":" мкЗв"

                            id_task_blok.text1_value = model.get(currentIndex)["ZONE_NAME"]
                            id_task_equipment.text1_value = model.get(currentIndex)["EQUIPMENT_NAME"]
                            id_task_unit.text1_value = model.get(currentIndex)["UNIT_NAME"]
                            id_task_typeofwork.text1_value = model.get(currentIndex)["TYPE_NAME"]
                            id_task_jobtitle.text1_value = model.get(currentIndex)["JOB_NAME"]
                            id_task_people_curday.text1_value = model.get(currentIndex)["PEOPLE_CNT"]
                            id_task_people_curday.text2_value = model.get(currentIndex)["CURRENT_DAY"]
                            id_task_dose.text1_value = model.get(currentIndex)["DOSE_VALUE"].toFixed(3) + tmeasure


                            if (model.get(currentIndex)["CHB_RAD_STATE"] === 1) {
                                id_task_gamma.text1_value = model.get(currentIndex)["GAMMA_VALUE"].toFixed(3) + tmeasure
                                id_task_beta.text1_value = model.get(currentIndex)["BETA_VALUE"].toFixed(3) + " част./кв.см мин"
                                id_task_neutr.text1_value = model.get(currentIndex)["NEUTRON_VALUE"].toFixed(3) + tmeasure
                                id_task_alfa.text1_value = model.get(currentIndex)["ALFA_VALUE"].toFixed(3) + " част./кв.см мин"
                            } else {
                                id_task_gamma.text1_value = ""
                                id_task_beta.text1_value = ""
                                id_task_neutr.text1_value = ""
                                id_task_alfa.text1_value = ""
                            }
                        }
                    }



                    delegate: ItemDelegate {
                        id: tasklist_delegate
                        text: "Задание "+(index+1).toString()
                        width: parent.width- tasklist_scroolbar.width-6
                        height: 25
                        font.pointSize: 10

                        //acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: {
                            //task_listview.currentIndex = index
                            task_listview.update_fields(index)
                        }
                    }

                    highlight: Rectangle {
                        color: Material.color(Material.Grey, Material.Shade200)
                    }
                    highlightMoveDuration: 0

                    ScrollBar.vertical: ScrollBar {
                        id: tasklist_scroolbar
                        policy: ScrollBar.AlwaysOn
                        anchors.top: parent.top
                        anchors.topMargin: parent.topPadding
                        anchors.right: parent.right
                        anchors.rightMargin: 1
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: parent.bottomPadding
                    }
                }

                Column {
                    id: task_column1
                    width: 500
                    leftPadding: 8
                    topPadding: 8
                    anchors.top: parent.top//r1.bottom
                    anchors.left: task_listview.right
                    //anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    spacing: 5

                    MyTextData {
                        id: id_task_blok
                        l1width: 110
                        label1_name: "Блок:"
                        text1_value: ""
                        label2_name: ""
                        text2_value: ""
                    }
                    MyTextData {
                        id: id_tasks_rooms
                        l1width: 110
                        label1_name: "Помещения:"
                        text1_value: ""
                        label2_name: ""
                        text2_value: ""
                    }
//                    Row {
//                        Label {
//                            width: 110
//                            text: "Помещения:"
//                            horizontalAlignment: Text.AlignLeft
//                            font.pointSize: 10
//                            rightPadding: 5
//                        }
//                        Row {
//                            Repeater {
//                                id: tasks_rooms
//                                model: managerDB.createModel("")
////                                model: SqlQueryModel {
////                                    id: doznaryad_tasks_rooms_model
////                                }
//                                Text {
//                                    //width: 100
//                                    text: ROOM_NAME+"; "
//                                    font.pointSize: 10
//                                    color: "steelblue"
//                                }
//                            }
//                        }

//                    }
                    MyTextData {
                        id: id_task_equipment
                        l1width: 110
                        label1_name: "Оборудование:"
                        text1_value: ""
                        label2_name: ""
                        text2_value: ""
                    }
                    MyTextData {
                        id: id_task_unit
                        l1width: 110
                        label1_name: "Узел:"
                        text1_value: ""
                        label2_name: ""
                        text2_value: ""
                    }
                    MyTextData {
                        id: id_task_typeofwork
                        l1width: 110
                        label1_name: "Вид работ:"
                        text1_value: ""
                        label2_name: ""
                        text2_value: ""
                    }
                    MyTextData {
                        id: id_task_jobtitle
                        l1width: 110
                        label1_name: "Наименование:"
                        text1_value: ""
                        label2_name: ""
                        text2_value: ""
                    }
                    MyTextData {
                        id: id_task_people_curday
                        l1width: 110
                        label1_name: "Кол-во человек:"
                        text1_value: ""
                        label2_name: "Текущие сутки:"
                        text2_value: ""
                    }
                }

                Column {
                    id: task_column2
                    leftPadding: 8
                    topPadding: 8
                    anchors.top: parent.top//r1.bottom
                    anchors.left: task_column1.right
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    spacing: 5
                    MyTextData {
                        id: id_task_dose
                        l1width: 90
                        label1_name: "Доза:"
                        text1_value: ""
                    }
                    MyTextData {
                        label1_name: ""
                        text1_value: ""
                    }
                    MyTextData {
                        l1width: 150
                        label1_name: "Радиационная обстановка до начала работ"
                        text1_value: ""
                    }
                    MyTextData {
                        id: id_task_gamma
                        l1width: 90
                        label1_name: "Гамма:"
                        text1_value: ""
                    }
                    MyTextData {
                        id: id_task_beta
                        l1width: 90
                        label1_name: "Бета:"
                        text1_value: ""
                    }
                    MyTextData {
                        id: id_task_neutr
                        l1width: 90
                        label1_name: "Нейтронная:"
                        text1_value: ""
                    }
                    MyTextData {
                        id: id_task_alfa
                        l1width: 90
                        label1_name: "Альфа:"
                        text1_value: ""
                    }
                }
            }
        }
    }

    Frame {
        id:frame4
        anchors.top: parent.top
        anchors.left: frame1.right
        anchors.right: parent.right
        height: r1.height//lb_name.height

        background: Rectangle {
            anchors.fill: parent
            color: Material.color(Material.BlueGrey, Material.Shade500) //"White"
            border.width: 0
        }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Label {
                id: lb_name
                text: "Наряд-допуск / Распоряжение №:"
                //font.family: "icons\materialdesignicons-webfont.ttf"
                color: "White"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.pointSize: 12
                font.bold: true
            }
            Text {
                id: txt_name
                anchors.leftMargin: 8
                text: "-"//???
                font.pointSize: 12
                color: "White"
                font.bold: true
            }
        }
    }

    Frame {
        id: frame5
        //height: frame2.height
        width: 300
        anchors.margins: space_margin

        //anchors.right: parent.right
        anchors.left: frame2.right
        anchors.top: frame4.bottom
        anchors.bottom: frame3.top

        background: Rectangle {
            anchors.fill: parent
            color: "White"
            border.color: "LightGray"
            radius: 2
        }

        Column {
            spacing: 5
            MyTextData {
                id:d8
                l1width: 130
                label1_name: "Разрешенная доза:"
            }
            MyTextData {
                id:d9
                l1width: 130
                label1_name: "Начало работ:"
            }
            MyTextData {
                id:d10
                l1width: 130
                label1_name: "Окончание работ:"
            }
            MyTextData {
                id:d11
                l1width: 130
                label1_name: "Разрешенное время:"
            }
            MyTextData {
                id:d12
                l1width: 130
                label1_name: "Суммарная доза:"
            }
            MyTextData {
                id:d13
                l1width: 130
                label1_name: "Превышение дозы:"
            }
            MyTextData {
                id:d14
                l1width: 130
                label1_name: "Коллективная доза:"
            }
        }
    }

    Frame {
        id: frame10
        anchors.margins: space_margin

        //anchors.right: parent.right
        anchors.left: frame5.right
        anchors.top: frame4.bottom
        anchors.bottom: frame3.top
        width: 225
        background: Rectangle {
            anchors.fill: parent
            color: Material.color(Material.BlueGrey, Material.Shade500)//"White"
            border.color: "LightGray"
            radius: 2
        }

        Rectangle {
            //id: rectangle

            height: 40
            anchors.right: parent.right
            anchors.left: parent.left
            color: "Transparent"
            border.color: (listview.currentIndex !== -1) ? dozModel.get(listview.currentIndex)["STATE_COLOR"]:"Transparent"
            border.width: 4

            Text {
                id: lb_status
                text: ""
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 14
                color: "White"
            }
        }
        Button {
            text: "Изменить статус"
            font.pixelSize: 14
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: 170
            height: 50
            onClicked: {
                newdoznaryad.state = "edit"
                newdoznaryad.load_edit_data(dozModel.get(listview.currentIndex))
                create_new_popup.open()
            }
        }
    }

    Frame {
        id: frame6
        anchors.margins: space_margin
        //height: 100
        anchors.right: parent.right
        anchors.left: frame1.right
        anchors.top: frame3.bottom
        anchors.bottom: frame7.top
        padding: 1
        topPadding: 1
        bottomPadding: 1

        background: Rectangle {
            anchors.fill: parent
            color: "White"
            border.color: "LightGray"
            radius: 2
        }

        //-----------
        ColumnLayout {
            anchors.fill: parent
            spacing: 0
            Rectangle {
                id: rectangle2
                height: 30
                Layout.fillWidth: true
                color: Material.color(Material.BlueGrey, Material.Shade500)//"LightGray"
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                Label {
                    leftPadding: 8
                    text: "Бригада"
                    color: "White"
                    //font.family: "icons\materialdesignicons-webfont.ttf"
                    font.pixelSize: 16
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle {
                    id: edit_brigade_button
                    height: 27
                    width: 27//120
                    color: "transparent"//
                    border.color: "transparent"
                    //border.width: 2
                    radius: 2//12
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 3

                    Image {
                        id: edit_brigade_button_img
                        sourceSize.height: 25
                        sourceSize.width: 25
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                        fillMode: Image.PreserveAspectFit
                        source: "icons/settings.svg"//"icons/plus.svg"

                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled : true
                        onClicked: {
                            addworker.state = "edit"
                            //addtask.taskn_txt = (doznaryad_tasks_model.rowCount()+1).toString()

                            var maprec = {}
                            maprec["WORKERS"] = workers_table.listview_model
                            maprec["SPECIAL_COMMENT"] = txt_special_conditions.text;
                            maprec["DOSE_ID"] = dozModel.get(listview.currentIndex)["ID"]
                            addworker.load_edit_data(maprec)
                            add_worker_popup.open()
                        }

                        onEntered: {
                            edit_brigade_button_img.sourceSize.height = 30
                            edit_brigade_button_img.sourceSize.width = 30
                        }
                        onExited: {
                            edit_brigade_button_img.sourceSize.height = 25
                            edit_brigade_button_img.sourceSize.width = 25
                        }

                        onPressed: { edit_brigade_button.border.color = "White" }
                        onReleased: { edit_brigade_button.border.color = "transparent" }
                    }
                }

            }

            Pane {
                Layout.fillWidth: true
                Layout.fillHeight: true
                padding: 0

                MyTableView {
                    id: workers_table
                    anchors.fill: parent

                    listview_model: managerDB.createModel("")
//                    SqlQueryModel {
//                        id: mod_workers_table
//                        query: ""
//                    }


                    onDblclickeditem: {
                        console.log("Dbl clicked: ", indx);
                        op_dose_popup.open()
                    }

                    function update_model(doz_id_value) {
                        listview_model.query = "SELECT t1.ID_PERSON, t1.ID_TLD, t1.PERSON_NUMBER,
                                                (t1.W_SURNAME || ' ' || SUBSTR(t1.W_NAME,1,1) || '.'|| SUBSTR(t1.W_PATRONYMIC,1,1) || '.') FIO
                                                FROM table_brigade_con t2
                                                LEFT JOIN EXT_PERSON t1 ON t2.id_worker = t1.ID_PERSON
                                                WHERE (t2.id_doznaryad = "+doz_id_value+")"
                    }

                    listview_header: ListModel {
                        ListElement { name: "№ ТЛД";            width_val: 70;  trole: "ID_TLD" }
                        ListElement { name: "Таб. №";           width_val: 90;  trole: "PERSON_NUMBER"}
                        ListElement { name: "ФИО";              width_val: 200; trole: "FIO"}
                        ListElement { name: "Зап. ИКУ";         width_val: 100; trole: ""}
                        ListElement { name: "Разр. доза";       width_val: 100; trole: ""}
                        ListElement { name: "D д.н.";           width_val: 70;  trole: ""}
                        ListElement { name: "Выв.";             width_val: 150; trole: ""}
                        ListElement { name: "D ППД";            width_val: 70;  trole: ""}
                        ListElement { name: "Дата записи ППД";  width_val: 150; trole: ""}
                        ListElement { name: "D сумм";           width_val: 70;  trole: ""}
                        ListElement { name: "Цех";              width_val: 100; trole: ""}
                        ListElement { name: "АУ";               width_val: 100; trole: ""}
                    }
                }
            }
        }
    }



    Frame {
        id: frame7
        anchors {
            leftMargin: space_margin
            rightMargin: space_margin
            topMargin: space_margin
            bottomMargin: space_margin/3
        }
        //anchors.margins: space_margin
        anchors.right: parent.right
        anchors.left: frame1.right
        //anchors.top: frame6.bottom
        anchors.bottom: frame8.top
        height: 30
        padding: 1
        topPadding: 1
        bottomPadding: 1

        background: Rectangle {
            anchors.fill: parent
            color: "White"
            border.color: "LightGray"
            radius: 2
        }
        Row {
            anchors.fill: parent
            Rectangle {
                height: parent.height
                width: 135
                color: Material.color(Material.Brown, Material.Shade50)//"LightGray"
                Label {
                    leftPadding: 8
                    text: "СИЗ"
                    font.pixelSize: 16
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Text {
                id: txt_siz_options
                leftPadding: 13
                font.pixelSize: 14
                //color: Material.color(Material.BlueGrey, Material.Shade800)
                color: "steelblue"
                //text: "-"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
//        RowLayout {
//            anchors.fill: parent
//            Rectangle {
//                //id: rectangle
//                height: parent.height
//                width: 135
//                color: Material.color(Material.Brown, Material.Shade50)//"LightGray"
//                Label {
//                    leftPadding: 8
//                    text: "СИЗ"
//                    font.pixelSize: 16
//                    anchors.verticalCenter: parent.verticalCenter
//                }
//            }

//            ListView {
//                id: siz_list
//                model: managerDB.createModel("")
//                //model: SqlQueryModel { id: siz_query_model }
//                clip: true
//                width: 200
//                height: parent.height
//                Layout.fillWidth: true
//                orientation: ListView.Horizontal

//                delegate: Component {
//                    Text {
//                        leftPadding: 8
//                        font.pixelSize: 14
//                        text: OPTION_NAME+";"
//                        font.bold: false

//                        anchors.verticalCenter: parent.verticalCenter
//                        color: "steelblue"//Material.color(Material.BlueGrey, Material.Shade800)
//                    }
//                }
//            }
//        }


    }

    Frame {
        id: frame8
        anchors {
            //anchors.margins: space_margin
            leftMargin: space_margin
            rightMargin: space_margin
            topMargin: space_margin/3
            bottomMargin: space_margin/3

            right: parent.right
            left: frame1.right
            //top: frame7.bottom
            bottom: frame9.top
        }

        height: 30
        padding: 1
        topPadding: 1
        bottomPadding: 1

        background: Rectangle {
            anchors.fill: parent
            color: "White"
            border.color: "LightGray"
            radius: 2
        }
        Row {
            anchors.fill: parent
            Rectangle {
                height: parent.height
                width: 135
                color: Material.color(Material.Brown, Material.Shade50)//"LightGray"
                Label {
                    leftPadding: 8
                    text: "Меры РБ"
                    font.pixelSize: 16
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Text {
                id: txt_rb_options
                leftPadding: 13
                font.pixelSize: 14
                //color: Material.color(Material.BlueGrey, Material.Shade800)
                color: "steelblue"
                //text: "-"
                anchors.verticalCenter: parent.verticalCenter
            }
        }

//        RowLayout {
//            anchors.fill: parent
//            Rectangle {
//                height: parent.height
//                width: 135
//                color: Material.color(Material.Brown, Material.Shade50)//"LightGray"
//                Label {
//                    leftPadding: 8
//                    text: "Меры РБ"
//                    font.pixelSize: 16
//                    anchors.verticalCenter: parent.verticalCenter
//                }
//            }

//            ListView {
//                id: rb_list
//                model: managerDB.createModel("")
//                //model: SqlQueryModel { id: rb_query_model }
//                clip: true
//                width: 200
//                height: parent.height
//                interactive: false
//                Layout.fillWidth: true
//                orientation: ListView.Horizontal

//                delegate: Component {
//                    Text {
//                        //id: txt_rb
//                        leftPadding: 8
//                        font.pixelSize: 14
//                        text: OPTION_NAME+";"
//                        font.bold: false

//                        anchors.verticalCenter: parent.verticalCenter
//                        color: "steelblue"//Material.color(Material.BlueGrey, Material.Shade800)
//                    }
//                }
//            }
//        }


    }

    Frame {
        id: frame9
        anchors.margins: space_margin
        anchors.right: parent.right
        anchors.left: frame1.right
        //anchors.top: frame8.bottom
        anchors.bottom: parent.bottom
/// Anton
        anchors.bottomMargin: 85
        /// Anton
        height: 30
        padding: 1
        topPadding: 1
        bottomPadding: 1

        background: Rectangle {
            anchors.fill: parent
            color: "White"
            border.color: "LightGray"
            radius: 2
        }

        Row {
            anchors.fill: parent
            Rectangle {
                height: parent.height
                width: 135
                color: Material.color(Material.Brown, Material.Shade50)//"LightGray"
                Label {
                    leftPadding: 8
                    text: "Особые условия"
                    font.pixelSize: 16
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Text {
                id: txt_special_conditions
                leftPadding: 13
                font.pixelSize: 14
                //color: Material.color(Material.BlueGrey, Material.Shade800)
                color: "steelblue"
                //text: "-"
                anchors.verticalCenter: parent.verticalCenter
            }
        }

    }
 /// Anton

    Rectangle {
        anchors.bottom: rect_mainStatusPanel.top
        anchors.margins: 10
        anchors.right: parent.right
        anchors.rightMargin: 15

        width: 930
        height: 1
        color: "LightGray"

    }
    /// индикаторы сосотояний подключения
    Popup {
        id: popup_wait_2
        modal: true
        closePolicy: Popup.NoAutoClose
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)

        width: 250
        height: 150


        Rectangle {
            anchors.fill: parent
            Column {
                anchors.centerIn: parent
                spacing: 10
                Text {
                    id: popup_txt
                    font.pixelSize: 15
                    color: "#17a81a"
                    //text: qsTr("text")
                }
                Button {
                    id: cansel_popup_button
                    text: "Закрыть"
                    anchors.horizontalCenter: parent.horizontalCenter
                    contentItem: Text {
                        text: cansel_popup_button.text
                        font: cansel_popup_button.font
                        opacity: enabled ? 1.0 : 0.3
                        color: cansel_popup_button.down ? "#17a81a" : "#21be2b"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 40
                        opacity: enabled ? 1 : 0.3
                        border.color: cansel_popup_button.down ? "#17a81a" : "#21be2b"
                        border.width: 1
                        radius: 2
                    }
                    onClicked: {
                        popup_wait_2.close();
                    }
                }
            }
        }


    }
    Item {
        id: rect_mainStatusPanel
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: 580
        height: 40
        anchors.margins: 15
        //border.color: "LightGray"

        Connections {
                target: managerDB
                property int iBegin: 0

                onSignalSendGUI_status: {
                    console.log(" ******************** ",message, " status = ",status)
                    //txt_statusConnection.text = message;
                    if(message=="begin"){
                        txt_statusConnection.append("<p style='color:#9cc17f'>" + message + ": " + iBegin + "</p>") //txt_statusConnection.text = message;
                        indicatorConnect_0.lightOff();
                        indicatorConnect_1.lightOff();
                        //indicatorConnect_local.lightOff();
                        iBegin++;
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
                    else if(!status) {
                        //indicatorConnect_local.lightOff();
                        if(currentConnectionName=="machine 0") {
                            indicatorConnect_0.lightFalse();
                        }
                        if(currentConnectionName=="machine 1") {
                            indicatorConnect_1.lightFalse();
                        }
                    }


                    if(currentConnectionName) {
                        popup_wait_2.close()
                    }

                }

         }

        //пенель с кнопками смены коннекта
        Item {
            id: rect_changeConnect
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            width: 81
            //property int currentMachine: 0

//            Rectangle {
//                id: machine0
//                anchors.left: parent.left
//                anchors.bottom: parent.bottom
//                anchors.top: parent.top
//                width: 40
//                border.color: "LightGray"
//                Text {
//                    anchors.centerIn: parent
//                    text: qsTr("0")
//                    font.pixelSize: 15
//                    color: "#494848"
//                }
//                MouseArea {
//                    anchors.fill: parent
//                    hoverEnabled: true
//                    onClicked: {
//                        //rect_changeConnect.currentMachine = 0
//                        indicatorConnect_0.lightOff();
//                        indicatorConnect_1.lightOff();
//                        popup_txt.text = qsTr("Подлючение к machine 0");
//                        txt_statusConnection.append("<p style='color:#9cc17f'> Переключение БД </p>")
//                        popup_wait_2.open();

//                        managerDB.connectionDB(0);
//                    }
//                    onEntered: {
//                        parent.color = "#dbdbdb" // "LightGray"
//                    }
//                    onExited:  {
//                        parent.color = "Transparent"
//                    }
//                }
//            }

//            Rectangle {
//                id: machine1
//                anchors.right: parent.right
//                anchors.bottom: parent.bottom
//                anchors.top: parent.top
//                width: 40
//                border.color: "LightGray"
//                Text {
//                    anchors.centerIn: parent
//                    text: qsTr("1")
//                    font.pixelSize: 15
//                    color: "#494848"
//                }
//                MouseArea {
//                    anchors.fill: parent
//                    hoverEnabled: true
//                    onClicked: {
//                        //rect_changeConnect.currentMachine = 1
//                        indicatorConnect_0.lightOff();
//                        indicatorConnect_1.lightOff();
//                        popup_txt.text = qsTr("Подлючение к machine 1");
//                        popup_wait_2.open();
//                        txt_statusConnection.append("<p style='color:#9cc17f'> Переключение БД </p>")
//                        managerDB.connectionDB(1);
//                    }
//                    onEntered: {
//                        parent.color = "#dbdbdb" //"LightGray"
//                    }
//                    onExited:  {
//                        parent.color = "Transparent"
//                    }
//                }
//            }

//            Row {
//                anchors.centerIn: parent
//                //Tumbler { model: 5 }
//                //Switch {}
//                //RadioButton {}
//            }
        }

        //разоврачивающаяся информационная панель
        Rectangle {
            id: rect_statusConnection_info
            property bool isButton_clear: false
            anchors.left: rect_changeConnect.right
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
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
                    wrapMode: TextArea.Wrap
                    color: Material.color(Material.Grey)
                    font.family: "Calibri"
                }

                ScrollBar.vertical: ScrollBar { }
            }
            MouseArea {
                anchors.fill:parent
                hoverEnabled: true

                //onClicked: {rect_statusConnection_info.height = 400}
                onEntered: {
                    rect_statusConnection_info.height = 400
                    flickable_txt_STATUSCONNECT.anchors.margins = 20
                    txt_statusConnection.font.pointSize = 9
                    txt_button_clear.opacity = 0.2
                }
                onExited:  {
                    rect_statusConnection_info.height = 40
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
                        rect_statusConnection_info.isButton_clear = true
                    }
                    else {
                        button_clear.border.color = "transparent"
                        txt_button_clear.opacity = 0.2
                        rect_statusConnection_info.isButton_clear = false
                    }
                }
                onClicked: {
                    if(rect_statusConnection_info.isButton_clear) {txt_statusConnection.clear()}
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


        // индикторы
        Rectangle {
            id: rect_statusConnection_indicator
            border.color: "LightGray"
            anchors.bottom: parent.bottom
            anchors.left: rect_statusConnection_info.right
            anchors.leftMargin: 10
            width: 170
            height: 40


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





    /// Anton
}
