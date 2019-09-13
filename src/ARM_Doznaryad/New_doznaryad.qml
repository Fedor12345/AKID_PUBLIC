import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    id: item1
    height: 700
    width:  800

    signal edit_cancel
    signal edit_confirm(var data_record)

    signal wizard_next(var data_record)
    signal wizard_cancel()

    state: "edit" //два состояния: edit, wizard

    states: [
        State {
            name: "edit"
            PropertyChanges {
                target: ok_button
                text: "Сохранить"
                enabled: true
            }
            PropertyChanges {
                target: cancel_button
                text: "Отмена"
            }
            PropertyChanges {
                target: header_caption
                text: "Наряд-допуск"
            }
            PropertyChanges {
                target: id_number
                enabled: false
            }
            PropertyChanges {
                target: id_number_header
                color: "black"
            }
        },
        State {
            name: "wizard"
            PropertyChanges {
                target: ok_button
                text: "Далее"
                enabled: false
            }
            PropertyChanges {
                target: cancel_button
                text: "Отмена"
            }
            PropertyChanges {
                target: header_caption
                text: "Новый наряд-допуск"
            }
            PropertyChanges {
                target: id_number
                enabled: true
            }
            PropertyChanges {
                target: id_number_header
                color: "indianred"
            }
        }
    ]

    function isValidDate(d) {
        return d instanceof Date && !isNaN(d)
    }

    function load_edit_data(doz_dataset) {
        id_number.text = doz_dataset["DOZ_NUMBER"]
        id_directive.checkState = doz_dataset["DOZ_DIRECTIVE"] ? Qt.Checked : Qt.Unchecked

        id_permitted_dose.text=doz_dataset["PERMITTED_DOSE"].toFixed(3)
        id_sum_dose.text = doz_dataset["SUM_DOSE"].toFixed(3)
        id_over_dose.text = doz_dataset["OVER_DOSE"].toFixed(3)
        id_collective_dose.text = doz_dataset["COLLECTIVE_DOSE"].toFixed(3)

        id_pt_H.text = formatText(parseInt(doz_dataset["PERMITTED_TIME"] / 60).toString())
        id_pt_m.text = formatText((doz_dataset["PERMITTED_TIME"] - parseInt(doz_dataset["PERMITTED_TIME"] / 60) * 60).toString())

        if (isValidDate(doz_dataset["START_OF_WORK"])) {
            id_sof_H.text = Qt.formatDateTime(doz_dataset["START_OF_WORK"], "hh")
            id_sof_m.text = Qt.formatDateTime(doz_dataset["START_OF_WORK"], "mm")
            id_sof_date.date_val = doz_dataset["START_OF_WORK"]//.toLocaleDateString(Qt.locale("ru_RU"), "dd.MM.yyyy")
            id_sof_date.ready = true
        }

        if (isValidDate(doz_dataset["END_OF_WORK"])) {
            id_eof_H.text = Qt.formatDateTime(doz_dataset["END_OF_WORK"], "hh")
            id_eof_m.text = Qt.formatDateTime(doz_dataset["END_OF_WORK"], "mm")
            id_eof_date.date_val = doz_dataset["END_OF_WORK"]
            id_eof_date.ready = true
        }

        if (isValidDate(doz_dataset["DOZ_GET_DATE"])) {
            id_get_date.date_val = doz_dataset["DOZ_GET_DATE"]
            id_get_date.ready = true
        }

        if (isValidDate(doz_dataset["OPEN_DATE"])) {
            id_open_date.date_val = doz_dataset["OPEN_DATE"]
            id_open_date.ready = true
        }

        if (isValidDate(doz_dataset["CLOSE_DATE"])) {
            id_close_date.date_val = doz_dataset["CLOSE_DATE"]
            id_close_date.ready = true
        }

        var i;
        for (i=0; i < id_status.model.rowCount(); i++) {
            if (id_status.model.get(i)["ID"] === doz_dataset["DOZ_STATUS"]) {
                id_status.currentIndex = i
                break;
            }
        }

        for (i=0; i < id_department.model.rowCount(); i++) {
            if (id_department.model.get(i)["ID"] === doz_dataset["ID_DEPARTMENT"]) {
                id_department.currentIndex = i
                break;
            }
        }

        id_responsible.setIdRec(parseInt(doz_dataset["ID_RESPONSIBLE"]) ? doz_dataset["ID_RESPONSIBLE"] : -1, doz_dataset["RESPONSIBLE"])
        id_open_worker.setIdRec(parseInt(doz_dataset["ID_OPEN_WORKER"]) ? doz_dataset["ID_OPEN_WORKER"] : -1, doz_dataset["OPEN_WORKER"])
        id_close_worker.setIdRec(parseInt(doz_dataset["ID_CLOSE_WORKER"]) ? doz_dataset["ID_CLOSE_WORKER"] : -1, doz_dataset["CLOSE_WORKER"])
        id_leader.setIdRec(parseInt(doz_dataset["ID_LEADER"]) ? doz_dataset["ID_LEADER"] : -1, doz_dataset["LEADER"])
        id_producer.setIdRec(parseInt(doz_dataset["ID_PRODUCER"]) ? doz_dataset["ID_PRODUCER"] : -1, doz_dataset["PRODUCER"])
        id_agreed.setIdRec(parseInt(doz_dataset["ID_AGREED"]) ? doz_dataset["ID_AGREED"] : -1, doz_dataset["AGREED"])
    }

    function clearfields() {
        id_status.currentIndex = 0
        id_number.text = ""
        id_department.currentIndex=-1
        id_permitted_dose.text="0,0"
        id_directive.checkState = Qt.Unchecked

        id_pt_H.text = "00"
        id_pt_m.text = "01"
        id_sum_dose.text = "0,0"
        id_over_dose.text = "0,0"
        id_collective_dose.text = "0,0"

        id_responsible.id_rec = -1
        id_responsible.findtext = ""
        id_open_worker.id_rec = -1
        id_open_worker.findtext = ""
        id_close_worker.id_rec = -1
        id_close_worker.findtext = ""

        id_get_date.ready = false
        id_open_date.ready = false
        id_close_date.ready = false

        id_sof_H.text = "08"
        id_sof_m.text = "00"
        id_sof_date.ready = false
        id_eof_H.text = "17"
        id_eof_m.text = "00"
        id_eof_date.ready = false

        id_leader.id_rec = -1
        id_leader.findtext = ""
        id_producer.id_rec = -1
        id_producer.findtext = ""
        id_agreed.id_rec = -1
        id_agreed.findtext = ""
    }

    function formatText(str_source) {
        var str_tmp = str_source
        if (str_tmp.toString().length === 0 ) str_tmp = "00"
        if (str_tmp.toString().length < 2 ) str_tmp = "0"+str_tmp
        return str_tmp
    }

    Rectangle {
        id: header_rectangle
        color: "indianred"
        width: item1.width
        height: 40
        Label {
            id: header_caption
            //text: id_directive.checked ? "Новое распоряжение" : "Новый наряд-допуск"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            font.pixelSize: 16
            color: "White"
            font.bold: true
        }
    }

    Frame {
        id: first_step_frame
        leftPadding: 20
        rightPadding: 20
        topPadding: 12
        bottomPadding: 12

        anchors.margins: 10

        anchors.top: header_rectangle.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        background: Rectangle {
            anchors.fill: parent
            border.color: "lightgrey"//Material.color(Material.Grey, Material.Shade300)//"lavender"
            color: "white"//Material.color(Material.Blue, Material.Shade50)//"whitesmoke"
            radius: 2
        }

        RowLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.topMargin: 10
            spacing: 35
            Column {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Text {
                    text: "Статус"
                    font.pixelSize: 14
                }

                ComboBox {
                    id: id_status
                    width: 220
                    flat: false
                    font.pixelSize: 14
                    textRole: "STATE_NAME"
                    model: managerDB.createModel("SELECT ID, STATE_NAME, STATE_COLOR FROM TABLE_STATES ORDER BY ID")
                    currentIndex: 0
                }
            }

            Column {
                id: column
                //Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                spacing: 5
                Text {
                    id: id_number_header
                    text: "Номер"
                    font.pixelSize: 14
                    color: "indianred"
                }
                Column {
                    spacing: 0

                TextField {
                    id: id_number
                    width: 135
                    //height: 48
                    bottomPadding: 14
                    topPadding: 8
                    leftPadding: 8
                    selectByMouse: true
                    font.pixelSize: 16

                    onTextChanged: {
                        if (id_number.enabled)
                            mytimer.restart()
                    }
                }
                CheckBox {
                    id: id_directive
                    text: "Распоряжение"
                    font.pixelSize: 14
                    padding: 0
                }
            }
                //событие по таймеру срабатывает, когда пауза на нажатие кнопки больше 500мс
                //при условии, что в строке поиска есть что-то
                Timer {
                    id: mytimer
                    interval: 500
                    repeat: false
                    onTriggered: {
                        if (id_number.text.length > 0) {
                            var res = justquery.find_record("New_doznaryad",
                                                            "SELECT ID FROM TABLE_DOZNARYAD WHERE (LOWER(DOZ_NUMBER) LIKE '" +
                                                            id_number.text.toLowerCase() + "')"
                                                            )
                            if(Object.keys(res).length > 0) {
                                id_number_header.color = "indianred"
                                ok_button.enabled = false
                            } else {
                                id_number_header.color = "black"
                                ok_button.enabled = true
                            }
                        } else {
                            id_number_header.color = "indianred"
                            ok_button.enabled = false
                        }
                    }
                }

            }

            Column {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Text {
                    text: "Цех"
                    font.pixelSize: 14
                }

                ComboBox {
                    id: id_department
                    width: 135
                    font.pixelSize: 16
                    textRole: "DEPARTMENT"
                    model: managerDB.createModel("SELECT ID, DEPARTMENT FROM TABLE_DEPARTMENTS ORDER BY DEPARTMENT")
                }
            }

            Column {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                spacing: 5
                Text {
                    text: "Разрешенная доза"
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 14
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    TextField {
                        id: id_permitted_dose
                        width: 60
                        //height: 48
                        horizontalAlignment: Text.AlignHCenter
                        text: "0,0"
                        font.pixelSize: 16
                        selectByMouse: true
                        validator: DoubleValidator {
                            notation: DoubleValidator.StandardNotation
                        }
                    }
                    Text {
                        text: "мЗв"
                        font.pixelSize: 16
                        bottomPadding: 6
                        anchors.bottom: parent.bottom
                    }
                }
            }
        }
    }

    Frame {
        id: second_step_frame
        //width: parent.width
        //Layout.fillWidth: true
        leftPadding: 20
        rightPadding: 20
        topPadding: 12
        bottomPadding: 12
        anchors.margins: 10

        anchors.top: first_step_frame.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        background: Rectangle {
            anchors.fill: parent
            border.color: "lightgrey"//Material.color(Material.Grey, Material.Shade300)//"lavender"
            color: "white"//Material.color(Material.Blue, Material.Shade50)//"whitesmoke"
            radius: 2
        }
        RowLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.topMargin: 10
            spacing: 35

            Column {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Text {
                    text: "Разрешенное время"
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 14
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    TextField {
                        id: id_pt_H
                        width: 40
                        //height: 48
                        horizontalAlignment: Text.AlignHCenter
                        text: "00"
                        font.pixelSize: 16
                        selectByMouse: true
                        validator: IntValidator {
                            bottom: 0
                            top: 1000
                        }
                    }
                    Text {
                        text: "ч"
                        anchors.bottom: parent.bottom
                        font.pixelSize: 16
                        bottomPadding: 6
                    }
                    TextField {
                        id: id_pt_m
                        width: 40
                        //height: 48
                        horizontalAlignment: Text.AlignHCenter
                        text: "01"
                        font.pixelSize: 16
                        selectByMouse: true
                        validator: IntValidator {
                            bottom: 0
                            top: 59
                        }
                    }
                    Text {
                        text: "мин"
                        anchors.bottom: parent.bottom
                        font.pixelSize: 16
                        bottomPadding: 6
                    }
                }
            }

            Column {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Text {
                    text: "Суммарная доза"
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 14
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    TextField {
                        id: id_sum_dose
                        width: 60
                        //height: 48
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 16

                        text: "0,0"
                        selectByMouse: true
                        validator: DoubleValidator {
                            notation: DoubleValidator.StandardNotation
                        }
                    }
                    Text {
                        text: "мЗв"
                        font.pixelSize: 16
                        bottomPadding: 6
                        anchors.bottom: parent.bottom
                    }
                }
            }

            Column {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Text {
                    text: "Превышение дозы"
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 14
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    TextField {
                        id: id_over_dose
                        width: 60
                        //height: 48
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 16

                        text: "0,0"
                        selectByMouse: true
                        validator: DoubleValidator {
                            notation: DoubleValidator.StandardNotation
                        }
                    }
                    Text {
                        text: "мЗв"
                        font.pixelSize: 16
                        bottomPadding: 6
                        anchors.bottom: parent.bottom
                    }
                }
            }

            Column {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Text {
                    text: "Коллективная доза"
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 14
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    TextField {
                        id: id_collective_dose
                        width: 60
                        //height: 48
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 16

                        text: "0,0"
                        selectByMouse: true
                        validator: DoubleValidator {
                            notation: DoubleValidator.StandardNotation
                        }
                    }
                    Text {
                        text: "мЗв"
                        font.pixelSize: 16
                        bottomPadding: 6
                        anchors.bottom: parent.bottom
                    }
                }
            }
        }
    }

    Frame {
        id: third_step_frame
        leftPadding: 20
        rightPadding: 20
        bottomPadding: 12
        anchors.margins: 10

        anchors.top: second_step_frame.bottom
        anchors.left: parent.left
        background: Rectangle {
            anchors.fill: parent
            border.color: "lightgrey"//Material.color(Material.Grey, Material.Shade300)//"lavender"
            color: "white"//Material.color(Material.Blue, Material.Shade50)//"whitesmoke"
            radius: 2
        }
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            Row {
                spacing: 35
                Column {

                    Text {
                        text: "Выдал"
                        font.pixelSize: 14
                    }
                    MyFindField {
                        id: id_responsible
                        flg_f: true
                        height: 48
                        width: 220
                        //add_filter: "FLG_GET = 1"
                    }
                }
                Column {
                    Text {
                        text: "Дата выдачи"
                        font.pixelSize: 14
                    }
                    MyCalendar {
                        id: id_get_date
                        date_val: new Date()
                        //cb_title: "Дата выдачи"
                        enabled: true
                    }
                }
            }

            Row {
                spacing: 35
                Column {
                    Text {
                        text: "Открыл"
                        font.pixelSize: 14
                    }
                    MyFindField {
                        id: id_open_worker
                        //tf_title: "Открыл"
                        phtext: ""
                        flg_f: true
                        height: 48
                        width: 220
                        //add_filter: "FLG_OPEN = 1"
                    }
                }
                Column {

                    Text {
                        text: "Дата открытия"
                        font.pixelSize: 14
                    }
                    MyCalendar {
                        id: id_open_date
                        date_val: new Date()
                        //cb_title: "Дата выдачи"
                    }
                }
            }

            Row {
                spacing: 35
                Column {
                    Text {
                        text: "Закрыл"
                        font.pixelSize: 14
                    }
                    MyFindField {
                        id: id_close_worker
                        phtext: ""
                        flg_f: true
                        height: 48
                        width: 220
                        //add_filter: "FLG_CLOSE = 1"
                    }
                }
                Column {
                    Text {
                        text: "Дата закрытия"
                        font.pixelSize: 14
                    }
                    MyCalendar {
                        id: id_close_date
                        date_val: new Date()
                        //cb_title: "Дата выдачи"
                    }
                }
            }

        }

    }

    Frame {
        id: fouth_step_frame
        leftPadding: 20
        rightPadding: 20
        bottomPadding: 12
        anchors.margins: 10

        anchors.top: second_step_frame.bottom
        anchors.left: third_step_frame.right
        anchors.bottom: fifth_step_frame.top
        anchors.right: parent.right
        background: Rectangle {
            anchors.fill: parent
            border.color: "lightgrey"//Material.color(Material.Grey, Material.Shade300)//"lavender"
            color: "white"//Material.color(Material.Blue, Material.Shade50)//"whitesmoke"
            radius: 2
        }
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 1

            RowLayout {
                Layout.alignment: Qt.AlignBottom
                Layout.fillWidth: true
                spacing: 35

                Column {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Text {
                        text: "Начало работ"
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 14
                    }

                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 10
                        TextField {
                            id: id_sof_H
                            width: 40
                            height: 48
                            bottomPadding: 14
                            topPadding: 8
                            //leftPadding: 8
                            horizontalAlignment: Text.AlignHCenter
                            text: "08"
                            font.pixelSize: 16
                            selectByMouse: true

                            validator: IntValidator {
                                bottom: 0
                                top: 1000
                            }
                        }
                        Text {
                            text: "ч"
                            anchors.bottom: parent.bottom
                            font.pixelSize: 16
                            bottomPadding: 6
                        }
                        TextField {
                            id: id_sof_m
                            width: 40
                            height: 48
                            bottomPadding: 14
                            topPadding: 8
                            //leftPadding: 8
                            horizontalAlignment: Text.AlignHCenter
                            text: "00"
                            font.pixelSize: 16
                            selectByMouse: true
                            validator: IntValidator {
                                bottom: 0
                                top: 59
                            }
                        }
                        Text {
                            text: "мин"
                            anchors.bottom: parent.bottom
                            font.pixelSize: 16
                            bottomPadding: 6
                            rightPadding: 10
                        }
                        MyCalendar {
                            id: id_sof_date
                            date_val: new Date()
                            enabled: true
                        }
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignBottom
                Layout.fillWidth: true
                //Layout.leftMargin: 10
                Layout.topMargin: 10
                spacing: 35

                Column {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Text {
                        text: "Окончание работ"
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 14
                    }

                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 10
                        TextField {
                            id: id_eof_H
                            width: 40
                            height: 48
                            bottomPadding: 14
                            topPadding: 8
                            //leftPadding: 8
                            horizontalAlignment: Text.AlignHCenter
                            text: "17"
                            font.pixelSize: 16
                            selectByMouse: true
                            validator: IntValidator {
                                bottom: 0
                                top: 1000
                            }
                        }
                        Text {
                            text: "ч"
                            anchors.bottom: parent.bottom
                            font.pixelSize: 16
                            bottomPadding: 6
                        }
                        TextField {
                            id: id_eof_m
                            width: 40
                            height: 48
                            bottomPadding: 14
                            topPadding: 8
                            //leftPadding: 8
                            horizontalAlignment: Text.AlignHCenter
                            text: "00"
                            font.pixelSize: 16
                            selectByMouse: true
                            validator: IntValidator {
                                bottom: 0
                                top: 59
                            }
                        }
                        Text {
                            text: "мин"
                            anchors.bottom: parent.bottom
                            font.pixelSize: 16
                            bottomPadding: 6
                            rightPadding: 10
                        }
                        MyCalendar {
                            id: id_eof_date
                            date_val: new Date()
                            //cb_title: "Дата выдачи"
                            enabled: true
                        }
                    }
                }
            }

        }
    }

    Frame {
        id: fifth_step_frame
        padding: 20
        anchors.margins: 10

        anchors.top: third_step_frame.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        background: Rectangle {
            anchors.fill: parent
            border.color: "lightgrey"//Material.color(Material.Grey, Material.Shade300)//"lavender"
            color: "white"//Material.color(Material.Blue, Material.Shade50)//"whitesmoke"
            radius: 2
        }
        RowLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.topMargin: 10
            Layout.bottomMargin: 10

            spacing: 35
            Column {
                spacing: 5
                Text {
                    text: "Руководитель"
                    font.pixelSize: 14
                }
                MyFindField {
                    id: id_leader
                    phtext: ""
                    flg_f: true
                    width: 220
                    height: 48
                    //add_filter: "FLG_LEADER = 1"
                }
            }
            Column {
                spacing: 5
                Text {
                    text: "Производитель"
                    font.pixelSize: 14
                }
                MyFindField {
                    id: id_producer
                    //tf_title: "Производитель"
                    phtext: ""
                    flg_f: true
                    width: 220
                    height: 48
                    //add_filter: "FLG_PRODUCER = 1"
                }
            }
            Column {
                spacing: 5
                Text {
                    text: "Согласовано"
                    font.pixelSize: 14
                }
                MyFindField {
                    id: id_agreed
                    //tf_title: "Согласовано"
                    phtext: ""
                    flg_f: true
                    width: 220
                    height: 48
                    //add_filter: "FLG_"
                } }
        }

    }

    Button {
        id: ok_button
        width: 120
        anchors.bottomMargin: 10
        anchors.rightMargin: 20
        text: "Сохранить"
        font.pixelSize: 14
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        enabled: false
        onClicked: {
            var maprec = {}

            maprec["DOZ_STATUS"] = id_status.model.get(id_status.currentIndex)["ID"]             //состояние
            maprec["DOZ_NUMBER"] = id_number.text                                                //номер
            maprec["ID_DEPARTMENT"] = id_department.model.get(id_department.currentIndex)["ID"]  //цех
            maprec["DOZ_DIRECTIVE"] = id_directive.checked ? 1:0                                 //наряд-допуск / распоряжение
            maprec["PERMITTED_DOSE"] = parseFloat(id_permitted_dose.text.replace(",", "."))      //разрешенная доза
            maprec["PERMITTED_TIME"] = parseInt(id_pt_H.text)*60 + parseInt(id_pt_m.text)        //разрешенное время в минутах

            maprec["SUM_DOSE"] = (id_sum_dose.text.length > 0) ? parseFloat(id_sum_dose.text.replace(",",".")) : 0.0                      //суммарная доза
            maprec["OVER_DOSE"] = (id_over_dose.text.length > 0) ? parseFloat(id_over_dose.text.replace(",",".")) : 0.0                   //превышение дозы
            maprec["COLLECTIVE_DOSE"] = (id_collective_dose.text.length > 0) ? parseFloat(id_collective_dose.text.replace(",",".")) : 0.0 //коллективная доза

            maprec["ID_RESPONSIBLE"] = (id_responsible.id_rec !== -1) ? id_responsible.id_rec : null     //ответсвенный
            maprec["ID_OPEN_WORKER"] = (id_open_worker.id_rec !== -1) ? id_open_worker.id_rec : null     //открыл
            maprec["ID_CLOSE_WORKER"] = (id_close_worker.id_rec !== -1) ? id_close_worker.id_rec : null  //закрыл
            maprec["ID_LEADER"] = (id_leader.id_rec !== -1) ? id_leader.id_rec : null                    //руководитель
            maprec["ID_PRODUCER"] = (id_producer.id_rec !== -1) ? id_producer.id_rec : null              //производитель
            maprec["ID_AGREED"] = (id_agreed.id_rec !== -1) ? id_agreed.id_rec : null                    //согласовал

            maprec["DOZ_GET_DATE"] = id_get_date.ready ? id_get_date.date_val : null          //дата выдачи
            maprec["OPEN_DATE"] = id_open_date.ready ? id_open_date.date_val : null           //дата открытия
            maprec["CLOSE_DATE"] = id_close_date.ready ? id_close_date.date_val : null        //дата закрытия

            if (id_sof_date.ready === true) {
                var str1 = formatText(id_sof_H.text) + ":" + formatText(id_sof_m.text) + " " + id_sof_date.date_val.toLocaleDateString(Qt.locale("ru_RU"), "dd.MM.yyyy")
                maprec["START_OF_WORK"] =  Date.fromLocaleString(Qt.locale("ru_RU"), str1, "HH:mm dd.MM.yyyy")  //начало работ
            }

            if (id_eof_date.ready === true) {
                var str2 = formatText(id_eof_H.text) + ":" + formatText(id_eof_m.text) + " " + id_eof_date.date_val.toLocaleDateString(Qt.locale("ru_RU"), "dd.MM.yyyy")
                maprec["END_OF_WORK"] =  Date.fromLocaleString(Qt.locale("ru_RU"), str2, "HH:mm dd.MM.yyyy")    //окончание работ
            }

            switch (item1.state) {
            case "edit":
                item1.edit_confirm(maprec)
                item1.clearfields()
                break

            case "wizard":
                item1.wizard_next(maprec)
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
            switch (item1.state) {
            case "edit":
                item1.edit_cancel()
                break

            case "wizard":
                item1.wizard_cancel()
                break
            }
            item1.clearfields()
        }
    }
}
