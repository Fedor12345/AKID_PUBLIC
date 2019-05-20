import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

//import Foo 1.0

Item {
    id: item3
    height: 700//550
    width:  800

    signal edit_cancel
    signal edit_confirm(var data_record)

    signal wizard_next(var data_record)
    signal wizard_back()

    property ListModel workers_list_model: ListModel {}
    property ListModel siz_list_model: ListModel {}
    property ListModel rb_list_model: ListModel {}

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
                text: "Бригада"
            }
        },
        State {
            name: "wizard"
            PropertyChanges {
                target: ok_button
                text: "Сохранить"
            }
            PropertyChanges {
                target: cancel_button
                text: "Назад"
            }
            PropertyChanges {
                target: header_caption
                text: "Новый наряд-допуск: Бригада"
            }
        }
    ]

    function load_edit_data(doz_dataset) {
        var i;
        for (i=0; i < doz_dataset["WORKERS"].rowCount(); i++) {
            workers_list_model.append({"ID_PERSON" : doz_dataset["WORKERS"].get(i)["ID_PERSON"],
                                          "ID_TLD": doz_dataset["WORKERS"].get(i)["ID_TLD"],
                                          "FIO": doz_dataset["WORKERS"].get(i)["FIO"]})
        }
        special_cond.text = doz_dataset["SPECIAL_COMMENT"]

        var zr = justquery2.find_records("SELECT y1.OPTION_NAME, y1.ID, y1.ID_TYPE
                                  FROM table_specials y1 INNER JOIN table_doznaryad_specials_con y2 ON y1.ID = y2.id_specials
                                  WHERE (y2.id_doznaryad = "+doz_dataset["DOSE_ID"]+")")


        if (Object.keys(zr).length > 0) {
            var len = Object.keys(zr).length
            for (i = 0; i < len; i++) {
                if ( zr[i]["ID_TYPE"] === 1) {
                    siz_list_model.append({"ID": zr[i]["ID"], "OPTION_NAME": zr[i]["OPTION_NAME"]})
                } else {
                    rb_list_model.append({"ID" : zr[i]["ID"], "OPTION_NAME": zr[i]["OPTION_NAME"]})
                }

            }
        }

    }

    function clearfields() {
        workers_list_model.clear()
        siz_list_model.clear()
        rb_list_model.clear()

        cb_siz.currentIndex = -1
        cb_mery_rb.currentIndex = -1

        //block_name.text = ""
        id_find_worker.findtext = ""
        id_find_worker.id_rec = -1

        worker_info_fio.text1_value = ""
        worker_info_department.text1_value = ""
        worker_info_tld.text1_value = ""
        worker_info_personnumber.text1_value = ""

        special_cond.text = ""
    }

    ListModel {
        id: tmp_list
    }
    Connections {
        target: justquery
        //(const QString& owner_name, const bool& res)
        //результат = var_res
        onSignalSendResult: {
            if (owner_name === "Add_worker") {
                if (res === true) {
                    if(Object.keys(var_res).length > 0) {
                        worker_info_tld.text1_value = var_res["ID_TLD"]
                        worker_info_fio.text1_value = var_res["FIO"]
                        worker_info_personnumber.text1_value = var_res["PERSON_NUMBER"]

                        tmp_list.clear()
                        tmp_list.append(var_res)
                    }
                }
            }
        }
    }

    Rectangle {
        id: header_rectangle
        color: "indianred"
        width: item3.width
        height: 40
        Label {
            id: header_caption
            text: "Бригада"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            font.pixelSize: 16
            color: "White"
            font.bold: true
        }
    }

    Pane {
        id: pane0
        width: 327

        leftPadding: 1
        rightPadding: 1
        topPadding: 1
        bottomPadding: 1

        anchors.margins: 10
        anchors.top: header_rectangle.bottom
        anchors.left: parent.left

        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }

        Column {
            anchors.fill: parent
            spacing: 10

            Row {
                anchors.rightMargin: 10
                leftPadding: 10
                spacing: 10
                height: 60

                Column {
                    spacing: 5
                    Text {
                        text: "Поиск сотрудника"
                        font.pixelSize: 14
                    }

                    MyFindField {
                        id: id_find_worker
                        width: 240
                        phtext: ""
                        flg_f: true

                        onId_recChanged: {
                            if (id_rec !== -1) {
                                justquery.find_record("Add_worker", "SELECT (W_SURNAME || ' ' || SUBSTR(W_NAME,1,1) || '. ' || SUBSTR(W_PATRONYMIC,1,1) || '.') FIO,
                                                       ID_TLD, ID_PERSON, PERSON_NUMBER
                                                       FROM EXT_PERSON
                                                       WHERE (ID_PERSON = " + id_rec.toString() + ")", true)
                            } else {
                                worker_info_tld.text1_value = "-"
                                worker_info_fio.text1_value = "-"
                                worker_info_personnumber.text1_value = "-"
                            }
                        }
                    }
                }
                Rectangle {
                    //id: rectangle
                    width: 28
                    height: 28
                    radius: 14
                    anchors.bottomMargin: 7
                    anchors.bottom: parent.bottom
                    color: Material.color(Material.Grey, Material.Shade700)
                    border.color: Material.color(Material.Grey, Material.Shade800)//"Black"
                    border.width: 1

                    opacity: (id_find_worker.id_rec !== -1) ? 0.7 : 0.2
                    enabled: (id_find_worker.id_rec !== -1) ? true : false

                    Image {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        source: "icons/plus.svg"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            var res_compare = false
                            for(var i = workers_list_model.rowCount()-1; i >= 0; --i) {
                                if (workers_list_model.get(i)["ID_PERSON"] === id_find_worker.id_rec) {
                                    res_compare = true
                                    break
                                }
                            }

                            if (!res_compare) {
                                workers_list_model.append({"ID_PERSON" : tmp_list.get(0)["ID_PERSON"],
                                                           "ID_TLD": tmp_list.get(0)["ID_TLD"],
                                                           "PERSON_NUMBER": tmp_list.get(0)["PERSON_NUMBER"],
                                                           "FIO": tmp_list.get(0)["FIO"]})
                                id_find_worker.findtext = ""
                                id_find_worker.id_rec = -1
                            }
                        }
                    }
                }
            }

            Frame {
                width: parent.width
                leftPadding: 1
                rightPadding: 1
                topPadding: 1
                bottomPadding: 1

                background: Rectangle {
                    anchors.fill: parent
                    border.color: "lightgrey"//Material.color(Material.Grey, Material.Shade300)//"lavender"
                    color: "white"//Material.color(Material.Blue, Material.Shade50)//"whitesmoke"
                    radius: 2
                }

                Column {
                    anchors.fill: parent
                    spacing: 0
                    Rectangle {
                        height: 30
                        width: parent.width
                        color: Material.color(Material.Grey, Material.Shade700)

                        Label {
                            leftPadding: 8
                            text: "Состав бригады"
                            color: "White"
                            font.pixelSize: 16
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Rectangle {
                            id: delete_worker_button
                            height: 27
                            width: 27
                            color: "transparent"
                            radius: 2
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: 3

                            Image {
                                id: img_del_worker
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
                                    if (workers_list_model.rowCount() > 0)
                                        workers_list_model.remove(workers_table.currentIndex)
                                }

                                onEntered: {
                                    img_del_worker.sourceSize.height = 30
                                    img_del_worker.sourceSize.width = 30
                                }
                                onExited: {
                                    img_del_worker.sourceSize.height = 25
                                    img_del_worker.sourceSize.width = 25
                                }

                                onPressed: { parent.border.color = "white" }
                                onReleased: { parent.border.color = "transparent" }
                            }
                        }

                    }

                    Rectangle {
                        height: 180
                        width: parent.width
                        border.color: "lavender"
                        color: "whitesmoke"
                        anchors.margins: 0

                        MyTableView {
                            id: workers_table
                            anchors.fill: parent
                            horizontal_scrollbar_on_off: false

                            listview_model: workers_list_model
                            listview_header: ListModel {
                                ListElement { name: "ТЛД";     width_val: 100; trole: "ID_TLD"}
                                ListElement { name: "ФИО";     width_val: 210; trole: "FIO"}
                            }
                        }
                    }
                }
            }
        }
    }

    Frame {
        id: frame2

        leftPadding: 20
        topPadding: 0//12
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 0
        anchors.top: header_rectangle.bottom
        anchors.left: pane0.right
        anchors.right: parent.right
        height: pane0.height-1

        background: Rectangle {
            anchors.fill: parent
            border.color: "lightgrey"//Material.color(Material.Grey, Material.Shade300)//"lavender"
            color: "white"//Material.color(Material.Blue, Material.Shade50)//"whitesmoke"
            radius: 2
        }

        Column {
            id: column
            spacing: 10 //5
            anchors.fill: parent

//            Row{
//                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
//                Layout.fillWidth: true
//                spacing: 10
//                Text {
//                    text: "Зона контроля:"
//                    font.pixelSize: 14
//                }
//                Text {
//                    id: block_name
//                    text: "-"
//                    font.pixelSize: 16
//                    width: 140
//                    //readOnly: true
//                }
//            }

            Text {
                text: "Личная карточка работника"
                topPadding: 10
                bottomPadding: 5
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 14
            }

            MyTextData {
                id: worker_info_fio
                l1width: 130
                label1_name: "ФИО:"
                text1_value: "-"
            }

            MyTextData {
                id: worker_info_department
                l1width: 130
                label1_name: "Цех:"
                text1_value: "-"
            }
            MyTextData {
                id: worker_info_tld
                l1width: 130
                label1_name: "Номер ТЛД:"
                text1_value: "-"
            }
            MyTextData {
                id: worker_info_personnumber
                l1width: 130
                label1_name: "Табельный номер:"
                text1_value: "-"
            }
            MyTextData {
                l1width: 130
                label1_name: "Зап. ИКУ:"
                text1_value: "-"
            }
            MyTextData {
                l1width: 130
                label1_name: "Разрешенная доза:"
                text1_value: "-"
            }

            MyTextData {
                l1width: 130
                t1width: 70
                l2width: 120
                label1_name: "D д.н.:"
                text1_value: "-"
                label2_name: "D сумм.:"
                text2_value: "-"
            }
            MyTextData {
                l1width: 130
                t1width: 70
                l2width: 120
                label1_name: "D ППД"
                text1_value: "-"
                label2_name: "Дата записи:"
                text2_value: "-"
            }
            MyTextData {
                l1width: 130
                t1width: 70
                l2width: 120
                label1_name: "АУ:"
                text1_value: "-"
                label2_name: "ИУ:"
                text2_value: "-"
            }

        }

    }

    Pane {
        id: pane1
        leftPadding: 1
        rightPadding: 1
        topPadding: 10
        bottomPadding: 1
        anchors.margins: 10

        anchors.top: pane0.bottom
        anchors.left: parent.left

        width: (parent.width - anchors.margins*3)/2// - anchors.margins

        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }

        Column {
            anchors.fill: parent
            spacing: 0

            Row {
                anchors.rightMargin: 10
                leftPadding: 10
                spacing: 10
                ComboBox {
                    id: cb_siz
                    width: 300
                    anchors.verticalCenter: parent.verticalCenter
                    textRole: "OPTION_NAME"
                    currentIndex: -1
                    model: managerDB.createModel("Select ID, option_name FROM table_specials WHERE id_type=1")
                }

                Rectangle {
                    width: 28
                    height: 28
                    anchors.verticalCenter: parent.verticalCenter
                    radius: 14
                    color: Material.color(Material.Grey, Material.Shade700)
                    border.color: Material.color(Material.Grey, Material.Shade800)//"Black"
                    border.width: 1
                    opacity: (cb_siz.currentIndex !== -1) ? 0.7 : 0.2
                    enabled: (cb_siz.currentIndex !== -1) ? true : false

                    Image {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        source: "icons/plus.svg"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            //а нет ли уже в списке такого элемента?
                            var res_compare = false
                            for(var i = siz_list_model.rowCount()-1; i >= 0; --i) {
                                if (cb_siz.model.get(cb_siz.currentIndex)["ID"] === siz_list_model.get(i)["ID"]) {
                                    res_compare = true
                                    break
                                }
                            }

                            if (!res_compare) {
                                siz_list_model.append({"ID": cb_siz.model.get(cb_siz.currentIndex)["ID"],
                                                       "OPTION_NAME": cb_siz.model.get(cb_siz.currentIndex)["OPTION_NAME"]});
                            }
                        }
                    }
                }
            }

            Frame {
                width: parent.width
                //height: 120
                leftPadding: 1
                rightPadding: 1
                topPadding: 1
                bottomPadding: 1

                background: Rectangle {
                    anchors.fill: parent
                    border.color: "lightgrey"//Material.color(Material.Grey, Material.Shade300)//"lavender"
                    color: "white"//Material.color(Material.Blue, Material.Shade50)//"whitesmoke"
                    radius: 2
                }

                Column {
                    anchors.fill: parent
                    spacing: 0
                    Rectangle {
                        height: 30
                        width: parent.width
                        color: Material.color(Material.Grey, Material.Shade700)

                        Label {
                            leftPadding: 8
                            text: "Средства индивидуальной защиты"
                            color: "White"
                            font.pixelSize: 16
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Rectangle {
                            id: delete_siz_button
                            height: 27
                            width: 27
                            color: "transparent"
                            radius: 2
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: 3

                            Image {
                                id: img_del_siz
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
                                    if (siz_list_model.rowCount() > 0)
                                        siz_list_model.remove(siz_table.currentIndex)
                                }

                                onEntered: {
                                    img_del_siz.sourceSize.height = 30
                                    img_del_siz.sourceSize.width = 30
                                }
                                onExited: {
                                    img_del_siz.sourceSize.height = 25
                                    img_del_siz.sourceSize.width = 25
                                }

                                onPressed: { parent.border.color = "white" }
                                onReleased: { parent.border.color = "transparent" }
                            }
                        }
                    }

                    Rectangle {
                        height: 125
                        width: parent.width
                        border.color: "lavender"
                        color: "whitesmoke"
                        anchors.margins: 0

                        MyTableView {
                            id: siz_table
                            anchors.fill: parent
                            horizontal_scrollbar_on_off: false

                            listview_model: siz_list_model
                            listview_header: ListModel {
                                ListElement { name: "Описание"; width_val: 366; trole: "OPTION_NAME"}
                            }
                        }
                    }
                }
            }
        }
    }


    Pane {
        id: pane2
        leftPadding: 1
        rightPadding: 1
        topPadding: 10
        bottomPadding: 1
        anchors.margins: 10

        anchors.top: pane0.bottom
        anchors.right: parent.right

        height: frame3.height
        width: pane1.width

        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }

        Column {
            anchors.fill: parent
            spacing: 0

            Row {
                anchors.rightMargin: 10
                leftPadding: 10
                spacing: 10
                ComboBox {
                    id: cb_mery_rb
                    width: 300
                    anchors.verticalCenter: parent.verticalCenter
                    textRole: "OPTION_NAME"
                    currentIndex: -1
                    model: managerDB.createModel("Select ID, option_name FROM table_specials WHERE id_type=2")
                }

                Rectangle {
                    width: 28
                    height: 28
                    anchors.verticalCenter: parent.verticalCenter
                    radius: 14
                    color: Material.color(Material.Grey, Material.Shade700)
                    border.color: Material.color(Material.Grey, Material.Shade800)//"Black"
                    border.width: 1
                    opacity: (cb_mery_rb.currentIndex !== -1) ? 0.7 : 0.2
                    enabled: (cb_mery_rb.currentIndex !== -1) ? true : false

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
                            for(var i = rb_list_model.rowCount()-1; i >= 0; --i) {
                                if (cb_mery_rb.model.get(cb_mery_rb.currentIndex)["ID"] === rb_list_model.get(i)["ID"]) {
                                    res_compare = true
                                    break
                                }
                            }

                            if (!res_compare) {
                                rb_list_model.append({"ID": cb_mery_rb.model.get(cb_mery_rb.currentIndex)["ID"],
                                                      "OPTION_NAME": cb_mery_rb.model.get(cb_mery_rb.currentIndex)["OPTION_NAME"]});
                            }
                        }
                    }
                }
            }

            Frame {
                width: parent.width
                //height: 120
                leftPadding: 1
                rightPadding: 1
                topPadding: 1
                bottomPadding: 1

                background: Rectangle {
                    anchors.fill: parent
                    border.color: "lightgrey"//Material.color(Material.Grey, Material.Shade300)//"lavender"
                    color: "white"//Material.color(Material.Blue, Material.Shade50)//"whitesmoke"
                    radius: 2
                }

                Column {
                    anchors.fill: parent
                    spacing: 0
                    Rectangle {
                        height: 30
                        width: parent.width
                        color: Material.color(Material.Grey, Material.Shade700)

                        Label {
                            leftPadding: 8
                            text: "Меры РБ"
                            color: "White"
                            font.pixelSize: 16
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Rectangle {
                            id: delete_rb_button
                            height: 27
                            width: 27
                            color: "transparent"
                            radius: 2
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: 3

                            Image {
                                id: img_del_rb
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
                                    if (rb_list_model.rowCount() > 0)
                                        rb_list_model.remove(rb_table.currentIndex)
                                }

                                onEntered: {
                                    img_del_rb.sourceSize.height = 30
                                    img_del_rb.sourceSize.width = 30
                                }
                                onExited: {
                                    img_del_rb.sourceSize.height = 25
                                    img_del_rb.sourceSize.width = 25
                                }

                                onPressed: { parent.border.color = "white" }
                                onReleased: { parent.border.color = "transparent" }
                            }
                        }
                    }

                    Rectangle {
                        height: 125
                        width: parent.width
                        border.color: "lavender"
                        color: "whitesmoke"
                        anchors.margins: 0

                        MyTableView {
                            id: rb_table
                            anchors.fill: parent
                            horizontal_scrollbar_on_off: false

                            listview_model: rb_list_model
                            listview_header: ListModel {
                                ListElement { name: "Описание"; width_val: 366; trole: "OPTION_NAME"}
                            }
                        }
                    }
                }
            }
        }
    }


    Column {
        anchors.top: pane1.bottom
        anchors.left: pane1.left
        anchors.right: pane2.right
        anchors.margins: 10
        spacing: 5

        Text {
            text: "Особые условия (" + (200 - special_cond.length) + ")"
            font.pixelSize: 16
        }

        TextField {
            id: special_cond
            width: parent.width
            clip: true
            selectByMouse: true
            maximumLength: 200
            font.pixelSize: 16
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
            var data_record = {} // ["workers", "siz", "rb", "comment"]
            data_record["WORKERS"] = workers_list_model
            data_record["SIZ"] = siz_list_model
            data_record["RB"] = rb_list_model
            data_record["COMMENT"] = special_cond.text

            switch (item3.state) {
            case "edit":
                item3.edit_confirm(data_record)
                break

            case "wizard":
                item3.wizard_next(data_record) //workers_list_model
                break
            }

            item3.clearfields()
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
            switch (item3.state) {
            case "edit":
                item3.edit_cancel()
                break
            case "wizard":
                item3.wizard_back()
                break
            }

            //item3.itemcancel()
            item3.clearfields()
        }
    }
}
