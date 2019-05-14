import QtQuick 2.12
import QtQuick.Controls 2.5

import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

import QtQuick.Dialogs 1.2

Page {
    property int space_margin: 15

    Label {
        anchors.centerIn: parent
        text:"workerCard_&"
    }

    Connections {
        target: workersModel
        onSignalUpdateDone: {
            if(nameModel=="model_PERSON")
            {
                if (workersModel.rowCount() > 0) {
                    // общая информация
                    //doznarad_position.text = workersModel.get(0)["doznarad_position"]


                    var str = "";

                    // персональная информация
                    txt_fio.text        = workersModel.get(0)["W_NAME"] + " " + workersModel.get(0)["W_SURNAME"] + " " + workersModel.get(0)["W_PATRONYMIC"]
                    txt_pn.text         = workersModel.get(0)["PERSON_NUMBER"]
                    txt_staff_type.text = workersModel.get(0)["STAFF_TYPE"]
                    txt_tld.text        = workersModel.get(0)["ID_TLD"]
                    txt_status.text     = workersModel.get(0)["STATUS"]

                    txt_iku_month.text = workersModel.get(0)["IKU_MONTH"]
                    txt_iku_year.text  = workersModel.get(0)["IKU_YEAR"]


                     str = workersModel.get(0)["DATE_ON"]
//                     var options = {
//                       year: 'numeric',
//                       month: 'long',
//                       day: 'numeric'
//                     };
//                     str.toLocaleString("ru", options)
                   ///ДАТА РАСКОМЕНТИРОВАТЬ  txt_date_on.text  = str.getDate() + "." + (str.getMonth()+1)  + "." + str.getFullYear()   //String(workersModel.get(0)["DATE_ON"]).substring(0,20)
                     str = workersModel.get(0)["DATE_OFF"]
                  ///ДАТА РАСКОМЕНТИРОВАТЬ   txt_date_off.text = str.getDate() + "." + (str.getMonth()+1)  + "." + str.getFullYear()
                    //txt_date_off.text = String(workersModel.get(0)["DATE_OFF"])

                    //3
                    txt_gender.text   = workersModel.get(0)["SEX"]
                     str = workersModel.get(0)["BIRTH_DATE"]
                   ///ДАТА РАСКОМЕНТИРОВАТЬ txt_birthday.text = str.getDate() + "." + (str.getMonth()+1) + "." + str.getFullYear()
                    txt_weight.text   = workersModel.get(0)["WEIGHT"]
                    txt_height.text   = workersModel.get(0)["HEIGHT"]

                    //txt_pass_serial.text  = workersModel.get(0)["passport_series"]
                    txt_pass_number.text  = workersModel.get(0)["PASSPORT_NUMBER"]
                    txt_pass_whoget.text  = workersModel.get(0)["PASSPORT_GIVE"]
                     str = workersModel.get(0)["PASSPORT_DATE"]
                    ///ДАТА РАСКОМЕНТИРОВАТЬ txt_pass_dateget.text = str.getDate() + "." +(str.getMonth()+1)  + "." + str.getFullYear()

                    txt_medical_number.text = workersModel.get(0)["POLICY_NUMBER"]
                    txt_medical_series.text = workersModel.get(0)["SNILS"]

                    txt_snils.text = workersModel.get(0)["SNILS"]

                    txt_mobile_phone.text = workersModel.get(0)["MOBILE_TEL"]
                    txt_home_address.text = workersModel.get(0)["HOME_ADDRESS"]
                    txt_home_phone.text = workersModel.get(0)["HOME_TEL"]

                    txt_work_phone.text = workersModel.get(0)["WORK_TEL"]
                    txt_work_address.text = workersModel.get(0)["WORK_ADDRESS"]
                    txt_work_email.text = workersModel.get(0)["E_MAIL"]
                }

            }

        }

    }


    // добавление нового сотрудника в бд
    function createNewPerson(map_data) {
        console.log("createNewPerson: ");
        Query1.insertRecordIntoTable("WorkersCard" ,"EXT_PERSON", map_data) //wc_query.map_data

    }

    Popup {
        id:popup_AddWorker
        width: addworker.width + padding*2
        height: addworker.height + padding*2

        modal: true
        focus: true
        closePolicy: Popup.NoAutoClose
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        padding: 0

//        Loader {
//            id:loaderAddWorker
//            sourceComponent: (popup_AddWorker.open()) ? redSquare : undefined//
//        }

//        Component {
//               id: redSquare
//               AddWorker {
//                   id: addworker
//                   onCreate_cancel: {
//                       popup_AddWorker.close();
//                       loaderAddWorker.sourceComponent = undefined;
//                   }
//                   onCreate_confirm: {
//                       popup_AddWorker.close()
//                       loaderAddWorker.sourceComponent = undefined;
//                       createNewPerson(data_record)
//                   }
//               }

//           }

        AddWorker {
            id: addworker
            onCreate_cancel: {
                popup_AddWorker.close();
                //loaderAddWorker.sourceComponent = undefined;
            }
            onCreate_confirm: {
                popup_AddWorker.close()
                //loaderAddWorker.sourceComponent = undefined;
                createNewPerson(data_record)
            }
        }


    }




    Frame {
        id:frame_wmenu

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






        Row {
            id: row
            spacing: 10
            ToolButton {
                text: "Новый сотрудник"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                flat: true
                onClicked: {
                    popup_AddWorker.open()
                }
            }
            ToolSeparator {}
            ToolButton {
                text: "Редактировать"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                flat: true
                onClicked: {
                    //popup_wait.open()
                }
            }
            ToolButton {
                text: "Снять с контроля"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                flat: true
            }
            ToolSeparator {}
            ToolButton {
                text: "Удалить"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                flat: true
            }
            ToolSeparator {}
            Button {
                text:"testQuery"
                onClicked: { Query1.setQuery(" SELECT (w_surname + ' ' + SUBSTR(w_name, 1, 1) + '. ' + SUBSTR(w_patronymic, 1, 1) + '.') fname,
                                  id_tld tld, PERSON_NUMBER, id_person ID
                                  FROM ext_person
                                  WHERE (LOWER(w_surname) LIKE '"+ "I" +"%')
                                  ORDER BY w_surname "); }
                           //{ Query1.setQuery("SELECT tek_postanovka.w_name FROM tek_postanovka WHERE id_person=1"); }
                           //{ Query1.setQuery("SELECT ADM_DEPARTMENT.DEPARTMENT FROM ADM_DEPARTMENT WHERE ID=1"); }
                           //{ Query1.setQuery("SELECT max(id_person) max_id FROM tek_postanovka WHERE id_tld = 1001"); }
            }
            Label{
                id:testTXT
                text:"---"
            }
            Connections {
                target: Query1
                onSignalSendResult: {
                    testTXT.text = var_res;
                }
            }
        }

        MyFindField {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 9
            ffwidth: 230
            ffheight: 30
            flg_f: true

            ffbackground: Rectangle {
                anchors.fill: parent
                radius: 5
                color: "White"
                border.color: "DarkGray"
            }

            onId_recChanged: {
                if (id_rec !== -1) {
                    //popup_wait.open()
                    console.log("-!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!->");
                    workersModel.query = " SELECT W_SURNAME, W_NAME, W_PATRONYMIC, PERSON_NUMBER,
                                           SEX, BIRTH_DATE, DOSE_BEFORE_NPP,DOSE_CHNPP, IKU_YEAR, IKU_MONTH,
                                           WEIGHT, HEIGHT, DATE_ON, DATE_OFF, EMERGENCY_DOSE,DISABLE_RADIATION,
                                           ID_TLD, STAFF_TYPE,

                                           PASSPORT_NUMBER,  PASSPORT_GIVE,
                                           PASSPORT_DATE, POLICY_NUMBER, SNILS,
                                           HOME_ADDRESS, HOME_TEL,
                                           WORK_TEL,MOBILE_TEL, WORK_ADDRESS, E_MAIL,

                                           adm_status.STATUS

                                           FROM ext_person
                                           LEFT JOIN adm_status ON ext_person.STATUS_CODE = adm_status.STATUS_CODE
                                           WHERE ext_person.ID_PERSON = " + id_rec;

//                    workersModel.query = " SELECT W_SURNAME, W_NAME, W_PATRONYMIC, id_person,
//                                           sex, birth_date, dose_before_npp, dose_chnpp, iku_year, iku_month,
//                                           weight, height, date_on, date_off, emergency_dose,disable_radiation,
//                                           id_tld, STAFF_TYPE,

//                                           passport_number,  passport_give,
//                                           passport_date, policy_number, snils,
//                                           home_address,
//                                           work_tel, work_address, E_MAIL,

//                                           adm_status.status

//                                           FROM ext_person, adm_status
//                                           WHERE ext_person.id_person = " + id_rec +
//                                    " and
//                                           adm_status.status_code = ext_person.status_code

//                                           "
//                                         " and adm_person_type.ID = workers.person_type
//                                           and adm_department.ID = workers.department
//                                           and tek_person.id_person = workers.id_person "



//                    workersModel.query = " SELECT W_SURNAME, W_NAME, W_PATRONYMIC, workers.id_person,
//                                           gender, birth_date, dose_before_npp, dose_chnpp, iku_year, iku_month,
//                                           weight, height, date_on, date_of, emergency_dose,disable_radiation,
//                                           id_tld, doznarad_position,

//                                           tek_person.passport_series, tek_person.passport_number, tek_person.passport_vydan,
//                                           tek_person.passport_date, tek_person.polis_number, tek_person.polis_series,
//                                           tek_person.pension_number, tek_person.home_tel, tek_person.home_address,
//                                           tek_person.work_tel, tek_person.work_address,

//                                           adm_person_type.person_type, adm_department.department

//                                           FROM workers, adm_person_type, adm_department, tek_person
//                                           WHERE workers.id_person = " + id_rec +
//                                         " and adm_person_type.ID = workers.person_type
//                                           and adm_department.ID = workers.department
//                                           and tek_person.id_person = workers.id_person "


//                    workersModel.query = "SELECT (W_SURNAME || ' ' || W_NAME || ' ' || W_PATRONYMIC) FNAME,
//                                          TLD_NUMBER, PERSON_NUMBER PN, IKU_YEAR, IKU_MONTH,
//                                          GENDER, ID, BIRTHDAY, WEIGHT, GROWTH,
//                                          PASSPORT_SERIAL, PASSPORT_NUMBER, PASSPORT_WHO, PASSPORT_DATE,
//                                          PANSION_NUMBER, MEDICAL_NUMBER,
//                                          HOME_PHONE, HOME_ADDRESS, MOBILE_PHONE
//                                          FROM TABLE_WORKERS
//                                          WHERE ID = " + id_rec


                }
            }
        }



    }

    Frame {
        id: frame_who
        anchors.left: parent.left
        anchors.top: frame_wmenu.bottom
        anchors.margins: space_margin
        anchors.right: parent.right

        padding: 1
        topPadding: 1
        bottomPadding: 1

        height: implicitContentHeight//190
        //width: 670


        background: Rectangle {
            anchors.fill: parent
            color: "White"
            border.color: "LightGray"
            //radius: 7
        }

        Column {
            anchors.fill: parent
            spacing: 0

            Row {
                //id: row1
                //Layout.fillWidth: true
                spacing: 20
                padding: 10

                Rectangle {
                    width: 115
                    height: 130

                    //                    border.color: "Silver"
                    //                    color: Material.color(Material.BlueGrey, Material.Shade100)
                    border.color: "LightGray"
                    //color: "aliceblue"//"whitesmoke"
                    Image {
                        opacity: 0.2
                        sourceSize.height: 100
                        sourceSize.width: 100
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "icons/face.svg"

                    }
                }

                Column {
                    spacing: 10
                    padding: 0
                    topPadding: 0
                    Text {
                        id: txt_fio
                        text: ".."
                        font.family: "Tahoma"
                        font.pixelSize: 28
                        color: Material.color(Material.DeepOrange) //"midnightblue"//"#333333"//"steelblue"
                    }
                    Row {
                        id: row1
                        //leftPadding: 10
                        Column {
                            //width: 110
                            spacing: 5
                            rightPadding: 10
                            Label {
                                text: "Табельный №"
                                //anchors.right: parent.right
                                font.pixelSize: 14
                                color: "black"
                            }
                            Label {
                                text: "№ ТЛД"
                                //anchors.right: parent.right
                                font.pixelSize: 14
                                color: "black"
                            }
                            Label {
                                text: "Тип персонала"
                                //anchors.right: parent.right
                                font.pixelSize: 14
                                color: "black"
                            }
                            Label {
                                text: "Статус"
                                //anchors.right: parent.right
                                font.pixelSize: 14
                                color: "black"
                            }
                        }
                        Column {
                            width: 220
                            spacing: 5
                            Text {
                                id: txt_pn
                                text: ".."
                                font.pixelSize: 14
                                color: "darkslategrey"
                            }
                            Text {
                                id: txt_tld
                                text: ".."
                                font.pixelSize: 14
                                color: "darkslategrey"
                            }
                            Text {
                                id: txt_staff_type
                                text: ".."//"Основной персонал АЭС"
                                font.pixelSize: 14
                                color: "darkslategrey"
                            }
                            Text {
                                id: txt_status
                                text: ".."//"Работал весь отчетный год"
                                font.pixelSize: 14
                                color: "darkslategrey"
                            }
                        }


                    }
                }
            }
        }
    }


    Frame {
        id: frame_dose_summary
        anchors.left: parent.left
        anchors.top: frame_who.bottom
        anchors.right: parent.right
        anchors.margins: space_margin

        padding: 1
        topPadding: 10
        bottomPadding: 10
        leftPadding: 10

        //height: 90
        background: Rectangle {
            anchors.fill: parent
            color: "White"
            border.color: "LightGray"
            //radius: 7
        }

        Row {
            Column {
                //width: 110
                spacing: 5
                rightPadding: 10
                Label {
                    text: "ИКУ (в год)"
                    //anchors.right: parent.right
                    font.pixelSize: 14
                    color: "black"
                }
                Label {
                    text: "ИКУ (в месяц)"
                    //anchors.right: parent.right
                    font.pixelSize: 14
                    color: "black"
                }
                Label {
                    text: "Годовая доза"
                    //anchors.right: parent.right
                    font.pixelSize: 14
                    color: "black"
                }

            }
            Column {
                width: 100
                spacing: 5
                Text {
                    id: txt_iku_year
                    text: ".."
                    font.pixelSize: 14
                    color: "darkslategrey"
                }
                Text {
                    id: txt_iku_month
                    text: ".."
                    font.pixelSize: 14
                    color: "darkslategrey"
                }
                Row {
                    id: row2
                    spacing: 10

                    Text {
                        text: ".."
                        font.pixelSize: 14
                        color: "darkslategrey"//"indianred"
                    }

                }

            }

            Column {
                //anchors.bottom: parent.bottom
                //width: 230
                spacing: 5
                rightPadding: 10
                Label {
                    text: "Дата постановки на учет"// "Дата следущего котроля на СИЧ"
                    //anchors.right: parent.right
                    font.pixelSize: 14
                    color: "black"
                }
                Label {
                    text: "Дата снятия с учета" //"Тип следующего контроля на СИЧ"
                    //anchors.right: parent.right
                    font.pixelSize: 14
                    color: "black"
                }
            }
            Column {
                //anchors.bottom: parent.bottom
                //width: 230
                spacing: 5
                rightPadding: 10
                Text {
                    id:txt_date_on
                    text: ".."
                    //anchors.right: parent.right
                    font.pixelSize: 14
                    color: "darkslategrey"
                }
                Text {
                    id:txt_date_off
                    text: ".."
                    //anchors.right: parent.right
                    font.pixelSize: 14
                    color: "darkslategrey"
                }
            }
        }

    }



    Frame {
        id: frame_tabbar
        anchors.left: parent.left
        anchors.top: frame_dose_summary.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: space_margin

        padding: 1
        topPadding: 1
        bottomPadding: 1

        background: Rectangle {
            anchors.fill: parent
            color: "White"
            border.color: "LightGray"
            //radius: 7
        }


        TabBar {
            id: tabbar_workerinfo
            width: parent.width
            currentIndex: 1
            font.pixelSize: 14
            background: Rectangle { color: "#eeeeee" }
            property int tbwidth: 300
            TabButton {
                text: "Общая информация"
                width: implicitWidth
            }
            TabButton {
                text: "Персональная информация"
                width: implicitWidth
            }
            TabButton {
                text: "Информация по дозам"
                width: implicitWidth
            }
            TabButton {
                text: "Зоны контроля"
                width: implicitWidth
            }
        }

        StackLayout {
            anchors.bottom: parent.bottom
            anchors.top: tabbar_workerinfo.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            currentIndex: tabbar_workerinfo.currentIndex

            Item {
                id: wtab1

                Pane {
                    id: wtab1_aboutwork
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 170
                    padding: 5
                    //enabled: false
                    background: Rectangle {
                        anchors.fill: parent
                        color: "White"
                        border.color: "transparent"
                        //radius: 7
                    }
                    Row {
                        spacing: 5
                        Label {
                            text: "Дознаряд:"
                        }
                        Rectangle {
                            width: 150
                            height: 20
                            color: Material.color(Material.Lime)
                            Label {
                                id: doznarad_position
                                anchors.centerIn: parent
                                font.bold: true
                                color: Material.color(Material.Teal)
                            }

                        }
                    }



//                    Column {
//                        spacing: 10
//                        Row {
//                            spacing: 20
//                            CheckBox {
//                                text: "Выдающий"
//                                height: 25
//                                font.pixelSize: 14
//                                checkable: false
//                                hoverEnabled: false
//                            }
//                            CheckBox {
//                                text: "Руководитель"
//                                height: 25
//                                font.pixelSize: 14
//                                checkable: false
//                                hoverEnabled: false
//                            }
//                            CheckBox {
//                                text: "Производитель"
//                                height: 25
//                                font.pixelSize: 14
//                                checkable: false
//                                hoverEnabled: false
//                            }
//                            CheckBox {
//                                text: "Открывающий"
//                                height: 25
//                                font.pixelSize: 14
//                                checkable: false
//                                //checkState: Qt.Checked
//                                hoverEnabled: false
//                            }
//                            CheckBox {
//                                text: "Закрывающий"
//                                height: 25
//                                font.pixelSize: 14
//                                checkable: false
//                                //checkState: Qt.Checked
//                                hoverEnabled: false
//                            }
//                        }
//                        Label {
//                            text: "Уровень полномочий по дозе на выдачу дознаряда: 0.0 мЗв"
//                            verticalAlignment: Text.AlignVCenter
//                            height: 25
//                            font.pixelSize: 14
//                            color: "Black"
//                            leftPadding: 10
//                        }

//                        Row {
//                            spacing: 20
//                            Column {
//                                CheckBox {
//                                    text: "Доступ c ППД"
//                                    height: 25
//                                    font.pixelSize: 14
//                                    checkable: false
//                                    hoverEnabled: false
//                                }
//                                CheckBox {
//                                    text: "Аварийная доза"
//                                    height: 25
//                                    font.pixelSize: 14
//                                    checkable: false
//                                    hoverEnabled: false
//                                }
//                                CheckBox {
//                                    text: "Запрет работы с ИИИ"
//                                    height: 25
//                                    font.pixelSize: 14
//                                    checkable: false
//                                    hoverEnabled: false
//                                }
//                            }
//                        }
//                    }



                }




                Rectangle {
                    id: wtab1_tableheader
                    height: 30
                    anchors.top: wtab1_aboutwork.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    color: Material.color(Material.BlueGrey, Material.Shade100)
                    border.color: "LightGray"

                    Label {
                        text: "История работы"
                        anchors.verticalCenter: parent.verticalCenter
                        //anchors.right: parent.right
                        font.pixelSize: 16
                        color: "Black"
                        leftPadding: 10
                    }
                    Row {
                        anchors.right: parent.right
                        rightPadding: 10
                        spacing: 10
                        ToolButton {
                            text: "Добавить историю"
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 12
                            flat: true
                            height: 30
                        }
                        ToolSeparator {height: 30}
                        ToolButton {
                            text: "Редактировать историю"
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 12
                            flat: true
                            height: 30
                        }
                        ToolSeparator {height: 30}
                        ToolButton {
                            text: "Удалить"
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 12
                            flat: true
                            height: 30
                        }
                    }
                }

                Pane {
                    id:wtab1_history_work

                    anchors.top: wtab1_tableheader.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    padding: 0

                    TableView {
                        id: workers_table
                        anchors.fill: parent
                        columnSpacing: 1
                        rowSpacing: 1
                        clip: true

                        model: workersModel

//                        topMargin: header.implicitHeight
//                        Text {
//                            id: header
//                            text: "A table header"
//                        }


                        delegate: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 50
                            Text {
                                //text: (heading==true) ? "Дата принятия на контроль"  : W_NAME
                            }
                        }
                    }

//                    MyTableView {
//                        id: workers_table
//                        anchors.fill: parent

//                        listview_header: ListModel {
//                            ListElement { name: "Принят на контроль"; width_val: 150;  trole: "" }
//                            ListElement { name: "Снят с контроля";    width_val: 150;  trole: ""}
//                            ListElement { name: "Место работы";       width_val: 350; trole: ""}
//                            ListElement { name: "Должность";          width_val: 250; trole: ""}
//                        }
//                    }
                }
            }

            Item {
                id: wtab2
                Pane {
                    id: wtab2_passport
                    anchors.fill: parent
                    padding: 5
                    property int sizeHeader: 14
                    property int sizeTxt: 14
                    property int heightAll: 60
                    property int widthAll: 400

                    background: Rectangle {
                        anchors.fill: parent
                        color: "White"
                        //border.color: "transparent"
                        //radius: 7
                    }
                    Column {
                        spacing: 20
                        Row {
                            spacing: 20
                            Rectangle {
                                height: wtab2_passport.heightAll
                                width:  400
                                //border.color: "LightGray"
                                Column {
                                    spacing: 5
                                    Label {
                                        text: "Личные данные"
                                        verticalAlignment: Text.AlignVCenter
                                        height: 25
                                        font.pixelSize: wtab2_passport.sizeHeader
                                        color: "Black"
                                        leftPadding: 10
                                    }
                                    Rectangle {
                                        height: 1
                                        width: 400
                                        color: "LightGray"
                                    }
                                    Row {
                                        leftPadding: 10
                                        spacing: 5

                                        Label {
                                            text: "Пол:"
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit {
                                            id: txt_gender
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }

                                        Label {
                                            leftPadding: 10
                                            text: "Родился:"
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit  {
                                            id: txt_birthday
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }

                                        Label {
                                            leftPadding: 10
                                            text: "Вес:"
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit {
                                            id: txt_weight
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }

                                        Label {
                                            leftPadding: 10
                                            text: "Рост:"
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit {
                                            id: txt_height
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }
                                    }
                                }
                            }

                            Rectangle {
                                height: wtab2_passport.heightAll
                                width:  550
                                //border.color: "LightGray"
                                Column {
                                    spacing: 5
                                    Label {
                                        text: "Паспортные данные"
                                        verticalAlignment: Text.AlignVCenter
                                        height: 25
                                        font.pixelSize: wtab2_passport.sizeHeader
                                        color: "Black"
                                        leftPadding: 10
                                        //font.bold: true
                                    }

                                    Rectangle {
                                        height: 1
                                        width: 550
                                        color: "LightGray"
                                    }
                                    Row {
                                        leftPadding: 10
                                        spacing: 5

                                        Label {
                                            text: "Серия:"
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit {
                                            id: txt_pass_serial
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }

                                        Label {
                                            text: "Номер:"
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            leftPadding: 10
                                        }
                                        TextEdit {
                                            id: txt_pass_number
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }
                                        Column {
                                            Row {
                                                spacing: 5
                                                Label {
                                                    text: "Выдан:"
                                                    font.pixelSize: wtab2_passport.sizeTxt
                                                    leftPadding: 10
                                                }
                                                TextEdit {
                                                    id: txt_pass_whoget
                                                    font.pixelSize: wtab2_passport.sizeTxt
                                                    font.bold: true
                                                    color: Material.color(Material.Teal)
                                                    selectByMouse: true
                                                    selectionColor: Material.color(Material.Red)
                                                }
                                            }

                                            Row {
                                                spacing: 5
                                                Label {
                                                    text: "Дата выдачи:"
                                                    font.pixelSize: wtab2_passport.sizeTxt
                                                    leftPadding: 10
                                                }
                                                TextEdit {
                                                    id: txt_pass_dateget
                                                    font.pixelSize: wtab2_passport.sizeTxt
                                                    font.bold: true
                                                    color: Material.color(Material.Teal)
                                                    selectByMouse: true
                                                    selectionColor: Material.color(Material.Red)
                                                }
                                            }

                                        }


                                        }


                                }
                            }
                        }

                        Row {
                            spacing: 20
                            Rectangle {
                                height: wtab2_passport.heightAll
                                width:  400
                                //border.color: "LightGray"
                                Column {
                                    spacing: 5
                                    Label {
                                        text: "Данные медицинского полиса"
                                        verticalAlignment: Text.AlignVCenter
                                        height: 25
                                        font.pixelSize: wtab2_passport.sizeHeader
                                        color: "Black"
                                        leftPadding: 10
                                    }
                                    Rectangle {
                                        height: 1
                                        width: 400
                                        color: "LightGray"
                                    }
                                    Row {
                                        leftPadding: 10
                                        spacing: 5

                                        Label {
                                            text: "Номер:"
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit {
                                            id: txt_medical_number
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }

                                        Label {
                                            leftPadding: 10
                                            text: "Серия:(снилс)"
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit  {
                                            id: txt_medical_series
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }

                                    }
                                }
                            }

                            Rectangle {
                                height: wtab2_passport.heightAll
                                width:  400
                                //border.color: "LightGray"
                                Column {
                                    spacing: 5
                                    Label {
                                        text: "СНИЛС"
                                        verticalAlignment: Text.AlignVCenter
                                        height: 25
                                        font.pixelSize: wtab2_passport.sizeHeader
                                        color: "Black"
                                        leftPadding: 10
                                    }
                                    Rectangle {
                                        height: 1
                                        width: 400
                                        color: "LightGray"
                                    }
                                    Row {
                                        leftPadding: 10
                                        spacing: 5

                                        Label {
                                            text: "Номер:"
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit {
                                            id: txt_snils
                                            font.pixelSize: 14
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }
                                    }
                                }
                            }



                        }


                        Row {
                            spacing: 20
                            Rectangle {
                                height: wtab2_passport.heightAll
                                width:  400
                                //border.color: "LightGray"
                                Column {
                                    spacing: 5
                                    Label {
                                        text: "Дом"
                                        verticalAlignment: Text.AlignVCenter
                                        height: 25
                                        font.pixelSize: wtab2_passport.sizeHeader
                                        color: "Black"
                                        leftPadding: 10
                                    }
                                    Rectangle {
                                        height: 1
                                        width: 400
                                        color: "LightGray"
                                    }

                                    Column {
                                        spacing: 5
                                        Row {
                                            leftPadding: 10
                                            spacing: 5

                                            Label {
                                                text: "Дом. телефон:"
                                                font.pixelSize: wtab2_passport.sizeTxt
                                            }
                                            TextEdit {
                                                id: txt_home_phone
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                            }

                                            Label {
                                                text: "Моб. телефон:"
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                leftPadding: 10
                                            }
                                            TextEdit {
                                                id: txt_mobile_phone
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                            }
                                        }

                                        Row {
                                            spacing: 5
                                            Label {
                                                text: "Адрес:"
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                leftPadding: 10
                                            }
                                            TextEdit {
                                                id: txt_home_address
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                            }
                                        }
                                    }

                                }
                            }


                            Rectangle {
                                height: wtab2_passport.heightAll
                                width:  400
                                //border.color: "LightGray"
                                Column {
                                    spacing: 5
                                    Label {
                                        text: "Работа"
                                        verticalAlignment: Text.AlignVCenter
                                        height: 25
                                        font.pixelSize: wtab2_passport.sizeHeader
                                        color: "Black"
                                        leftPadding: 10
                                    }
                                    Rectangle {
                                        height: 1
                                        width: 400
                                        color: "LightGray"
                                    }

                                    Column {
                                        spacing: 5
                                        Row {
                                            leftPadding: 10
                                            spacing: 5

                                            Label {
                                                text: "Раб. телефон:"
                                                font.pixelSize: wtab2_passport.sizeTxt
                                            }
                                            TextEdit {
                                                id: txt_work_phone
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                            }

                                            Label {
                                                text: "Эл. почта:"
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                leftPadding: 10
                                            }
                                            TextEdit {
                                                id: txt_work_email
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                            }
                                        }

                                        Row {
                                            spacing: 5
                                            Label {
                                                text: "Адрес:"
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                leftPadding: 10
                                            }
                                            TextEdit {
                                                id: txt_work_address
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                    }



                }


            }

            Item {
                id: wtab3
                Label {
                    text: "tab 3"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Item {
                id: wtab41
                Label {
                    text: "tab 4"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }







}