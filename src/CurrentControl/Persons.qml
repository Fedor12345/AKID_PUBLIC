import QtQuick 2.12
import QtQuick.Controls 2.5

import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.5

//import QtQuick.Shapes 1.12

import QtQuick.Dialogs 1.2



Page {
    id: main_

    clip: true

    property var id_currentPerson: undefined

    property string text_color: "#808080"
    property string textData_color:   "#808080"  //"#6b6b6b" // Material.color(Material.Teal)
    property string textHeader_color: "#777777"
    property int space_margin: 15
    /// количество чисел после запятой для доз отображаемых в интерфейсе
    property int nDecimalNumbers: 2

    property var model_person
//    property var model_ext_person_list
//    property var model_adm_status //:           stackview_mainwindow.model_adm_status
//    property var model_adm_assignment //:       stackview_mainwindow.model_adm_assignment
//    property var model_adm_organisation //:     stackview_mainwindow.model_adm_organisation
//    property var model_adm_department_outer //: stackview_mainwindow.model_adm_department_outer
//    property var model_adm_department_inner //: stackview_mainwindow.model_adm_department_inner

    /// удалить сигналы:
    //signal currentPersonChange(var id_currentPerson, var fio_currentPerson, var sex, var staff_type, var age)
    //signal currentPersonChange_photo(var imagePath)
    //signal currentPersonChange_date_burn(var burn_date_lost)
    /////////////////////

    /// сигнал запрашивает CurrentControl о запуске функции обновления данных о дозах сотрдника
    signal updatePersonParameters(var id_person, var date_begin, var date_end)

    property alias date_begin: item_InfoDoseOptions_header2.date_begin
    property alias date_end:   item_InfoDoseOptions_header2.date_end


//    ListModel {
//        id: z
//    }


//    function mainFunction() {
//        if (main_.id_currentPerson == undefined) return false;

//        //        workerModelQuery(main_.id_currentPerson)
//        //        getPersonPhoto(main_.id_currentPerson)
//        //        getPersonParameters(main_.id_currentPerson)
//    }

    /// Вывод данных о дозах в интерфейс
    function showDose(Z){
        ///  Выводим данные "Основные параметры, мЗв"
        txt_mainParams1.text = parseFloat(Z["Z9"]).toFixed(main_.nDecimalNumbers)
        txt_mainParams2.text = parseFloat(Z["Z12"]).toFixed(main_.nDecimalNumbers)
        txt_mainParams3.text = parseFloat(Z["Z15"]).toFixed(main_.nDecimalNumbers)
        txt_mainParams4.text = parseFloat(Z["Z18"]).toFixed(main_.nDecimalNumbers)

        /// Выводим данные "Индивидуальная эффективная доза, мЗв" (1 часть)
        txt_TLD_Y_data.text = parseFloat(Z["Z21"]).toFixed(main_.nDecimalNumbers);
        txt_TLD_n_data.text = parseFloat(Z["Z22"]).toFixed(main_.nDecimalNumbers);
        txt_EPD_Y_data.text = parseFloat(Z["Z23"]).toFixed(main_.nDecimalNumbers);
        txt_EPD_n_data.text = parseFloat(Z["Z24"]).toFixed(main_.nDecimalNumbers);

        /// Выводим данные "эквивалентная доза, мЗв" (1 часть)
        txt_EqDose_TLD_y_1.text =  parseFloat(Z["Z25"]).toFixed(main_.nDecimalNumbers);
        txt_EqDose_TLD_n_1.text =  parseFloat(Z["Z26"]).toFixed(main_.nDecimalNumbers);
        txt_EqDose_TLD_b_1.text =  parseFloat(Z["Z27"]).toFixed(main_.nDecimalNumbers);
        txt_EqDose_EPD_y_1.text =  parseFloat(Z["Z28"]).toFixed(main_.nDecimalNumbers);
        txt_EqDose_EPD_n_1.text =  parseFloat(Z["Z29"]).toFixed(main_.nDecimalNumbers);
        txt_EqDose_EPD_b_1.text =  parseFloat(Z["Z30"]).toFixed(main_.nDecimalNumbers);
        txt_EqDose_TLD_y_2.text =  parseFloat(Z["Z31"]).toFixed(main_.nDecimalNumbers);
        txt_EqDose_TLD_n_2.text =  parseFloat(Z["Z32"]).toFixed(main_.nDecimalNumbers);
        txt_EqDose_TLD_b_2.text =  parseFloat(Z["Z33"]).toFixed(main_.nDecimalNumbers);
        txt_EqDose_EPD_y_2.text =  parseFloat(Z["Z34"]).toFixed(main_.nDecimalNumbers);
        txt_EqDose_EPD_n_2.text =  parseFloat(Z["Z35"]).toFixed(main_.nDecimalNumbers);
        txt_EqDose_EPD_b_2.text =  parseFloat(Z["Z36"]).toFixed(main_.nDecimalNumbers);
        txt_EqDose_TLD_y_3.text =  parseFloat(Z["Z37"]).toFixed(main_.nDecimalNumbers);
        txt_EqDose_TLD_n_3.text =  parseFloat(Z["Z38"]).toFixed(main_.nDecimalNumbers);
        //txt_EqDose_TLD_b_3.text =  parseFloat(Z["Z39"]).toFixed(main_.nDecimalNumbers);
        txt_EqDose_EPD_y_3.text =  parseFloat(Z["Z40"]).toFixed(main_.nDecimalNumbers);
        txt_EqDose_EPD_n_3.text =  parseFloat(Z["Z41"]).toFixed(main_.nDecimalNumbers);
        //txt_EqDose_EPD_b_3.text =  parseFloat(Z["Z42"]).toFixed(main_.nDecimalNumbers);


        /// Эффективная доза. мЗв
        txt_ParamsEffIntDose_KSICH.text        = parseFloat(Z["Z43"]).toFixed(main_.nDecimalNumbers);
        txt_ParamsEffIntDose_ISICH.text        = parseFloat(Z["Z44"]).toFixed(main_.nDecimalNumbers);
        txt_ParamsEffIntDose_RESULT_1.text     = parseFloat(Z["Z45"]).toFixed(main_.nDecimalNumbers);
        txt_ParamsEffIntDose_JSICH.text        = parseFloat(Z["Z46"]).toFixed(main_.nDecimalNumbers);
        txt_ParamsEffIntDose_RESULT_2.text     = parseFloat(Z["Z47"]).toFixed(main_.nDecimalNumbers);

        /// Активность по радионуклидам, Бк
        txt_RadionuclideActivity_KSICH_1.text  = parseFloat(Z["Z48"]).toFixed(main_.nDecimalNumbers);
        txt_RadionuclideActivity_ISICH_1.text  = parseFloat(Z["Z49"]).toFixed(main_.nDecimalNumbers);
        txt_RadionuclideActivity_RESULT_1.text = parseFloat(Z["Z50"]).toFixed(main_.nDecimalNumbers);
        txt_RadionuclideActivity_STOCK_1.text  = parseFloat(Z["Z51"]).toFixed(main_.nDecimalNumbers);
        txt_RadionuclideActivity_EXCESS_1.text = parseFloat(Z["Z52"]).toFixed(main_.nDecimalNumbers);
        txt_RadionuclideActivity_KSICH_2.text  = parseFloat(Z["Z48"]).toFixed(main_.nDecimalNumbers);
        txt_RadionuclideActivity_ISICH_2.text  = parseFloat(Z["Z54"]).toFixed(main_.nDecimalNumbers);
        txt_RadionuclideActivity_JSICH_2.text  = parseFloat(Z["Z55"]).toFixed(main_.nDecimalNumbers);
        txt_RadionuclideActivity_RESULT_2.text = parseFloat(Z["Z56"]).toFixed(main_.nDecimalNumbers);
        txt_RadionuclideActivity_STOCK_2.text  = parseFloat(Z["Z57"]).toFixed(main_.nDecimalNumbers);
        txt_RadionuclideActivity_EXCESS_2.text = parseFloat(Z["Z58"]).toFixed(main_.nDecimalNumbers);
        txt_RadionuclideActivity_ISICH_3.text  = parseFloat(Z["Z59"]).toFixed(main_.nDecimalNumbers);
        txt_RadionuclideActivity_JSICH_3.text  = parseFloat(Z["Z55"]).toFixed(main_.nDecimalNumbers);
        txt_RadionuclideActivity_RESULT_3.text = parseFloat(Z["Z61"]).toFixed(main_.nDecimalNumbers);
        txt_RadionuclideActivity_STOCK_3.text  = parseFloat(Z["Z62"]).toFixed(main_.nDecimalNumbers);
        txt_RadionuclideActivity_EXCESS_3.text = parseFloat(Z["Z63"]).toFixed(main_.nDecimalNumbers);

    }

    ////////////////////////////////////////////////////////////////

    /// ПОЛУЧЕНИЕ ОТВЕТА ОТ ЗАПРОСОВ
    /// ( "q1__photoCurrentPerson", "q1__getMainPersonParam1", "q1__getMainPersonParam2" )
    Connections {
        id: conn_personsQuery_1
        target: Query1
        onSignalSendResult: {
            if (!main_.visible) { return }

//            if (owner_name === "q1__insertNewPerson" || owner_name === "q1__updateNewPerson") {
//                if (res) {
//                    model_ext_person_list.updateModel();
//                }
//            }
            if (owner_name === "q1__photoCurrentPerson") {
                console.log(" (!) q1__photoCurrentPerson: ", res, var_res, messageError );
                image_photoPerson.source = "";
                var imagePath;
                if ( var_res == 0 ) {
                    image_photoPerson.emptyPhoto = true;
                    imagePath = "icons/face.svg";
                }
                else {
                    /// sqlquery.cpp выполнил запрос и вытащил фото из БД,
                    /// преобразовав его в побитовый массив (QByteArray),
                    /// после чего передал его в QML в переменной var_res.
                    /// Теперь отправляем этот массив через FileManager в ImageProvider, что бы потом выгрузить изображение в QML
                    FileManager.saveFile(var_res, "", "photo_2", "jpg"); /// сохранение фото на компьютер
                    FileManager.loadByteArrayToImageProvider(var_res, "photo_person");
                    image_photoPerson.emptyPhoto = false;
                    imagePath = "image://images/photo_person";
                }
                image_photoPerson.source = imagePath;

                /// сигнал currentPersonChange_photo вызывается дважды для того чтобы очистить кэш в элементах Image
                /// (при первом вызове параметр imagePath = 0) иначе в объекте ImageProvider не будет вызываться метод requestPixmap
                /// и изображения обновятся
                //currentPersonChange_photo("");
                //currentPersonChange_photo(imagePath);
            }


            //////////////////////////////////////////////////////////////////////////////////////////////
            if (owner_name === "q1__getMainPersonParam1") {
                /// 21 22 25 26 27 31 32 33 37 38
                /// создаем массив длинною в 63 индекса (в нулевом индексе хранится тип выбранного отрезка времени)
                report.clearZ();
                report.setTypeReport(64,1)
                var Z = {};

                //var age =  ((new Date() - new Date(model_person.get(0)["BIRTH_DATE"])) / (24 * 3600 * 365.25 * 1000)) | 0;
                Z["Z0"] = item_InfoDoseOptions_header2.currentOption+1; // model_person.get(0)["SEX"] + "|" +age + "|" + item_InfoDoseOptions_header2.currentOption;
                var data = item_InfoDoseOptions_header2.date_begin.toLocaleString("ru_RU") //.toLocaleDateString("ru_RU", "dd.MM.yyyy")
                        //+ "-" + String(item_InfoDoseOptions_header2.date_end.toLocaleDateString("ru_RU", "dd.MM.yyyy"));

                Z["Z1"]  = data;
                Z["Z2"]  = main_.model_person.get(0)["PERSON_NUMBER"];
                //Z["Z3"] = main_.model_person.get(0)["PERSON_NUMBER"]
                Z["Z4"]  = main_.model_person.get(0)["W_SURNAME"]     + " " +
                            main_.model_person.get(0)["W_NAME"]       + " " +
                            main_.model_person.get(0)["W_PATRONYMIC"]
                Z["Z5"]  = main_.model_person.get(0)["STAFF_TYPE"];
                Z["Z8"]  = main_.model_person.get(0)["TLD"];
                Z["Z64"] = new Date().toLocaleString("ru_RU");

                report.setZ(Z);


                if (!res) {
                    console.log("q1__getMainPersonParam1 не выполнился res = ", res);
                    return false;
                }
                if (res) {
                    //console.log(" q1__getMainPersonParam1 ==== ", var_res, " ", var_res["Z21"], var_res["Z22"], var_res["Z25"], var_res["Z26"], var_res["Z27"], var_res["Z31"]);
                    report.setZ(var_res);
                }
            }
            if (owner_name === "q1__getMainPersonParam2") {
                /// 23 24 28 29 30 34 35 36 40 41
                if (res) {
                    console.log(" q1__getMainPersonParam2 ==== ", var_res, " ",var_res["Z23"], var_res["Z24"], var_res["Z28"], var_res["Z29"]);
                    report.setZ(var_res);

                }

            }

            if (owner_name === "q1__getMainPersonParam3") {
                if (res) {
                    report.setZ(var_res);
                    report.calculateZ_AccumulatedDose();
                    report.showZ();
                    report.sendReportToQML();
                }
            }

        }
    }

    /// ПОЛУЧЕНИЕ ОТВЕТА ОТ МОДЕЛИ (model_person)
    Connections {
        target: model_person
        onSignalUpdateDone: {
            if (!main_.visible) { return }

            // if(nameModel=="m__select_person")
            // {
            if (model_person.rowCount() > 0) {
                // информация о работе
                //doznarad_position.text = model_person.get(0)["doznarad_position"]
                txt_organization.text = model_person.get(0)["ORGANIZATION_"]
                if( model_person.get(0)["STAFF_TYPE"]==="Командировачный" )
                { txt_department.text   = model_person.get(0)["DEPARTMENT_OUTER"] }
                else if ( model_person.get(0)["STAFF_TYPE"]==="Персонал АЭС" )
                { txt_department.text   = model_person.get(0)["DEPARTMENT_INNER"] }
                txt_assignement.text  = model_person.get(0)["ASSIGNEMENT"]


                var str = "";

                // персональная информация
                //txt_fio.text        = model_person.get(0)["W_NAME"] + " " + model_person.get(0)["W_SURNAME"] + " " + model_person.get(0)["W_PATRONYMIC"]
                txt_fio.text        = model_person.get(0)["W_SURNAME"] + "\n"
                        + model_person.get(0)["W_NAME"] + " "
                        + model_person.get(0)["W_PATRONYMIC"]
                txt_pn.text         = model_person.get(0)["PERSON_NUMBER"]
                txt_staff_type.text = model_person.get(0)["STAFF_TYPE"]
                txt_tld.text        = model_person.get(0)["ID_TLD"]
                txt_status.text     = model_person.get(0)["STATUS"]

                if( model_person.get(0)["EMERGENCY_DOSE"] === "1" ) {
                    txt_emergency_dose.is = true;
                }
                else if( model_person.get(0)["EMERGENCY_DOSE"] === "0" )
                {
                    txt_emergency_dose.is = false;
                }

                if(model_person.get(0)["DISABLE_RADIATION"] === "1") {
                    nw_disable_radiation.is = true;
                }
                else if( model_person.get(0)["DISABLE_RADIATION"] === "0" )
                {
                    nw_disable_radiation.is = false;
                }

                //3
                txt_gender.text   = (model_person.get(0)["SEX"] === "M") ? "М" : "Ж"
                str = model_person.get(0)["BIRTH_DATE"]
                txt_birthday.text = str.getDate() + "." + (str.getMonth()+1) + "." + str.getFullYear()
                txt_weight.text   = model_person.get(0)["WEIGHT"]
                txt_height.text   = model_person.get(0)["HEIGHT"]

                //txt_pass_serial.text  = model_person.get(0)["passport_series"]
                txt_pass_number.text  = model_person.get(0)["PASSPORT_NUMBER"]
                txt_pass_whoget.text  = model_person.get(0)["PASSPORT_GIVE"]
                str = model_person.get(0)["PASSPORT_DATE"]
                txt_pass_dateget.text = str.getDate() + "." +(str.getMonth()+1)  + "." + str.getFullYear()

                //                    txt_medical_number.text = model_person.get(0)["POLICY_NUMBER"]
                //                    txt_medical_series.text = model_person.get(0)["SNILS"]

                txt_snils.text = model_person.get(0)["SNILS"]

                txt_mobile_phone.text = model_person.get(0)["MOBILE_TEL"]
                txt_home_address.text = model_person.get(0)["HOME_ADDRESS"]
                txt_home_phone.text = model_person.get(0)["HOME_TEL"]

                txt_work_phone.text = model_person.get(0)["WORK_TEL"]
                txt_work_address.text = model_person.get(0)["WORK_ADDRESS"]
                txt_work_email.text = model_person.get(0)["E_MAIL"]


                ////////////////////////////////////////////////////////////////////////////////
                /// генерируется сигнал о изменении выбранного сотрудника из спсика
//                var sex = (model_person.get(0)["SEX"] === "M") ? "M" : "F"  /// txt_gender.text === "М", тут М на кириллице
//                var age =  ((new Date() - new Date(model_person.get(0)["BIRTH_DATE"])) / (24 * 3600 * 365.25 * 1000)) | 0;
//                var fio_currentPerson = model_person.get(0)["W_SURNAME"] + "\n"
//                        + model_person.get(0)["W_NAME"] + " "
//                        + model_person.get(0)["W_PATRONYMIC"]
//                currentPersonChange(model_person.get(0)["ID_PERSON"], fio_currentPerson, sex, model_person.get(0)["STAFF_TYPE"], age)
                ////////////////////////////////////////////////////////////////////////////////

            }

            //}

        }

    }

    /// ПОЛУЧЕНИЕ МАССИВА Z СО ЗНАЧЕНИЯМИ ДОЗ ОТ (report)
    Connections {
        target: report
        onSignalSendReportToQML: {
            console.log(" (!) Z = ", Z["Z9"] );

            main_.showDose(Z) //
        }
    }



    /// ЗАГОЛОВОК
    Rectangle {
        id: rect_headerPersons
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        //anchors.margins: space_margin
        height: 40
        //color: Material.color(Material.Grey) //"transparent" //"Material.color(Material.Grey, Material.Shade800)"
        color: "#EEEEEE" //"transparent" //Material.color(Material.Grey, Material.Shade800)
        //border.color: "LightGray"
        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 1
            color: "LightGray"
        }
        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            font.pixelSize: 20
            font.bold: true
            color: "#808080" //"white" //"#808080"
            text: qsTr("Информация о выбранном сотруднике")
        }

    }

    /// ПАНЕЛЬ С ФОТО И ФИО СОТРУДНИКА
    Pane {
        id: pane_person
        anchors.left: parent.left
        anchors.top: rect_headerPersons.bottom
        anchors.margins: space_margin

        //        width: (txt_fio.width > 300) ? (frame_listAllPersons.isOpen ? (txt_fio.width + 250) : false) : 550

        width: (txt_fio.width > 300) ? (txt_fio.width + 150) : 450

        //Material.elevation: 4
        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
            border.color: "LightGray"
        }

        padding: 1
        topPadding: 1
        bottomPadding: 1

        height: 160

        Item {
            anchors.fill: parent

            Column {
                anchors.fill: parent
                spacing: 0

                Row {
                    spacing: 20
                    padding: 10
                    leftPadding: 20

                    Rectangle {
                        width:  115 //155 //115
                        height: 130 //180 //130
                        color: "Transparent"

                        //                    border.color: "Silver"
                        //                    color: Material.color(Material.BlueGrey, Material.Shade100)
                        //border.color: "LightGray"
                        //color: "aliceblue"//"whitesmoke"
                        Image {
                            id:image_photoPerson
                            property bool emptyPhoto: true
                            cache: false
                            fillMode: Image.PreserveAspectFit
                            anchors.top: parent.top
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom

                            anchors.topMargin:    (emptyPhoto) ? 0 : 2
                            anchors.leftMargin:   (emptyPhoto) ? 0 : 2
                            anchors.rightMargin:  (emptyPhoto) ? 0 : 2
                            anchors.bottomMargin: (emptyPhoto) ? 0 : 2
                            opacity: (emptyPhoto) ? 0.2 : 1
                            sourceSize.height: 100 //150 //100
                            sourceSize.width:  100 //150
                            source: "icons/face.svg"
                        }
                    }

                    Rectangle {
                        width: 1
                        height: 130
                        color: "LightGray"
                    }

                    Column {
                        spacing: 10
                        padding: 0
                        topPadding: 0
                        Text {
                            id: txt_fio
                            text: "Сотрудник не выбран"
                            font.family: "Tahoma"
                            font.pixelSize: 20
                            font.bold: true
                            //color: "#474747" //Material.color(Material.DeepOrange) //"midnightblue"//"#333333"//"steelblue"
                            color: textData_color //textHeader_color //"#777777"// Material.color(Material.Grey, Material.Shade800) //Material.color(Material.DeepOrange)
                        }
                        Row {
                            id: row1
                            //leftPadding: 10
                            Column {
                                //width: 110
                                spacing: 5
                                rightPadding: 10
                                Text {
                                    text: "Табельный №"
                                    //anchors.right: parent.right
                                    font.pixelSize: 14
                                    color: text_color //"#808080"
                                }
                                Text {
                                    text: "№ ТЛД"
                                    //anchors.right: parent.right
                                    font.pixelSize: 14
                                    color: text_color //"#808080"
                                }
                                Text {
                                    text: "Тип персонала"
                                    //anchors.right: parent.right
                                    font.pixelSize: 14
                                    color: text_color //"#808080"
                                }
                            }
                            Column {
                                width: 220
                                spacing: 5
                                Text {
                                    id: txt_pn
                                    text: ".."
                                    font.pixelSize: 14
                                    font.bold: true
                                    color: textData_color //"darkslategrey"
                                }
                                Text {
                                    id: txt_tld
                                    text: ".."
                                    font.pixelSize: 14
                                    font.bold: true
                                    color: textData_color //"darkslategrey"
                                }
                                Text {
                                    id: txt_staff_type
                                    text: ".."//"Основной персонал АЭС"
                                    font.pixelSize: 14
                                    font.bold: true
                                    color: textData_color// "darkslategrey"
                                }
                            }


                        }
                    }

                }
            }

            Rectangle {
                visible: false
                anchors.right: parent.right
                anchors.rightMargin: 50
                anchors.verticalCenter: parent.verticalCenter
                width: 370
                height: 70
                border.color: "#9E9E9E" //"LightGray"
                radius: 4

                Item {
                    anchors.fill: parent
                    anchors.margins: 10

                    Item {
                        id: txt_emergency_dose
                        property bool is: false

                        anchors.left:   parent.left
                        anchors.right:  parent.right
                        anchors.top:    parent.top
                        anchors.bottom: parent.verticalCenter


                        Label {
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Признак получения аварийной дозы"
                            font.pixelSize: 14
                        }
                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 51
                            height: parent.height
                            width: 50
                            color: "Transparent"
                            border.color: (txt_emergency_dose.is) ? "Transparent" : "LightGray"
                            Text {
                                anchors.centerIn: parent
                                text: qsTr("Нет")
                                font.pixelSize: 14
                                opacity: (txt_emergency_dose.is) ? 0.3 : 1.0
                                //font.bold: (txt_emergency_dose.is) ? false : true
                            }
                        }
                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            height: parent.height
                            width: 50
                            color: "Transparent"
                            border.color: (txt_emergency_dose.is) ? "LightGray" : "Transparent"
                            Text {
                                anchors.centerIn: parent
                                text: qsTr("Да")
                                font.pixelSize: 14
                                opacity: (txt_emergency_dose.is) ? 1.0 : 0.3
                                //font.bold: (txt_emergency_dose.is) ? true : false
                            }
                        }
                    }

                    Item {
                        id: nw_disable_radiation
                        property bool is: false

                        anchors.left:   parent.left
                        anchors.right:  parent.right
                        anchors.top:    parent.verticalCenter
                        anchors.bottom: parent.bottom

                        Label {
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Статус запрета с ИИИ"
                            font.pixelSize: 14
                        }
                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 51
                            height: parent.height
                            width: 50
                            color: "Transparent"
                            border.color: (nw_disable_radiation.is) ? "Transparent" : "LightGray"
                            Text {
                                anchors.centerIn: parent
                                text: qsTr("Нет")
                                font.pixelSize: 14
                                opacity: (nw_disable_radiation.is) ? 0.3 : 1.0
                                //font.bold: (txt_emergency_dose.is) ? false : true
                            }
                        }
                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            height: parent.height
                            width: 50
                            color: "Transparent"
                            border.color: (nw_disable_radiation.is) ? "LightGray" : "Transparent"
                            Text {
                                anchors.centerIn: parent
                                text: qsTr("Да")
                                font.pixelSize: 14
                                opacity: (nw_disable_radiation.is) ? 1.0 : 0.3
                                //font.bold: (txt_emergency_dose.is) ? true : false
                            }
                        }
                    }




                }
            }

        }

    }

    /// Кнопка создает файл с отчетом
    Pane {
        id: pane_buttonCreateReport
        property double elevation_: 1.0
        visible: (frame_tabbar.iCurrentButton == 2) ? true : false

        x: 600
        y: 90
        width: 250
        height: 100

        Material.elevation: elevation_

        Rectangle {
            anchors.fill:  parent
            border.width: 1
        }


        MouseArea {
            anchors.fill: parent
            anchors.margins: -10
            hoverEnabled: true
            onEntered:  { pane_buttonCreateReport.animationStart(1.0, 6.0,"elevation_" ) }
            onExited:   { pane_buttonCreateReport.animationStart(6.0, 1.0,"elevation_" ) }
            onPressed:  {  }
            onReleased: {  }
            onClicked:  {
                console.log(" (!) CLICK! ")
                //report.beginCreateReportFile();
                report.beginCreateReport_AccumulatedDose();
            }
        }

        function animationStart (startValue, endValue, properties) {
            animation_1.startValue = startValue;
            animation_1.endValue = endValue;
            animation_1.properties = properties;
            animation_1.stop();
            animation_1.running = true;
        }
        NumberAnimation {
            id: animation_1
            property double startValue
            property double endValue
            target: pane_buttonCreateReport
            //properties: "elevation_"
            //easing.type: Easing.InOutElastic
            from:
            {
                return startValue
            }
            to:
            {
                return endValue
            }
            duration: 200
            running: false
        }



        Label {
            text: qsTr("Создать отчет в виде файла")
            wrapMode: Text.WordWrap
            anchors.centerIn: parent
        }
    }
    /// Линии от кнопки создания файла к tabbar
    Rectangle {
        id: line_pane_buttonCreateReport_1
        visible: (frame_tabbar.iCurrentButton == 2) ? true : false
        anchors.verticalCenter: pane_buttonCreateReport.verticalCenter
        anchors.right: pane_buttonCreateReport.left
        width: 50
        height: 1
        color: "LightGray"
    }
    Rectangle {
        id: line_pane_buttonCreateReport_2
        visible: (frame_tabbar.iCurrentButton == 2) ? true : false
        anchors.right: line_pane_buttonCreateReport_1.left
        anchors.top: line_pane_buttonCreateReport_1.bottom
        anchors.bottom: frame_tabbar.top
        width: 1
        //height: 130
        color: "LightGray"
    }


    /// ВКЛАДКИ С ПОДРОБНЫМИ ДАННЫМИ О СОТРУДНИКЕ
    Frame {
        id: frame_tabbar
        property int iCurrentButton: tabbar_workerinfo.currentIndex
        //visible: frame_listAllPersons.isOpen ? false : true
        anchors.left: parent.left //frame_listAllPersons.right
        anchors.top: pane_person.bottom  //frame_dose_summary.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        //anchors.margins: space_margin
        anchors.topMargin: space_margin
        anchors.leftMargin: space_margin
        anchors.rightMargin: space_margin

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
            property var tabButton_DoseInfo_: tabButton_DoseInfo
            TabButton {
                text: "Информация о работе"
                width: implicitWidth
                //enabled: false
            }
            TabButton {
                text: "Персональная информация"
                width: implicitWidth

            }
            TabButton {
                id: tabButton_DoseInfo
                text: "Информация по дозам"
                width: implicitWidth
                //enabled: false
            }
            TabButton {
                text: "Зоны контроля"
                width: implicitWidth
                enabled: false
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
                    anchors.topMargin: 5
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 60

                    padding: 5
                    //enabled: false
                    background: Rectangle {
                        anchors.fill: parent
                        color: "White"
                        border.color: "transparent"
                        //radius: 7
                    }


                    Row {
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        spacing: 20
                        Column {
                            spacing: 5
                            Label {
                                text: "Организация"
                                color: textData_color
                                font.pixelSize: 15
                            }
                            TextEdit {
                                id: txt_organization
                                font.pixelSize: 15
                                font.bold: true
                                color: textData_color //Material.color(Material.Teal)
                                selectByMouse: true
                                selectionColor: Material.color(Material.Red)
                                text: "-----"
                            }
                        }

                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            height: 30
                            width: 1
                            color: "LightGray"
                        }

                        Column {
                            spacing: 5
                            Label {
                                text: "Подразделение"
                                color: textData_color
                                font.pixelSize: 15
                            }
                            TextEdit {
                                id: txt_department
                                font.bold: true
                                color: textData_color // Material.color(Material.Teal)
                                selectByMouse: true
                                selectionColor: Material.color(Material.Red)
                                text: "-----"
                                font.pixelSize: 15
                            }
                        }

                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            height: 30
                            width: 1
                            color: "LightGray"
                        }

                        Column {
                            spacing: 5
                            Label {
                                text: "Должность"
                                color: textData_color
                                font.pixelSize: 15
                            }
                            TextEdit {
                                id: txt_assignement
                                font.bold: true
                                color: textData_color //Material.color(Material.Teal)
                                selectByMouse: true
                                selectionColor: Material.color(Material.Red)
                                text: "-----"
                                font.pixelSize: 15
                            }
                        }

                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            height: 30
                            width: 1
                            color: "LightGray"
                        }

                        Column {
                            spacing: 5
                            Label {
                                text: "Статус"
                                color: textData_color
                                font.pixelSize: 15
                            }
                            TextEdit {
                                id: txt_status
                                font.bold: true
                                color: textData_color //Material.color(Material.Teal)
                                selectByMouse: true
                                selectionColor: Material.color(Material.Red)
                                text: "-----"
                                font.pixelSize: 15
                            }
                        }

                    }


                }



                Rectangle {
                    id: wtab1_tableheader
                    height: 30
                    anchors.top: wtab1_aboutwork.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    color: "#f0f0f0" //"#adadad" //Material.color(Material.BlueGrey, Material.Shade100)
                    border.color: "LightGray"

                    Label {
                        text: "История работы"
                        anchors.verticalCenter: parent.verticalCenter
                        //anchors.right: parent.right
                        font.pixelSize: 16
                        color: textData_color
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

                        model: model_person

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
                                        color: text_color //"Black"
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
                                            color: text_color
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit {
                                            id: txt_gender
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: textData_color //Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }

                                        Label {
                                            leftPadding: 10
                                            text: "Родился:"
                                            color: text_color
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit  {
                                            id: txt_birthday
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: textData_color // Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }

                                        Label {
                                            leftPadding: 10
                                            text: "Вес:"
                                            color: text_color
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit {
                                            id: txt_weight
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: textData_color //Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }

                                        Label {
                                            leftPadding: 10
                                            text: "Рост:"
                                            color: text_color
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit {
                                            id: txt_height
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: textData_color //Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }
                                    }
                                }
                            }

                            Rectangle {
                                height: wtab2_passport.heightAll
                                width:  480
                                //border.color: "LightGray"
                                Column {
                                    spacing: 5
                                    Label {
                                        text: "Паспортные данные"
                                        verticalAlignment: Text.AlignVCenter
                                        height: 25
                                        font.pixelSize: wtab2_passport.sizeHeader
                                        color: text_color // "Black"
                                        leftPadding: 10
                                        //font.bold: true
                                    }

                                    Rectangle {
                                        height: 1
                                        width: 480
                                        color: "LightGray"
                                    }
                                    Row {
                                        leftPadding: 10
                                        spacing: 5

                                        Label {
                                            text: "Серия:"
                                            color: text_color
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit {
                                            id: txt_pass_serial
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: textData_color //Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }

                                        Label {
                                            text: "Номер:"
                                            color: text_color
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            leftPadding: 10
                                        }
                                        TextEdit {
                                            id: txt_pass_number
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: textData_color //Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }
                                        Column {
                                            Row {
                                                spacing: 5
                                                Label {
                                                    text: "Выдан:"
                                                    color: text_color
                                                    font.pixelSize: wtab2_passport.sizeTxt
                                                    leftPadding: 10
                                                }
                                                TextEdit {
                                                    id: txt_pass_whoget
                                                    font.pixelSize: wtab2_passport.sizeTxt
                                                    font.bold: true
                                                    color: textData_color //Material.color(Material.Teal)
                                                    selectByMouse: true
                                                    selectionColor: Material.color(Material.Red)
                                                }
                                            }

                                            Row {
                                                spacing: 5
                                                Label {
                                                    text: "Дата выдачи:"
                                                    color: text_color
                                                    font.pixelSize: wtab2_passport.sizeTxt
                                                    leftPadding: 10
                                                }
                                                TextEdit {
                                                    id: txt_pass_dateget
                                                    font.pixelSize: wtab2_passport.sizeTxt
                                                    font.bold: true
                                                    color: textData_color // Material.color(Material.Teal)
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
                                        text: "СНИЛС"
                                        verticalAlignment: Text.AlignVCenter
                                        height: 25
                                        font.pixelSize: wtab2_passport.sizeHeader
                                        color: text_color
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
                                            color: text_color
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit {
                                            id: txt_snils
                                            font.pixelSize: 14
                                            font.bold: true
                                            color: textData_color // Material.color(Material.Teal)
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
                                        color: text_color
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
                                                color: text_color
                                                font.pixelSize: wtab2_passport.sizeTxt
                                            }
                                            TextEdit {
                                                id: txt_home_phone
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: textData_color // Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                            }

                                            Label {
                                                text: "Моб. телефон:"
                                                color: text_color
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                leftPadding: 10
                                            }
                                            TextEdit {
                                                id: txt_mobile_phone
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: textData_color // Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                            }
                                        }

                                        Row {
                                            spacing: 5
                                            Label {
                                                text: "Адрес:"
                                                color: text_color
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                leftPadding: 10
                                            }
                                            TextEdit {
                                                id: txt_home_address
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: textData_color // Material.color(Material.Teal)
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
                                        color: text_color
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
                                                color: text_color
                                                font.pixelSize: wtab2_passport.sizeTxt
                                            }
                                            TextEdit {
                                                id: txt_work_phone
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: textData_color //Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                            }

                                            Label {
                                                text: "Эл. почта:"
                                                color: text_color
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                leftPadding: 10
                                            }
                                            TextEdit {
                                                id: txt_work_email
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: textData_color // Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                            }
                                        }

                                        Row {
                                            spacing: 5
                                            Label {
                                                text: "Адрес:"
                                                color: text_color
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                leftPadding: 10
                                            }
                                            TextEdit {
                                                id: txt_work_address
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: textData_color // Material.color(Material.Teal)
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
                clip: true


                Pane {
                    id: wtab3_doze
                    //anchors.fill: parent
                    anchors.top: item_InfoDoseOptions_header2.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
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

                    Rectangle {
                        anchors.fill: parent
                        //anchors.top: parent.top
                        //anchors.left: parent.left
                        //anchors.bottom: parent.bottom
                        //width: 500

                        clip: true


                        /// для прокрутки данных о накопленных дозах
                        Flickable {
                            anchors.fill: parent
                            contentWidth: rect_AccumulatedDOSE.width
                            contentHeight: rect_AccumulatedDOSE.height

                            Item {
                                id: rect_AccumulatedDOSE
                                width: wtab3_doze.width
                                height: flow_DoseData.height + 40

                                /// Список данных, сгруппированных по типам
                                Flow {
                                    id: flow_DoseData
                                    anchors.top: parent.top
                                    anchors.right: parent.right
                                    anchors.left: parent.left
                                    spacing: 10
                                    anchors.topMargin: 10

                                    /// Основные параметры, мЗв
                                    Rectangle {
                                        height: 200
                                        width: 500
                                        color: "transparent"
                                        border.color: "Lightgray"

                                        Text {
                                            id: header_ParamsAD_1
                                            anchors.top: parent.top
                                            anchors.topMargin: 10
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: qsTr("Основные параметры, мЗв")
                                            color: textData_color //"#808080"
                                            font.pixelSize: 14
                                            font.bold: true
                                        }

                                        Column {
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            anchors.top: header_ParamsAD_1.bottom
                                            anchors.bottom: parent.bottom
                                            anchors.topMargin: 10
                                            spacing: 10
                                            padding: 10
                                            leftPadding: 20

                                            Row {
                                                Text {
                                                    text: qsTr("Эффективная доза:  ")
                                                    color: textData_color// "#808080"
                                                    font.pixelSize: 14
                                                }
                                                TextEdit {
                                                    id: txt_mainParams1
                                                    text: qsTr("0")
                                                    color: (text < 50) ? textData_color : "#e85d5d" // <50 - Норма
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                    selectByMouse: true
                                                    selectionColor: Material.color(Material.Red)
                                                }
                                                Text {
                                                    visible: (txt_mainParams1.text < 50) ? false : true
                                                    text: {
                                                        var str = " (!) Превышение ";
                                                        str = str + (txt_mainParams1.text - 50)

                                                        str = " (!) "
                                                        return qsTr(str)
                                                    }
                                                    color: (text < 150) ? textData_color : "#e85d5d" // <150 - Норма
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                }

                                            }
                                            Row {
                                                Text {
                                                    text: qsTr("Эквивалентная доза облучения хрусталика глаза:  ")
                                                    color: textData_color
                                                    font.pixelSize: 14
                                                }
                                                TextEdit {
                                                    id: txt_mainParams2
                                                    text: qsTr("--")
                                                    color: (text < 150) ? textData_color : "#e85d5d" // <150 - Норма
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                    selectByMouse: true
                                                    selectionColor: Material.color(Material.Red)
                                                }
                                                Text {
                                                    visible: (txt_mainParams2.text < 150) ? false : true
                                                    text: {
                                                        var str = " (!) Превышение ";
                                                        str = str + (txt_mainParams2.text - 150)

                                                        str = " (!) "
                                                        return qsTr(str)
                                                    }
                                                    color: (text < 150) ? textData_color : "#e85d5d" // <150 - Норма
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                }
                                            }
                                            Row {
                                                Text {
                                                    text: qsTr("Эквивалентная доза облучения кожи:  ")
                                                    color: textData_color
                                                    font.pixelSize: 14
                                                }
                                                TextEdit {
                                                    id: txt_mainParams3
                                                    text: qsTr("--")
                                                    color: (text < 500) ? textData_color : "#e85d5d" // <500 - Норма
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                    selectByMouse: true
                                                    selectionColor: Material.color(Material.Red)
                                                }
                                                Text {

                                                }
                                                Text {
                                                    visible: (txt_mainParams3.text < 500) ? false : true
                                                    text: {
                                                        var str = " (!) Превышение ";
                                                        str = str + (txt_mainParams3.text - 500)

                                                        str = " (!) "
                                                        return qsTr(str)
                                                    }
                                                    color: (text < 150) ? textData_color : "#e85d5d" // <150 - Норма
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                }
                                            }
                                            Row {
                                                Text {
                                                    text: qsTr("Месячная эквивалентная доза  \nна поверхности нижней части области живота женщин  \nв возрасте до 45 лет:  ")
                                                    color: textData_color
                                                    font.pixelSize: 14
                                                }
                                                TextEdit {
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    id: txt_mainParams4
                                                    text: qsTr("--")
                                                    color: (text < 1) ? textData_color : "#e85d5d" // <1 - Норма
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                    selectByMouse: true
                                                    selectionColor: Material.color(Material.Red)
                                                }
                                                Text {
                                                    visible: (txt_mainParams4.text < 1) ? false : true
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text: {
                                                        var str = " (!) Превышение ";
                                                        str = str + (txt_mainParams4.text - 1)

                                                        str = " (!) "
                                                        return qsTr(str)
                                                    }
                                                    color: (text < 150) ? textData_color : "#e85d5d" // <150 - Норма
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                }
                                            }

                                        }

                                    }
                                    ColumnLayout {
                                        spacing: 5
                                        /// Индивидуальная эффективная доза, мЗв
                                        Rectangle {
                                            id: rect_ParamsAD
                                            Layout.minimumHeight: 150
                                            Layout.minimumWidth: 680
                                            //height: 150
                                            //width: 680 // 500
                                            color: "Transparent"
                                            border.color: "Lightgray"

                                            state: "close"
                                            states: [
                                                State {
                                                    name: "close"
                                                    PropertyChanges {
                                                        target: rect_ParamsAD
                                                        Layout.minimumHeight: 30
                                                        //height: 30
                                                        color: "Lightgray" //"transparent"
                                                    }
                                                    PropertyChanges {
                                                        target: gridL_ParamsAD
                                                        visible: false
                                                    }
                                                    PropertyChanges {
                                                        target: header_ParamsAD_indicator
                                                        text: qsTr("▼") // ▲ ▼
                                                    }
                                                },
                                                State {
                                                    name: "open"
                                                    PropertyChanges {
                                                        target: rect_ParamsAD
                                                        Layout.minimumHeight: 150
                                                        //height: 150
                                                        color: "Transparent"
                                                    }
                                                    PropertyChanges {
                                                        target: gridL_ParamsAD
                                                        visible: true
                                                    }
                                                    PropertyChanges {
                                                        target: header_ParamsAD_indicator
                                                        text: qsTr("▲") // ▲ ▼
                                                    }
                                                }
                                            ]

                                            transitions: [
                                                Transition {
                                                    from: "close"; to: "open"
                                                    SequentialAnimation {
                                                        NumberAnimation {
                                                            target: rect_ParamsAD
                                                            properties: "Layout.minimumHeight" //"height"
                                                            duration: 70
                                                        }
                                                        PauseAnimation { duration: 70 }
                                                        NumberAnimation {
                                                            target: gridL_ParamsAD
                                                            //easing.type: Easing.InExpo
                                                            properties: "visible"
                                                            duration: 70
                                                        }
                                                    }
                                                },
                                                Transition {
                                                    from: "open"; to: "close"
                                                    SequentialAnimation {
                                                        NumberAnimation {
                                                            target: gridL_ParamsAD
                                                            //easing.type: Easing.InExpo
                                                            properties: "visible"
                                                            duration: 70
                                                        }
                                                        PauseAnimation { duration: 50 }
                                                        NumberAnimation {
                                                            target: rect_ParamsAD
                                                            properties: "Layout.minimumHeight" //"height"
                                                            duration: 100
                                                        }
                                                        PauseAnimation { duration: 70 }
                                                        ColorAnimation {
                                                            target: rect_ParamsAD
                                                            duration: 10
                                                        }
                                                    }
                                                }
                                            ]


                                            Rectangle {
                                                id: header_ParamsAD
                                                anchors.top: parent.top
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                height: 30
                                                border.color: "LightGray"
                                                Text {
                                                    anchors.centerIn: parent
    //                                                anchors.top: parent.top
    //                                                anchors.topMargin: 10
    //                                                anchors.horizontalCenter: parent.horizontalCenter
                                                    text: qsTr("Индивидуальная эффективная доза, мЗв")
                                                    color: text_color
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                }
                                                Text {
                                                    id: header_ParamsAD_indicator
                                                    anchors.right: parent.right
                                                    anchors.rightMargin: 20
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text: qsTr("▼") // ▲
                                                    color: textData_color
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                }
                                                MouseArea {
                                                    anchors.fill: parent

                                                    propagateComposedEvents: true
                                                    hoverEnabled: true

                                                    cursorShape: Qt.PointingHandCursor;

                                                    onEntered:  { if ( rect_ParamsAD.state == "close") { rect_ParamsAD.height = 32 } }
                                                    onExited:   { if ( rect_ParamsAD.state == "close") { rect_ParamsAD.height = 30 } }
                                                    onPressed:  {}
                                                    onReleased: {}
                                                    onClicked:  { rect_ParamsAD.state = (rect_ParamsAD.state == "open") ? "close" : "open"  }

                                                }
                                            }





                                            GridLayout {
                                                id: gridL_ParamsAD
                                                //visible: false
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                anchors.top: header_ParamsAD.bottom
                                                anchors.bottom: parent.bottom
                                                anchors.topMargin: 10
                                                anchors.bottomMargin: 10


                                                columns: 4
                                                rows: 3

                                                rowSpacing: 0
                                                columnSpacing: 0

                                                /// Рамки
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 1
                                                    Layout.columnSpan: 2

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 3
                                                    Layout.columnSpan: 4

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }
                                                /// заголовки ТЛД и ЭПД
                                                Item {
                                                    Layout.row: 1
                                                    Layout.column: 1
                                                    Layout.columnSpan: 2

                                                    Layout.preferredWidth: 250
                                                    //Layout.fillWidth: true
                                                    Layout.preferredHeight: 30 //h_TLD_data + 10
                                                    //color: "transparent"
                                                    //border.color: "green"

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "ТЛД"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 1
                                                    Layout.column: 3
                                                    Layout.columnSpan: 4

                                                    Layout.preferredWidth: 250
                                                    //Layout.maximumWidth: 205
                                                    //Layout.fillWidth: true
                                                    Layout.preferredHeight: 30 //h_EPD_data + 10
                                                    //color: "transparent"
                                                    //border.color: "green"

                                                    Text {
                                                        anchors.centerIn: parent
                                                        //                                                    anchors.left: parent.left
                                                        //                                                    anchors.leftMargin: 10
                                                        //                                                    anchors.verticalCenter: parent.verticalCenter
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "ЭПД"
                                                    }
                                                }

                                                /// заголовки ᵞ n  ᵞ n ( 2 строка 1,2,3,4 столбцы )
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 1

                                                    Layout.preferredWidth: 125
                                                    //Layout.fillWidth: true
                                                    Layout.preferredHeight: 30 //h_EPD_data + 10
                                                    //color: "transparent"
                                                    //border.color: "green"

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "ᵞ"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 2

                                                    Layout.preferredWidth: 125
                                                    //Layout.fillWidth: true
                                                    Layout.preferredHeight: 30 //h_EPD_data + 10
                                                    //color: "transparent"
                                                    //border.color: "green"

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "n"
                                                    }
                                                }

                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 3

                                                    Layout.preferredWidth: 125
                                                    //Layout.fillWidth: true
                                                    Layout.preferredHeight: 30 //h_EPD_data + 10
                                                    //color: "transparent"
                                                    //border.color: "green"

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "ᵞ"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 4

                                                    Layout.preferredWidth: 125
                                                    //Layout.fillWidth: true
                                                    Layout.preferredHeight: 30 //h_EPD_data + 10
                                                    //color: "transparent"
                                                    //border.color: "green"

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "n"
                                                    }
                                                }

                                                /// значения из БД ( 3 строка 1,2,3,4 столбцы )
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 1

                                                    Layout.preferredWidth: 125
                                                    Layout.preferredHeight: 30
                                                    //color: "transparent"
                                                    //border.color: "green"

                                                    Text {
                                                        id: txt_TLD_Y_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 2

                                                    Layout.preferredWidth: 125
                                                    //Layout.fillWidth: true
                                                    Layout.preferredHeight: 30 //h_EPD_data + 10
                                                    //color: "transparent"
                                                    //border.color: "green"

                                                    Text {
                                                        id: txt_TLD_n_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }
                                                }

                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 3

                                                    Layout.preferredWidth: 125
                                                    //Layout.fillWidth: true
                                                    Layout.preferredHeight: 30 //h_EPD_data + 10
                                                    //color: "transparent"
                                                    //border.color: "green"

                                                    Text {
                                                        id: txt_EPD_Y_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 4

                                                    Layout.preferredWidth: 125
                                                    //Layout.fillWidth: true
                                                    Layout.preferredHeight: 30 //h_EPD_data + 10
                                                    //color: "transparent"
                                                    //border.color: "green"

                                                    Text {
                                                        id: txt_EPD_n_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }
                                                }


                                            }


                                        }
                                        /// Эквивалентная доза, мЗв
                                        Rectangle {
                                            id: rect_EqDose
                                            Layout.minimumHeight: 200
                                            Layout.minimumWidth: 680
//                                            height: 200
//                                            width: 680 //600
                                            //anchors.left: parent.left
                                            //anchors.right: parent.right

                                            color: "Transparent"
                                            border.color: "Lightgray"

                                            state: "close"
                                            states: [
                                                State {
                                                    name: "close"
                                                    PropertyChanges {
                                                        target: rect_EqDose
                                                        Layout.minimumHeight: 30
                                                        //height: 30
                                                         color: "Lightgray"
                                                    }
                                                    PropertyChanges {
                                                        target: gridL_EqDose
                                                        visible: false
                                                    }
                                                    PropertyChanges {
                                                        target: header_EqDose_indicator
                                                        text: qsTr("▼") // ▲ ▼
                                                    }
                                                },
                                                State {
                                                    name: "open"
                                                    PropertyChanges {
                                                        target: rect_EqDose
                                                        Layout.minimumHeight: 200
                                                        //height: 200
                                                        color: "Transparent"
                                                    }
                                                    PropertyChanges {
                                                        target: gridL_EqDose
                                                        visible: true
                                                    }
                                                    PropertyChanges {
                                                        target: header_EqDose_indicator
                                                        text: qsTr("▲") // ▲ ▼
                                                    }
                                                }
                                            ]


                                            Rectangle {
                                                id: header_EqDose
                                                anchors.top: parent.top
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                height: 30
                                                border.color: "LightGray"
                                                Text {
                                                    anchors.centerIn: parent
                                                    text: qsTr("Эквивалентная доза, мЗв")
                                                    color: text_color
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                }
                                                Text {
                                                    id: header_EqDose_indicator
                                                    anchors.right: parent.right
                                                    anchors.rightMargin: 20
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text: qsTr("▼") // ▲
                                                    color: textData_color
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                }
                                                MouseArea {
                                                    anchors.fill: parent

                                                    propagateComposedEvents: true
                                                    hoverEnabled: true

                                                    cursorShape: Qt.PointingHandCursor;

                                                    onEntered:  { if ( rect_EqDose.state == "close") { rect_EqDose.height = 32 } }
                                                    onExited:   { if ( rect_EqDose.state == "close") { rect_EqDose.height = 30 } }
                                                    onPressed:  {}
                                                    onReleased: {}
                                                    onClicked:  { rect_EqDose.state = (rect_EqDose.state == "open") ? "close" : "open"  }

                                                }
                                            }



                                            GridLayout {
                                                id: gridL_EqDose
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                anchors.top: header_EqDose.bottom
                                                anchors.topMargin: 10

                                                columns: 7
                                                rows: 6

                                                rowSpacing: 0
                                                columnSpacing: 0

                                                /// Рамки
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 1
                                                    //Layout.columnSpan: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }

                                                Item {
                                                    transformOrigin: Item.Center
                                                    Layout.row: 2
                                                    Layout.column: 2
                                                    Layout.columnSpan: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 5
                                                    Layout.columnSpan: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }


                                                /// заголовки Части тела, ТЛД и ЭПД
                                                Item {
                                                    Layout.row: 1
                                                    //Layout.rowSpan: 3
                                                    Layout.column: 1
                                                    //border.width: 1

                                                    Layout.minimumWidth: 120
                                                    //Layout.preferredWidth: 120
                                                    Layout.fillWidth: true
                                                    //Layout.preferredHeight: 60
                                                    Layout.fillHeight: true

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        font.bold: true
                                                        text: "Части тела"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 1
                                                    Layout.column: 2
                                                    Layout.columnSpan: 3
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 240
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        font.bold: true
                                                        text: "ТЛД"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 1
                                                    Layout.column: 5 //5
                                                    Layout.columnSpan: 3
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 240
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        font.bold: true
                                                        text: "ЭПД"
                                                    }
                                                }


                                                /// Подзаголовки  y n b   y n b  (ᵞ n ᵝ)  ᶯ
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 2
                                                    //border.width: 1

                                                    Layout.minimumWidth: 80
                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        //id: txt_EqDose_TLD_y
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 16
                                                        text: "ᵞ"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 3
                                                    //border.width: 1

                                                    Layout.minimumWidth: 80
                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        //id: txt_EqDose_TLD_n
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "n"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 4
                                                    //border.width: 1

                                                    Layout.minimumWidth: 80
                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        //id: txt_EqDose_TLD_b //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 16
                                                        text: "ᵝ"
                                                    }

                                                }

                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 5
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.minimumWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        //id: txt_EqDose_EPD_y
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 16
                                                        text: "ᵞ"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 6
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.minimumWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        //id: txt_EqDose_EPD_n
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "n"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 7
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.minimumWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        //id: txt_EqDose_EPD_b
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 16
                                                        text: "ᵝ"
                                                    }

                                                }


                                                /// названия частей тела
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 1
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 120
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "Хрусталик глаза"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 5
                                                    Layout.column: 1
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 120
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "Кожа"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 6
                                                    Layout.column: 1
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 120
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "Низ живота"
                                                    }

                                                }


                                                /// значения

                                                /// ТЛД для 4ой строки
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 2
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_TLD_y_1
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 3
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_TLD_n_1
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 4
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_TLD_b_1 //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                /// ТЛД для 5ой строки
                                                Item {
                                                    Layout.row: 5
                                                    Layout.column: 2
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_TLD_y_2 //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 5
                                                    Layout.column: 3
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_TLD_n_2 //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 5
                                                    Layout.column: 4
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_TLD_b_2 //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                /// ТЛД для 6ой строки
                                                Item {
                                                    Layout.row: 6
                                                    Layout.column: 2
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_TLD_y_3 //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 6
                                                    Layout.column: 3
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_TLD_n_3 //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 6
                                                    Layout.column: 4
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_TLD_b_3 //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }

                                                /// ЭПД для 4ой строки
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 5
                                                    ////border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_EPD_y_1 //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 6
                                                    ////border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_EPD_n_1 //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 7
                                                    ////border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_EPD_b_1 //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                /// ЭПД для 5ой строки
                                                Item {
                                                    Layout.row: 5
                                                    Layout.column: 5
                                                    ////border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_EPD_y_2 //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 5
                                                    Layout.column: 6
                                                    ////border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_EPD_n_2 //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 5
                                                    Layout.column: 7
                                                    ////border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_EPD_b_2 //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                /// ЭПД для 6ой строки
                                                Item {
                                                    Layout.row: 6
                                                    Layout.column: 5
                                                    ////border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_EPD_y_3 //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 6
                                                    Layout.column: 6
                                                    ////border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_EPD_n_3 //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 6
                                                    Layout.column: 7
                                                    ////border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_EqDose_EPD_b_3 //txt_EPD_n_b_data
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }


                                            }

                                        }
                                        /// Эффективная доза внутреннего облучения, мЗв
                                        Rectangle {
                                            id: rect_ParamsEffIntDose
                                            Layout.minimumHeight: 200
                                            Layout.minimumWidth: 680
//                                            height: 200
//                                            width: 680 //600
                                            //    anchors.left: parent.left
                                            //    anchors.right: parent.right

                                            color: "transparent"
                                            border.color: "Lightgray"

                                            state: "close"
                                            states: [
                                                State {
                                                    name: "close"
                                                    PropertyChanges {
                                                        target: rect_ParamsEffIntDose
                                                        Layout.minimumHeight: 30
//                                                        height: 30
                                                         color: "Lightgray"
                                                    }
                                                    PropertyChanges {
                                                        target: gridL_aramsEffIntDose
                                                        visible: false
                                                    }
                                                    PropertyChanges {
                                                        target: header_ParamsEffIntDose_indicator
                                                        text: qsTr("▼") // ▲ ▼
                                                    }
                                                },
                                                State {
                                                    name: "open"
                                                    PropertyChanges {
                                                        target: rect_ParamsEffIntDose
                                                        Layout.minimumHeight: 200
//                                                        height: 200
                                                        color: "Transparent"
                                                    }
                                                    PropertyChanges {
                                                        target: gridL_aramsEffIntDose
                                                        visible: true
                                                    }
                                                    PropertyChanges {
                                                        target: header_ParamsEffIntDose_indicator
                                                        text: qsTr("▲") // ▲ ▼
                                                    }
                                                }
                                            ]

                                            Rectangle {
                                                id: header_ParamsEffIntDose
                                                anchors.top: parent.top
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                height: 30
                                                border.color: "LightGray"
                                                Text {
                                                    id: header_ParamsEffIntDose_txt
                                                    anchors.centerIn: parent
                                                    text: qsTr("Эффективная доза внутреннего облучения, мЗв")
                                                    color: textData_color
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                }
                                                Text {
                                                    id: header_ParamsEffIntDose_indicator
                                                    anchors.right: parent.right
                                                    anchors.rightMargin: 20
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text: qsTr("▼") // ▲
                                                    color: textData_color
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                }
                                                MouseArea {
                                                    anchors.fill: parent

                                                    propagateComposedEvents: true
                                                    hoverEnabled: true

                                                    cursorShape: Qt.PointingHandCursor;

//                                                    onEntered:  { if ( rect_ParamsEffIntDose.state == "close") { header_ParamsEffIntDose_txt.color = "#5e5e5e"      } }
//                                                    onExited:   { if ( rect_ParamsEffIntDose.state == "close") { header_ParamsEffIntDose_txt.color = textData_color } }
                                                    onEntered:  { if ( rect_ParamsEffIntDose.state == "close") { rect_ParamsEffIntDose.height = 32 } }
                                                    onExited:   { if ( rect_ParamsEffIntDose.state == "close") { rect_ParamsEffIntDose.height = 30 } }
                                                    onPressed:  {}
                                                    onReleased: {}
                                                    onClicked:  { rect_ParamsEffIntDose.state = (rect_ParamsEffIntDose.state == "open") ? "close" : "open"  }

                                                }
                                            }




                                            GridLayout {
                                                id: gridL_aramsEffIntDose
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                anchors.top: header_ParamsEffIntDose.bottom
                                                anchors.topMargin: 10

                                                columns: 5
                                                rows: 4

                                                rowSpacing: 0
                                                columnSpacing: 0

                                                /// Рамки
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 1
                                                    //Layout.columnSpan: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 2
                                                    //Layout.columnSpan: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 3
                                                    //Layout.columnSpan: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 4
                                                    //Layout.columnSpan: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 5
                                                    //Layout.columnSpan: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }

                                                /// заголовки Орган, КСИЧ, ИСИЧ, ЙСИЧ, Итог
                                                Item {
                                                    Layout.row: 1
                                                    //Layout.rowSpan: 3
                                                    Layout.column: 1

                                                    Layout.minimumWidth: 180
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30
                                                    //Layout.preferredWidth: 120

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        font.bold: true
                                                        text: "Орган"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 1
                                                    //Layout.rowSpan: 3
                                                    Layout.column: 2
                                                    //border.color: "LightGray"

                                                    Layout.minimumWidth: 105
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30
                                                    //Layout.preferredWidth: 120
                                                    //Layout.preferredHeight: 60

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        font.bold: true
                                                        text: "КСИЧ"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 1
                                                    //Layout.rowSpan: 3
                                                    Layout.column: 3

                                                    Layout.minimumWidth: 105
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30
                                                    //Layout.preferredWidth: 120

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        font.bold: true
                                                        text: "ИСИЧ"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 1
                                                    //Layout.rowSpan: 3
                                                    Layout.column: 4

                                                    Layout.minimumWidth: 105
                                                    Layout.fillWidth: true
                                                    Layout.fillHeight: true
                                                    //Layout.preferredWidth: 120
                                                    //Layout.preferredHeight: 60

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        font.bold: true
                                                        text: "ЙСИЧ"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 1
                                                    //Layout.rowSpan: 3
                                                    Layout.column: 5

                                                    Layout.minimumWidth: 105
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30
                                                    //Layout.preferredWidth: 120

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        font.bold: true
                                                        text: "Итог"
                                                    }
                                                }

                                                /// названия органов
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 1

                                                    //Layout.preferredWidth: 120
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "Легкие"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 1

                                                    //Layout.preferredWidth: 120
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "Щитовидная железа"
                                                    }

                                                }


                                                /// значения

                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 2
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_ParamsEffIntDose_KSICH ///Z43
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 3
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_ParamsEffIntDose_ISICH ///Z44
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 5
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_ParamsEffIntDose_RESULT_1 ///Z45
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }


                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 4
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_ParamsEffIntDose_JSICH //Z46
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 5
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_ParamsEffIntDose_RESULT_2
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }

                                            }

                                        }
                                        /// Активность по радионуклидам, Бк
                                        Rectangle {
                                            id: rect_RadionuclideActivity
                                            Layout.minimumHeight: 200
                                            Layout.minimumWidth: 680
//                                            height: 200
//                                            width: 680
                                            //    anchors.left: parent.left
                                            //    anchors.right: parent.right

                                            color: "transparent"
                                            border.color: "Lightgray"


                                            state: "close"
                                            states: [
                                                State {
                                                    name: "close"
                                                    PropertyChanges {
                                                        target: rect_RadionuclideActivity
                                                        Layout.minimumHeight: 30
//                                                        height: 30
                                                         color: "Lightgray"
                                                    }
                                                    PropertyChanges {
                                                        target: grid_RadionuclideActivity
                                                        visible: false
                                                    }
                                                    PropertyChanges {
                                                        target: header_RadionuclideActivity_indicator
                                                        text: qsTr("▼") // ▲ ▼
                                                    }
                                                },
                                                State {
                                                    name: "open"
                                                    PropertyChanges {
                                                        target: rect_RadionuclideActivity
                                                        Layout.minimumHeight: 200
//                                                        height: 200
                                                        color: "Transparent"
                                                    }
                                                    PropertyChanges {
                                                        target: grid_RadionuclideActivity
                                                        visible: true
                                                    }
                                                    PropertyChanges {
                                                        target: header_RadionuclideActivity_indicator
                                                        text: qsTr("▲") // ▲ ▼
                                                    }
                                                }
                                            ]


                                            Rectangle {
                                                id: header_RadionuclideActivity
                                                anchors.top: parent.top
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                height: 30
                                                border.color: "LightGray"
                                                Text {
                                                    anchors.centerIn: parent
                                                    text: qsTr("Активность по радионуклидам, Бк")
                                                    color: textData_color
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                }
                                                Text {
                                                    id: header_RadionuclideActivity_indicator
                                                    anchors.right: parent.right
                                                    anchors.rightMargin: 20
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text: qsTr("▼") // ▲
                                                    color: textData_color
                                                    font.pixelSize: 14
                                                    font.bold: true
                                                }
                                                MouseArea {
                                                    anchors.fill: parent

                                                    propagateComposedEvents: true
                                                    hoverEnabled: true

                                                    cursorShape: Qt.PointingHandCursor;

                                                    onEntered:  { if ( rect_RadionuclideActivity.state == "close") { rect_RadionuclideActivity.height = 32 } }
                                                    onExited:   { if ( rect_RadionuclideActivity.state == "close") { rect_RadionuclideActivity.height = 30 } }
                                                    onPressed:  {}
                                                    onReleased: {}
                                                    onClicked:  { rect_RadionuclideActivity.state = (rect_RadionuclideActivity.state == "open") ? "close" : "open"  }

                                                }
                                            }

                                            GridLayout {
                                                id: grid_RadionuclideActivity
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                anchors.top: header_RadionuclideActivity.bottom
                                                anchors.topMargin: 10

                                                columns: 8
                                                rows: 5

                                                rowSpacing: 0
                                                columnSpacing: 0

                                                /// Рамки
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 1
                                                    //Layout.columnSpan: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 2
                                                    //Layout.columnSpan: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 3
                                                    //Layout.columnSpan: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 4
                                                    //Layout.columnSpan: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 5
                                                    //Layout.columnSpan: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 6
                                                    //Layout.columnSpan: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 7
                                                    //Layout.columnSpan: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 2
                                                    Layout.column: 8
                                                    //Layout.columnSpan: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 1
                                                    Layout.maximumHeight: 1

                                                    Rectangle {
                                                        height: 1

                                                        anchors.left: parent.left
                                                        anchors.right: parent.right
                                                        anchors.margins: 10
                                                        color: textData_color
                                                        opacity: 0.4
                                                    }
                                                }


                                                /// заголовки Нуклид, КСИЧ, ИСИЧ, ЙСИЧ, Итог, Порог, Запас, Превышение
                                                Item {
                                                    Layout.row: 1
                                                    //Layout.rowSpan: 3
                                                    Layout.column: 1

                                                    Layout.minimumWidth: 200
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30
                                                    //Layout.preferredWidth: 120

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        font.bold: true
                                                        text: "Нуклид"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 1
                                                    Layout.column: 2

                                                    Layout.minimumWidth: 60
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        font.bold: true
                                                        text: "КСИЧ"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 1
                                                    Layout.column: 3

                                                    Layout.minimumWidth: 60
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        font.bold: true
                                                        text: "ИСИЧ"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 1
                                                    Layout.column: 4

                                                    Layout.minimumWidth: 60
                                                    Layout.fillWidth: true
                                                    Layout.fillHeight: true

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        font.bold: true
                                                        text: "ЙСИЧ"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 1
                                                    Layout.column: 5

                                                    Layout.minimumWidth: 60
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        font.bold: true
                                                        text: "Итог"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 1
                                                    Layout.column: 6

                                                    Layout.minimumWidth: 60
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        font.bold: true
                                                        text: "Порог"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 1
                                                    Layout.column: 7

                                                    Layout.minimumWidth: 60
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        font.bold: true
                                                        text: "Запас"
                                                    }
                                                }
                                                Item {
                                                    Layout.row: 1
                                                    Layout.column: 8
                                                    Layout.minimumWidth: 120
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        font.bold: true
                                                        text: "Превышение"
                                                    }
                                                }


                                                /// названия нуклидов
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 1

                                                    //Layout.preferredWidth: 120
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Row {
                                                        anchors.centerIn: parent
                                                        Text {
                                                            anchors.top: parent.top
                                                            color: textData_color
                                                            font.pixelSize: 10
                                                            text: "60 "
                                                        }
                                                        Text {
                                                            //anchors.centerIn: parent
                                                            color: textData_color
                                                            font.pixelSize: 14
                                                            text: "Co"
                                                        }
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 1

                                                    //Layout.preferredWidth: 120
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Row {
                                                        anchors.centerIn: parent
                                                        Text {
                                                            //anchors.centerIn: parent
                                                            color: textData_color
                                                            font.pixelSize: 14
                                                            text: "Все радионуклиды с "
                                                        }
                                                        Text {
                                                            anchors.top: parent.top
                                                            color: textData_color
                                                            font.pixelSize: 10
                                                            text: "60 "
                                                        }
                                                        Text {
                                                            //anchors.centerIn: parent
                                                            color: textData_color
                                                            font.pixelSize: 14
                                                            text: "Co"
                                                        }
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 5
                                                    Layout.column: 1

                                                    //Layout.preferredWidth: 120
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Row {
                                                        anchors.centerIn: parent
                                                        Text {
                                                            //anchors.centerIn: parent
                                                            color: textData_color
                                                            font.pixelSize: 14
                                                            text: "Все радионуклиды без "
                                                        }
                                                        Text {
                                                            anchors.top: parent.top
                                                            color: textData_color
                                                            font.pixelSize: 10
                                                            text: "60 "
                                                        }
                                                        Text {
                                                            //anchors.centerIn: parent
                                                            color: textData_color
                                                            font.pixelSize: 14
                                                            text: "Co"
                                                        }
                                                    }

                                                }


                                                /// значения

                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 2
                                                    //border.width: 1

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_RadionuclideActivity_KSICH_1  ///Z48
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 3
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_RadionuclideActivity_ISICH_1 ///Z49
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 5
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_RadionuclideActivity_RESULT_1 ///Z50
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 6
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "300"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 7
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_RadionuclideActivity_STOCK_1 ///Z51
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 3
                                                    Layout.column: 8
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_RadionuclideActivity_EXCESS_1 ///Z52
                                                        anchors.centerIn: parent
                                                        color: (text < 300) ? textData_color : "#e85d5d"
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }

                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 2
                                                    //border.width: 1

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_RadionuclideActivity_KSICH_2
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_RadionuclideActivity_ISICH_2
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 4

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_RadionuclideActivity_JSICH_2
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 5

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_RadionuclideActivity_RESULT_2
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 6
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "400"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 7
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_RadionuclideActivity_STOCK_2
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 4
                                                    Layout.column: 8
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_RadionuclideActivity_EXCESS_2
                                                        anchors.centerIn: parent
                                                        color: (text < 300) ? textData_color : "#e85d5d"
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }


                                                Item {
                                                    Layout.row: 5
                                                    Layout.column: 3

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_RadionuclideActivity_ISICH_3
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 5
                                                    Layout.column: 4

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_RadionuclideActivity_JSICH_3
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 5
                                                    Layout.column: 5

                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_RadionuclideActivity_RESULT_3
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 5
                                                    Layout.column: 6
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "450"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 5
                                                    Layout.column: 7
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_RadionuclideActivity_STOCK_3
                                                        anchors.centerIn: parent
                                                        color: textData_color
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }
                                                Item {
                                                    Layout.row: 5
                                                    Layout.column: 8
                                                    //border.width: 1

                                                    //Layout.preferredWidth: 80
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 30

                                                    Text {
                                                        id: txt_RadionuclideActivity_EXCESS_3
                                                        anchors.centerIn: parent
                                                        color: (text < 300) ? textData_color : "#e85d5d"
                                                        font.pixelSize: 14
                                                        text: "-"
                                                    }

                                                }



                                            }

                                        }


                                    }

                                }

                            }

                        }

                    }



                }

                /// Панель вкладок с опциями v4 (расположение в заголовке)
                Item {
                    id: item_InfoDoseOptions_header2

                    property int currentOption: 0
                    /// .toLocaleDateString("ru_RU", "dd.MM.yyyy")
                    property var date_begin: { var now = new Date; return new Date(now.getFullYear(), 0 , 1); }
                    property var date_end:   { var now = new Date; return now; }

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 30




                    /// текст-заголовок с описанием выбранной опции
                    Rectangle {
                        id: item_chose_InfoDoseOptions_header_2
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        //anchors.leftMargin: 30
                        width: 300
                        color: "#EEEEEE"

                        Rectangle {
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            width: 1
                            color: "LightGray"
                        }
                        Rectangle {
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 4
                            width: 30
                            color: "Transparent" //"black"

                            Canvas {
                                anchors.fill: parent

                                onPaint: {
                                    var context = getContext("2d");

                                    context.strokeStyle  = "LightGray"
                                    context.fillStyle = "Transparent" // "#FFCC00";

                                    context.beginPath();
                                    context.moveTo(30, 0);
                                    context.lineTo(15, 15);
                                    context.lineTo(30, 30);
                                    context.closePath();

                                    context.fill();
                                    context.stroke();
                                }
                            }
                        }


                        Text {
                            id: txt_chose_InfoDoseOptions_header_2
                            anchors.centerIn: parent
                            font.pixelSize: 16
                            font.bold: true
                            color: textData_color
                            text: {
                                var txt = "";
                                if (item_InfoDoseOptions_header2.currentOption == 0)
                                {
                                    txt = "За последние "
                                            + Math.floor((item_InfoDoseOptions_header2.date_end - item_InfoDoseOptions_header2.date_begin) / 1000 / 3600 / 24)
                                            + " дней";
                                    return qsTr(txt);
                                }
                                if (item_InfoDoseOptions_header2.currentOption == 1)
                                {
                                    //txt = "За последние " + Math.floor((item_InfoDoseOptions_header2.date_end - item_InfoDoseOptions_header2.date_begin) / 1000 / 3600 / 24) + " дней"

                                    txt = "За последний год ("
                                            + Math.floor((item_InfoDoseOptions_header2.date_end - item_InfoDoseOptions_header2.date_begin) / 1000 / 3600 / 24)
                                            + " дней)";
                                    return qsTr(txt);
                                }
                                if (item_InfoDoseOptions_header2.currentOption == 2)
                                {
                                    txt = "C " + item_InfoDoseOptions_header2.date_begin.toLocaleDateString("ru_RU", "dd.MM.yyyy")
                                            + " по " + item_InfoDoseOptions_header2.date_end.toLocaleDateString("ru_RU", "dd.MM.yyyy");
                                    return qsTr(txt);
                                }
                                //qsTr("За последние 289 дней")
                            }
                        }
                    }

                    RowLayout {
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: item_chose_InfoDoseOptions_header_2.right
                        anchors.right: parent.right
                        spacing: 0

                        Rectangle {
                            id: button_0_InfoDoseOptions_header_2
                            Layout.fillHeight: true
                            Layout.fillWidth:  true
                            color: "#f7f7f7" //"Transparent"
                            border.color: "LightGray"
                            border.width: 0
                            Rectangle {
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                width: 1
                                color: "LightGray"
                            }
                            Text {
                                anchors.centerIn: parent
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 15
                                color: textData_color
                                wrapMode: Text.WordWrap
                                text: qsTr("С начала года по сегодня")
                            }
                            MouseArea {
                                anchors.fill: parent

                                propagateComposedEvents: true
                                hoverEnabled: true

                                cursorShape: Qt.PointingHandCursor;
                                //acceptedButtons: Qt.NoButton

                                onEntered: {
                                    button_0_InfoDoseOptions_header_2.color = "LightGray";
                                }
                                onExited: {
                                    button_0_InfoDoseOptions_header_2.color = "#f7f7f7"; //"Transparent";
                                }
                                onPressed:  {
                                    item_InfoDoseOptions_header2.currentOption = 0;
                                    var now = new Date;
                                    item_InfoDoseOptions_header2.date_begin = new Date(now.getFullYear(), 0 , 1);
                                    item_InfoDoseOptions_header2.date_end   = now;
                                    main_.updatePersonParameters( main_.id_currentPerson,
                                                                 item_InfoDoseOptions_header2.date_begin.toLocaleDateString("ru_RU", "dd.MM.yyyy"),
                                                                 item_InfoDoseOptions_header2.date_end.toLocaleDateString("ru_RU", "dd.MM.yyyy") )
                                }
                                onReleased: {}
                                onClicked:  {}

                            }
                        }

                        Rectangle {
                            id: button_1_InfoDoseOptions_header_2
                            Layout.fillHeight: true
                            Layout.fillWidth:  true
                            color: "#f7f7f7" //"Transparent"
                            border.color: "LightGray"
                            border.width: 0
                            Rectangle {
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                width: 1
                                color: "LightGray"
                            }
                            Text {
                                anchors.centerIn: parent
                                width: parent.width
                                font.pixelSize: 15
                                //font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                color: textData_color
                                wrapMode: Text.WordWrap
                                text: qsTr("За последний год")
                            }
                            MouseArea {
                                anchors.fill: parent

                                propagateComposedEvents: true
                                hoverEnabled: true

                                cursorShape: Qt.PointingHandCursor;
                                //acceptedButtons: Qt.NoButton

                                onEntered: {
                                    button_1_InfoDoseOptions_header_2.color = "LightGray";
                                }
                                onExited: {
                                    button_1_InfoDoseOptions_header_2.color = "#f7f7f7"; //"Transparent";
                                }
                                onPressed:  {
                                    item_InfoDoseOptions_header2.currentOption = 1;
                                    var now = new Date;
                                    item_InfoDoseOptions_header2.date_begin = new Date((now.getFullYear()-1),now.getMonth(),now.getDate());
                                    item_InfoDoseOptions_header2.date_end   = now;
                                    main_.updatePersonParameters( main_.id_currentPerson,
                                                                 item_InfoDoseOptions_header2.date_begin.toLocaleDateString("ru_RU", "dd.MM.yyyy"),
                                                                 item_InfoDoseOptions_header2.date_end.toLocaleDateString("ru_RU", "dd.MM.yyyy") )
                                }
                                onReleased: {}
                                onClicked:  {}

                            }
                        }

                        Rectangle {
                            id: button_2_InfoDoseOptions_header_2
                            property date date_begin: calendar_DATE_BEGIN_InfoDoseOptions_header2.date_val
                            property date date_end: calendar_DATE_END_InfoDoseOptions_header2.date_val
                            Layout.fillHeight: true
                            Layout.minimumWidth: 250
                            color: "#f7f7f7" //"Transparent"
                            border.color: "LightGray"
                            border.width: 0
//                            Rectangle {
//                                anchors.right: parent.right
//                                anchors.top: parent.top
//                                anchors.bottom: parent.bottom
//                                width: 1
//                                color: "LightGray"
//                            }

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 5
                                spacing: 0
                                Item {
                                    Layout.minimumWidth: 30
                                    Layout.fillHeight: true
                                    Text {
                                        anchors.centerIn: parent
                                        font.pixelSize: 15
                                        //font.bold: true
                                        color: textData_color
                                        wrapMode: Text.WordWrap
                                        text: qsTr("От")
                                    }
                                }
                                Item {
                                    Layout.minimumWidth: 80
                                    Layout.fillHeight: true
                                    Text {
                                        anchors.centerIn: parent
                                        font.pixelSize: 15
                                        //font.bold: true
                                        color: textData_color
                                        wrapMode: Text.WordWrap
                                        text: qsTr(button_2_InfoDoseOptions_header_2.date_begin.toLocaleDateString("ru_RU", "dd.MM.yyyy"))
                                    }
                                }
                                Rectangle {
                                    Layout.minimumWidth: 1
                                    Layout.maximumWidth: 1
                                    //Layout.fillWidth:  true
                                    Layout.fillHeight: true
                                    color: "LightGray"
                                }
                                Item {
                                    Layout.minimumWidth: 30
                                    Layout.fillHeight: true
                                    Text {
                                        anchors.centerIn: parent
                                        font.pixelSize: 15
                                        color: textData_color
                                        //wrapMode: Text.WordWrap
                                        text: qsTr("До")
                                    }
                                }
                                Item {
                                    Layout.minimumWidth: 80
                                    Layout.fillHeight: true
                                    Text {
                                        anchors.centerIn: parent
                                        font.pixelSize: 15
                                        //font.bold: true
                                        color: textData_color
                                        wrapMode: Text.WordWrap
                                        text: qsTr(button_2_InfoDoseOptions_header_2.date_end.toLocaleDateString("ru_RU", "dd.MM.yyyy"))
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent

                                propagateComposedEvents: true
                                hoverEnabled: true

                                cursorShape: Qt.PointingHandCursor;
                                //acceptedButtons: Qt.NoButton

                                onEntered: {
                                    button_2_InfoDoseOptions_header_2.color = "LightGray";
                                    button_2_open_InfoDoseOptions_header_2.state = "open"
                                }
                                onExited: {
                                    button_2_InfoDoseOptions_header_2.color = "#f7f7f7"; //"Transparent";
                                    button_2_open_InfoDoseOptions_header_2.state = "close"
                                }
                                onPressed:  {
                                    item_InfoDoseOptions_header2.currentOption = 2;
                                    item_InfoDoseOptions_header2.date_begin = button_2_InfoDoseOptions_header_2.date_begin;
                                    item_InfoDoseOptions_header2.date_end   = button_2_InfoDoseOptions_header_2.date_end;

                                    main_.updatePersonParameters( main_.id_currentPerson,
                                                                  item_InfoDoseOptions_header2.date_begin.toLocaleDateString("ru_RU", "dd.MM.yyyy"),
                                                                  item_InfoDoseOptions_header2.date_end.toLocaleDateString("ru_RU", "dd.MM.yyyy") )
                                }
                                onReleased: {}
                                onClicked:  {}

                            }
                        }

                    }

                    /// нижния линия - граница
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 1
                        color: "LightGray"
                    }

                    /// опускаяющаяся кнопка с выбором отрезка времени
                    Item {
                        id: button_2_open_InfoDoseOptions_header_2
                        anchors.top: parent.bottom
                        anchors.right: parent.right
                        anchors.rightMargin: 1
                        width: 249
                        height: 5
                        clip: true

                        Rectangle {
                            anchors.fill: parent
                            anchors.topMargin: -radius
                            radius: 10
                            //color: "Transparent"
                            border.color: "LightGray"
                        }
                        Text {
                            id: txt_button_2_open_InfoDoseOptions_header_2
                            anchors.centerIn: parent
                            opacity: 0
                            color: textData_color
                            font.pixelSize: 15
                            text: qsTr("Редактировать")
                        }


                        state: "close"
                        states: [
                            State {
                                name: "close"
                                PropertyChanges {
                                    target: button_2_open_InfoDoseOptions_header_2
                                    height: 5
                                }
                                PropertyChanges {
                                    target: txt_button_2_open_InfoDoseOptions_header_2
                                    opacity: 0
                                }
                            },
                            State {
                                name: "open"
                                PropertyChanges {
                                    target: button_2_open_InfoDoseOptions_header_2
                                    height: 30
                                }
                                PropertyChanges {
                                    target: txt_button_2_open_InfoDoseOptions_header_2
                                    opacity: 1
                                }
                            }
                        ]

                        MouseArea {
                            anchors.fill: parent

                            propagateComposedEvents: true
                            hoverEnabled: true

                            cursorShape: Qt.PointingHandCursor;
                            //acceptedButtons: Qt.NoButton

                            onEntered: {
                                button_2_open_InfoDoseOptions_header_2.state = "open";
                                txt_button_2_open_InfoDoseOptions_header_2.font.pixelSize = 16;
                            }
                            onExited: {
                                button_2_open_InfoDoseOptions_header_2.state = "close";
                                txt_button_2_open_InfoDoseOptions_header_2.font.pixelSize = 15;
                            }
                            onPressed:  {
                                popup_InfoDoseOptions_header2.open();
                            }
                            onReleased: {}
                            onClicked:  {}

                        }


                    }

                    /// всплывающее окно с выбором интервала времени
                    Popup {
                        id: popup_InfoDoseOptions_header2
                        width:  rect_popup_InfoDoseOptions_header2.width  + padding * 2
                        height: rect_popup_InfoDoseOptions_header2.height + padding * 2
                        padding: 0

                        modal: true
                        focus: true
                        closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape //Popup.NoAutoClose
                        //onClosed: {  }
                        parent: Overlay.overlay
                        x: Math.round((parent.width - width) / 2)
                        y: Math.round((parent.height - height) / 2)

                        Item {
                            id: rect_popup_InfoDoseOptions_header2
                            height: 280
                            width: 280
                            //color: "#ebebeb" // "#ebebeb" //transparent

                            Rectangle {
                                id: header_popup_InfoDoseOptions_header2
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                height: 40
                                color: Material.color(Material.Grey, Material.Shade800) //"LightGray"
                                Label {
                                    text: "Укажите интервал"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter

                                    font.pixelSize: 16
                                    color: "White"
                                    font.bold: true
                                }
                            }
                            Button {
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 20
                                width: 100
                                text: "Ok"
                                onClicked: {
                                    //console.log ( " (!) date = " + calendar_DATE_BEGIN_InfoDoseOptions_header2.date_val)
                                    var date_begin = calendar_DATE_BEGIN_InfoDoseOptions_header2.date_val;
                                    var date_end   = calendar_DATE_END_InfoDoseOptions_header2.date_val;

                                    button_2_InfoDoseOptions_header_2.date_begin = date_begin;
                                    button_2_InfoDoseOptions_header_2.date_end   = date_end;

                                    item_InfoDoseOptions_header2.date_begin = date_begin;
                                    item_InfoDoseOptions_header2.date_end   = date_end;

                                    item_InfoDoseOptions_header2.currentOption = 2;
                                    main_.updatePersonParameters( main_.id_currentPerson,
                                                                  date_begin.toLocaleDateString("ru_RU", "dd.MM.yyyy"),
                                                                  date_end.toLocaleDateString("ru_RU", "dd.MM.yyyy") )

                                    popup_InfoDoseOptions_header2.close();
                                }
                            }
                            ColumnLayout {
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: header_popup_InfoDoseOptions_header2.bottom
                                anchors.bottom: parent.bottom
                                anchors.margins: 20
                                anchors.bottomMargin: 80

                                RowLayout {
                                    Item {
                                        Layout.minimumWidth:  30
                                        Layout.minimumHeight: 50
                                        Text {
                                            anchors.centerIn: parent
                                            width: parent.width
                                            font.pixelSize: 15
                                            //font.bold: true
                                            color: textData_color
                                            wrapMode: Text.WordWrap
                                            text: qsTr("От")
                                        }
                                    }
                                    Item {
                                        Layout.minimumWidth:  100
                                        Layout.minimumHeight: 50
                                        MyCalendar {
                                            id: calendar_DATE_BEGIN_InfoDoseOptions_header2
                                            date_val: new Date()
                                            enabled: true
                                        }
                                    }
                                }
                                RowLayout {
                                    Item {
                                        Layout.minimumWidth:  30
                                        Layout.minimumHeight: 50
                                        Text {
                                            anchors.centerIn: parent
                                            width: parent.width
                                            font.pixelSize: 15
                                            //font.bold: true
                                            color: textData_color
                                            wrapMode: Text.WordWrap
                                            text: qsTr("До")
                                        }
                                    }
                                    Item {
                                        Layout.minimumWidth:  100
                                        Layout.minimumHeight: 50
                                        MyCalendar {
                                            id: calendar_DATE_END_InfoDoseOptions_header2
                                            date_val: new Date()
                                            enabled: true
                                        }
                                    }
                                }
                            }
                        }
                    }



                }

                /// Выдвижная панель с опциями v1
                Item {
                    id: item_InfoDoseOptions
                    //property var height_tmp: height
                    //border.width: 1
                    //color: "red" // "transparent"

                    visible: false

                    anchors.top: parent.top
                    anchors.topMargin: -10
                    x: 411
                    width: 190
                    height: 30

                    state: "first"
                    states: [
                        State {
                            name: "first"
                            PropertyChanges {
                                target: item_InfoDoseOptions
                                height: 30
                                width: 190
                                x: 411
                            }
                            PropertyChanges {
                                target: back_InfoDoseOptions
                                border.width: 0
                                color: Material.color(Material.Blue)
                                radius: 10
                                //opacity: 0.1
                            }
                            PropertyChanges {
                                target: txt_buttonInfoDoseOptions
                                text: qsTr("▼")
                                color: "white"
                            }
                            PropertyChanges {
                                target: txt_buttonInfoDoseOptions_2
                                color: "white"
                            }
                            PropertyChanges {
                                target: column_InfoDoseOptions
                                visible: false
                                opacity: 0
                            }
                        },
                        State {
                            name: "close"
                            PropertyChanges {
                                target: item_InfoDoseOptions
                                height: 50
                                width: 190
                                x: 411
                            }
                            PropertyChanges {
                                target: back_InfoDoseOptions
                                border.width: 0
                                color: Material.color(Material.Blue)
                                radius: 10
                                //opacity: 0.1
                            }
                            PropertyChanges {
                                target: txt_buttonInfoDoseOptions
                                text: qsTr("▼")
                                color: "white" // Material.color(Material.Blue)
                            }
                            PropertyChanges {
                                target: txt_buttonInfoDoseOptions_2
                                color: "white"
                            }
                            PropertyChanges {
                                target: column_InfoDoseOptions
                                visible: false
                                opacity: 0
                            }
                        },
                        State {
                            name: "open"
                            PropertyChanges {
                                target: item_InfoDoseOptions
                                height: 270
                                width: 270
                                x: 371 //411
                            }
                            PropertyChanges {
                                target: back_InfoDoseOptions
                                border.width: 1
                                color: "white" //Material.color(Material.Blue)
                                opacity: 0.9
                                radius: 2
                            }
                            PropertyChanges {
                                target: txt_buttonInfoDoseOptions
                                text: qsTr("▲")
                                color: Material.color(Material.Blue)
                            }
                            PropertyChanges {
                                target: txt_buttonInfoDoseOptions_2
                                color: Material.color(Material.Blue)
                            }
                            PropertyChanges {
                                target: column_InfoDoseOptions
                                visible: true
                                opacity: 1
                            }
                        }
                    ]

                    /// анимации при переходах состояний
                    transitions: [
                        Transition {
                            from: "first"; to: "open"
                            SequentialAnimation {
                                ParallelAnimation {
                                    ColorAnimation {
                                        target: txt_buttonInfoDoseOptions
                                        duration: 0
                                    }
                                    ColorAnimation {
                                        target: txt_buttonInfoDoseOptions_2
                                        duration: 0
                                    }
                                }
                                NumberAnimation {
                                    target: txt_buttonInfoDoseOptions
                                    properties: "color"
                                    duration: 200
                                }
                                NumberAnimation {
                                    target: item_InfoDoseOptions
                                    easing.type: Easing.InExpo
                                    properties: "height"
                                    duration: 200
                                }

                                PauseAnimation { duration: 100 }

                                NumberAnimation {
                                    target: column_InfoDoseOptions
                                    properties: "opacity"
                                    duration: 200
                                }
                            }
                        },
                        Transition {
                            from: "close"; to: "open"
                            SequentialAnimation {
                                ParallelAnimation {
                                    ColorAnimation {
                                        target: txt_buttonInfoDoseOptions
                                        duration: 0
                                    }
                                    ColorAnimation {
                                        target: txt_buttonInfoDoseOptions_2
                                        duration: 0
                                    }
                                }

                                //PauseAnimation { duration: 3000 }
                                NumberAnimation {
                                    target: item_InfoDoseOptions
                                    easing.type: Easing.InExpo
                                    properties: "height"
                                    duration: 200
                                }

                                PauseAnimation { duration: 100 }

                                NumberAnimation {
                                    target: column_InfoDoseOptions
                                    properties: "opacity"
                                    duration: 200
                                }
                            }
                        },
                        Transition {
                            from: "open"; to: "close"
                            SequentialAnimation {
                                NumberAnimation {
                                    target: column_InfoDoseOptions
                                    properties: "opacity"
                                    duration: 100
                                }

                                PauseAnimation { duration: 100 }

                                NumberAnimation {
                                    target: item_InfoDoseOptions
                                    //easing.type: Easing.InExpo
                                    properties: "height"
                                    duration: 50
                                }

                                NumberAnimation {
                                    target: back_InfoDoseOptions
                                    //easing.type: Easing.InExpo
                                    properties: "border.width"
                                    duration: 50
                                }

                                ParallelAnimation {
                                    ColorAnimation {
                                        target: txt_buttonInfoDoseOptions
                                        duration: 0
                                    }
                                    ColorAnimation {
                                        target: txt_buttonInfoDoseOptions_2
                                        duration: 0
                                    }
                                }
                            }
                        }
                    ]


                    /// фон
                    Rectangle {
                        id: back_InfoDoseOptions
                        anchors.fill: parent
                        color: Material.color(Material.Blue) //"LightGray"
                        border.color: Material.color(Material.Blue) // "LightGray"
                        opacity: 0.8
                        radius: 10
                    }

                    /// линия сверху
                    Rectangle {
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 1
                        color: Material.color(Material.Blue)
                    }



                    /// кнопка
                    Item {
                        id: rect_buttonInfoDoseOptions
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 30
                        Text {
                            id: txt_buttonInfoDoseOptions_2
                            anchors.horizontalCenter: parent.horizontalCenter
                            y: -10
                            font.pixelSize: 14
                            text: qsTr("Выберите интервал") //▲
                            //color: Material.color(Material.Blue) // "LightGray"
                        }
                        Text {
                            id: txt_buttonInfoDoseOptions
                            anchors.horizontalCenter: parent.horizontalCenter
                            y: 10
                            text: qsTr("▼") //▲
                            //color: Material.color(Material.Blue) // "LightGray"
                        }
                        state: "mouseOUT"
                        states: [
                            State {
                                name: "mouseON"
                                PropertyChanges {
                                    target: txt_buttonInfoDoseOptions
                                    y: 35
                                }
                                PropertyChanges {
                                    target: txt_buttonInfoDoseOptions_2
                                    y: 15
                                }
                                PropertyChanges {
                                    target: rect_buttonInfoDoseOptions
                                    height: 50
                                }
                                PropertyChanges {
                                    target: item_InfoDoseOptions
                                    height: 50
                                }
                            },
                            State {
                                name: "mouseOUT"
                                PropertyChanges {
                                    target: txt_buttonInfoDoseOptions
                                    y: 10
                                }
                                PropertyChanges {
                                    target: txt_buttonInfoDoseOptions_2
                                    y: -10
                                }
                                PropertyChanges {
                                    target: rect_buttonInfoDoseOptions
                                    height: 30
                                }
                                PropertyChanges {
                                    target: item_InfoDoseOptions
                                    height: 30
                                }
                            }
                        ]

                        MouseArea {
                            anchors.fill: parent

                            hoverEnabled: true
                            onEntered: {
                                if (item_InfoDoseOptions.state == "close" || item_InfoDoseOptions.state == "first") {
                                    rect_buttonInfoDoseOptions.state = "mouseON"
                                }
                            }
                            onExited: {
                                if (item_InfoDoseOptions.state == "close" || item_InfoDoseOptions.state == "first") {
                                    rect_buttonInfoDoseOptions.state = "mouseOUT"
                                }
                            }
                            onPressed:  {}
                            onReleased: {}
                            onClicked:  { item_InfoDoseOptions.state = (item_InfoDoseOptions.state == "open") ? "close" : "open"  }

                        }

                    }

                    ColumnLayout {
                        id: column_InfoDoseOptions
                        property int curenIndex: -1
                        anchors.top: rect_buttonInfoDoseOptions.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        spacing: 0

                        onCurenIndexChanged: {
                            column_InfoDoseOptions_item_0.color = "transparent"
                            column_InfoDoseOptions_item_1.color = "transparent"
                            column_InfoDoseOptions_item_2.color = "transparent"
                            var colorCurrent = Material.color(Material.Blue)
                            if(curenIndex == 0) {
                                column_InfoDoseOptions_item_0.color = colorCurrent

                            }
                            if(curenIndex == 1) {
                                column_InfoDoseOptions_item_1.color = colorCurrent
                            }
                            if(curenIndex == 2) {
                                column_InfoDoseOptions_item_2.color = colorCurrent
                            }


                        }
                        Rectangle {
                            id: column_InfoDoseOptions_item_0
                            Layout.minimumHeight: 50
                            Layout.fillWidth: true
                            color: "transparent"
                            border.color: Material.color(Material.Blue) // "LightGray"
                            border.width: 0

                            ColumnLayout {
                                //anchors.fill: parent
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.margins: 5
                                Text {
                                    color: (column_InfoDoseOptions.curenIndex == 0) ? "white" : textData_color
                                    text: qsTr("От начала года по сегодня")
                                }
                                Text {
                                    color: (column_InfoDoseOptions.curenIndex == 0) ? "white" : textData_color
                                    text: {
                                        var now = new Date;
                                        var date0 = new Date(now.getFullYear(), 0, 1)
                                        var today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                                        var diff =  Math.floor((today - date0) / 1000 / 3600 / 24);

                                        return "За "  + diff + " (дней)";
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent

                                hoverEnabled: true
                                onEntered:  { parent.border.width = 1 }
                                onExited:   { parent.border.width = 0 }
                                onPressed:  {}
                                onReleased: {}
                                onClicked:  {
                                    column_InfoDoseOptions.curenIndex = 0;
                                }
                            }
                        }
                        Item {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 1
                            Layout.maximumHeight: 1

                            Rectangle {
                                height: 1
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.margins: 10
                                color: Material.color(Material.Blue)
                                opacity: 0.4
                            }
                        }
                        Rectangle {
                            id: column_InfoDoseOptions_item_1
                            Layout.minimumHeight: 50
                            Layout.fillWidth: true
                            color: "transparent"
                            border.color: Material.color(Material.Blue) // "LightGray"
                            border.width: 0

                            ColumnLayout {
                                //anchors.fill: parent
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.margins: 5
                                Text {
                                    color: (column_InfoDoseOptions.curenIndex == 1) ? "white" : textData_color
                                    text: qsTr("За последний год")
                                }
                            }


                            MouseArea {
                                anchors.fill: parent

                                hoverEnabled: true
                                onEntered:  { parent.border.width = 1 }
                                onExited:   { parent.border.width = 0 }
                                onPressed:  {}
                                onReleased: {}
                                onClicked:  { column_InfoDoseOptions.curenIndex = 1; }
                            }
                        }
                        Item {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 1
                            Layout.maximumHeight: 1

                            Rectangle {
                                height: 1
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.margins: 10
                                color: Material.color(Material.Blue)
                                opacity: 0.4
                            }
                        }
                        Rectangle {
                            id: column_InfoDoseOptions_item_2
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: "transparent"
                            border.color: Material.color(Material.Blue) // "LightGray"
                            border.width: 0

                            MouseArea {
                                anchors.fill: parent

                                hoverEnabled: true
                                onEntered:  { parent.border.width = 1 }
                                onExited:   { parent.border.width = 0 }
                                onPressed:  {}
                                onReleased: {}
                                onClicked:  { column_InfoDoseOptions.curenIndex = 2; }
                            }

                            GridLayout {
                                //anchors.fill: parent
                                //anchors.horizontalCenter: parent.horizontalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.margins: 5

                                columns: 2
                                rows: 2

                                Item {
                                    Layout.row: 1
                                    Layout.column: 1
                                    Layout.minimumWidth: 30
                                    Layout.minimumHeight: 50
                                    Layout.alignment: Qt.AlignCenter
                                    //border.width: 1

                                    Text {
                                        anchors.centerIn: parent
                                        color: (column_InfoDoseOptions.curenIndex == 2) ? "white" : textData_color
                                        text: qsTr("От")
                                    }
                                }
                                Item {
                                    Layout.row: 2
                                    Layout.column: 1
                                    Layout.minimumWidth: 30
                                    Layout.minimumHeight: 50
                                    Layout.alignment: Qt.AlignCenter

                                    Text {
                                        anchors.centerIn: parent
                                        color: (column_InfoDoseOptions.curenIndex == 2) ? "white" : textData_color
                                        text: qsTr("До")
                                    }
                                }
                                Item {
                                    Layout.row: 1
                                    Layout.column: 2
                                    Layout.minimumWidth: 110
                                    Layout.minimumHeight: 50
                                    Layout.alignment: Qt.AlignCenter
                                    MyCalendar {
                                        id: date_begin_InfoDoseOptions
                                        date_val: new Date()
                                        cbwidth: 60
                                        sizeNumbers: 11
                                    }
                                }
                                Item {
                                    Layout.row: 2
                                    Layout.column: 2
                                    Layout.minimumWidth: 110
                                    Layout.minimumHeight: 50
                                    Layout.alignment: Qt.AlignCenter
                                    MyCalendar {
                                        id: date_end_InfoDoseOptions
                                        date_val: new Date()
                                    }
                                }

                            }


                        }
                    }


                }

            }


            Item {
                id: wtab4
                Label {
                    text: "tab 4"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }


}





