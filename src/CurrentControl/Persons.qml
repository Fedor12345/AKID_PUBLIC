import QtQuick 2.12
import QtQuick.Controls 2.5

import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

import QtQuick.Dialogs 1.2

Page {
    id: main_

    clip: true

    property string textData_color: "#6b6b6b" // Material.color(Material.Teal)
    property int space_margin: 15    

    property var model_perosn
    property var model_ext_person_list
    property var model_adm_status //:           stackview_mainwindow.model_adm_status
    property var model_adm_assignment //:       stackview_mainwindow.model_adm_assignment
    property var model_adm_organisation //:     stackview_mainwindow.model_adm_organisation
    property var model_adm_department_outer //: stackview_mainwindow.model_adm_department_outer
    property var model_adm_department_inner //: stackview_mainwindow.model_adm_department_inner

    signal currentPersonChange(var id_currentPerson, var fio_currentPerson, var sex, var staff_type, var age)
    signal currentPersonChange_photo(var imagePath)
    signal currentPersonChange_date_burn(var burn_date_lost)


    /// ЗАПРОС В МОДЕЛЬ НА ДАННЫЕ О СОТРУДНИКЕ ПО ЕГО ID_PERSON
    function workerModelQuery(id_person){
        //setQueryDB()
        //workersModel.query  =
        model_perosn.query = " SELECT
                               ID_PERSON, W_SURNAME, W_NAME, W_PATRONYMIC, PERSON_NUMBER,
                               SEX, BIRTH_DATE, DOSE_BEFORE_NPP,DOSE_CHNPP, IKU_YEAR, IKU_MONTH,
                               WEIGHT, HEIGHT, DATE_ON, DATE_OFF, EMERGENCY_DOSE,DISABLE_RADIATION,
                               ID_TLD, STAFF_TYPE,

                               PASSPORT_NUMBER, PASSPORT_GIVE,
                               PASSPORT_DATE, POLICY_NUMBER, SNILS,
                               HOME_ADDRESS, HOME_TEL,
                               WORK_TEL,MOBILE_TEL, WORK_ADDRESS, E_MAIL,

                               adm_status.STATUS,

                               ADM_ORGANIZATION.ORGANIZATION_,
                               ADM_DEPARTMENT_INNER.DEPARTMENT_INNER,
                               ADM_DEPARTMENT_OUTER.DEPARTMENT_OUTER,
                               ADM_ASSIGNEMENT.ASSIGNEMENT

                               FROM ext_person
                               LEFT JOIN adm_status           ON ext_person.STATUS_CODE         = adm_status.STATUS_CODE
                               LEFT JOIN ADM_ORGANIZATION     ON ext_person.ID_ORGANIZATION     = ADM_ORGANIZATION.ID
                               LEFT JOIN ADM_DEPARTMENT_INNER ON ext_person.ID_DEPARTMENT_INNER = ADM_DEPARTMENT_INNER.ID
                               LEFT JOIN ADM_DEPARTMENT_OUTER ON ext_person.ID_DEPARTMENT_OUTER = ADM_DEPARTMENT_OUTER.ID
                               LEFT JOIN ADM_ASSIGNEMENT      ON ext_person.ID_ASSIGNEMENT      = ADM_ASSIGNEMENT.ID

                               WHERE ext_person.ID_PERSON = " + id_person;
    }


    Item {
        id: modeles
        //property var model_ext_person_list: managerDB.createModel(" SELECT ID_PERSON, W_NAME, W_SURNAME, W_PATRONYMIC, PERSON_NUMBER, ID_TLD FROM EXT_PERSON ORDER BY W_SURNAME", "ext_person" )
    }


    /// ПОЛУЧЕНИЕ ОТВЕТА ОТ ЗАПРОСА
    Connections {
        target: Query1
        onSignalSendResult: {
            if (owner_name === "WorkersCard") {
                if (res) {
                    model_ext_person_list.updateModel(); //modeles.
                }
            }
            if (owner_name === "pullOutPhotoCurrentPerson") {
                console.log(" pullOutPhotoCurrentPerson: ", res, var_res, messageError );
                image_photoPerson.source = "";
                var imagePath;
                if ( var_res == 0 ) {
                    image_photoPerson.emptyPhoto = true;
                    imagePath = "icons/face.svg";
                    //image_photoPerson.source = "icons/face.svg";
                }
                else {
                    /// sqlquery.cpp выполнил запрос и вытащил фото из БД,
                    /// преобразовав его в побитовый массив (QByteArray),
                    /// после чего передал его в QML в переменной var_res.
                    /// Теперь отправляем этот массив через FileManager в ImageProvider, что бы потом выгрузить изображение в QML
                    FileManager.saveFile(var_res, "", "photo_2", "jpg");
                    FileManager.loadByteArrayToImageProvider(var_res, "photo_person");
                    image_photoPerson.emptyPhoto = false;
                    imagePath = "image://images/photo_person";
                    //image_photoPerson.source = "image://images/photo_person";
                }
                image_photoPerson.source = imagePath;

                /// сигнал currentPersonChange_photo вызывается дважды для того чтобы очистить кэш в элементах Image
                /// (при первом вызове параметр imagePath = 0) иначе в объекте ImageProvider не будет вызываться метод requestPixmap
                /// и изображения обновятся
                currentPersonChange_photo("");
                currentPersonChange_photo(imagePath);
            }
            if ( owner_name === "getDATA_BURN_lust" ) {
                if (res) {
                    var date_burn = var_res.toLocaleDateString("ru_RU", "dd.MM.yyyy");
                    currentPersonChange_date_burn(date_burn);
                }
            }

            //////////////////////////////////////////////////////////////////////////////////////////////

            if (owner_name == "getMainPersonParam1") {
                /// 21 22 25 26 27 31 32 33 37 38
                if (res) {
                    //console.log(" getMainPersonParam1 ==== ", var_res, " ", var_res["Z21"], var_res["Z22"], var_res["Z25"], var_res["Z26"], var_res["Z27"], var_res["Z31"]);

                    txt_mainParams1.text = parseFloat(var_res["Z21"] + var_res["Z22"]                  ).toFixed(5)
                    txt_mainParams2.text = parseFloat(var_res["Z25"] + var_res["Z26"] + var_res["Z27"] ).toFixed(5)
                    txt_mainParams3.text = parseFloat(var_res["Z31"] + var_res["Z32"] + var_res["Z33"] ).toFixed(5)
                    txt_mainParams4.text = parseFloat(var_res["Z37"] + var_res["Z38"]                  ).toFixed(5) // + var_res["Z39"]
                }
            }
            if (owner_name == "getMainPersonParam2") {
                /// 23 24 28 29 30 34 35 36 40 41
                if (res) {
                    console.log(" getMainPersonParam2 ==== ", var_res, " ",var_res["Z23"], var_res["Z24"], var_res["Z28"], var_res["Z29"]);
                    //console.log("1: Number(txt_mainParams2.text) = ",Number(txt_mainParams2.text));

                    ///parseFloat(text).toFixed(4)
                    txt_mainParams1.text = parseFloat(parseFloat(txt_mainParams1.text) + var_res["Z23"] + var_res["Z24"]                   ).toFixed(5)
                    txt_mainParams2.text = parseFloat(parseFloat(txt_mainParams2.text) + var_res["Z28"] + var_res["Z29"] + var_res["Z30"]  ).toFixed(5)
                    txt_mainParams3.text = parseFloat(parseFloat(txt_mainParams3.text) + var_res["Z34"] + var_res["Z35"] + var_res["Z36"]  ).toFixed(5)
                    txt_mainParams4.text = parseFloat(parseFloat(txt_mainParams4.text) + var_res["Z40"] + var_res["Z41"]                   ).toFixed(5) // + var_res["Z42"]

                    console.log("2: Number(txt_mainParams2.text) = ",Number(txt_mainParams2.text));
                }

            }



        }
    }

    /// ПОЛУЧЕНИЕ ОТВЕТА ОТ МОДЕЛИ
    Connections {
        target: model_perosn
        onSignalUpdateDone: {
            if(nameModel=="select_person")
            {
                if (model_perosn.rowCount() > 0) {
                    // информация о работе
                    //doznarad_position.text = model_perosn.get(0)["doznarad_position"]
                    txt_organization.text = model_perosn.get(0)["ORGANIZATION_"]
                    if( model_perosn.get(0)["STAFF_TYPE"]==="Командировачный" )
                    { txt_department.text   = model_perosn.get(0)["DEPARTMENT_OUTER"] }
                    else if ( model_perosn.get(0)["STAFF_TYPE"]==="Персонал АЭС" )
                    { txt_department.text   = model_perosn.get(0)["DEPARTMENT_INNER"] }
                    txt_assignement.text  = model_perosn.get(0)["ASSIGNEMENT"]


                    var str = "";

                    // персональная информация
                    //txt_fio.text        = model_perosn.get(0)["W_NAME"] + " " + model_perosn.get(0)["W_SURNAME"] + " " + model_perosn.get(0)["W_PATRONYMIC"]
                    txt_fio.text        = model_perosn.get(0)["W_SURNAME"] + "\n"
                            + model_perosn.get(0)["W_NAME"] + " "
                            + model_perosn.get(0)["W_PATRONYMIC"]
                    txt_pn.text         = model_perosn.get(0)["PERSON_NUMBER"]
                    txt_staff_type.text = model_perosn.get(0)["STAFF_TYPE"]
                    txt_tld.text        = model_perosn.get(0)["ID_TLD"]
                    txt_status.text     = model_perosn.get(0)["STATUS"]

//                    txt_iku_month.text = model_perosn.get(0)["IKU_MONTH"]
//                    txt_iku_year.text  = model_perosn.get(0)["IKU_YEAR"]

//                    txt_dose_before_npp.text = model_perosn.get(0)["DOSE_BEFORE_NPP"]
//                    txt_dose_chnpp.text      = model_perosn.get(0)["DOSE_CHNPP"]

//                    str = model_perosn.get(0)["DATE_ON"]
//                     var options = {
//                       year: 'numeric',
//                       month: 'long',
//                       day: 'numeric'
//                     };
//                     str.toLocaleString("ru", options)
//                    txt_date_on.text  = str.getDate() + "." + (str.getMonth()+1)  + "." + str.getFullYear()   //String(model_perosn.get(0)["DATE_ON"]).substring(0,20)
//                    str = model_perosn.get(0)["DATE_OFF"]
//                    txt_date_off.text = str.getDate() + "." + (str.getMonth()+1)  + "." + str.getFullYear()


                    if( model_perosn.get(0)["EMERGENCY_DOSE"] === "1" ) {
                        txt_emergency_dose.is = true;
                    }
                    else if( model_perosn.get(0)["EMERGENCY_DOSE"] === "0" )
                    {
                        txt_emergency_dose.is = false;
                    }

                    if(model_perosn.get(0)["DISABLE_RADIATION"] === "1") {
                        nw_disable_radiation.is = true;
                    }
                    else if( model_perosn.get(0)["DISABLE_RADIATION"] === "0" )
                    {
                        nw_disable_radiation.is = false;
                    }




                    //3
                    txt_gender.text   = (model_perosn.get(0)["SEX"] === "M") ? "М" : "Ж"
                    str = model_perosn.get(0)["BIRTH_DATE"]
                    txt_birthday.text = str.getDate() + "." + (str.getMonth()+1) + "." + str.getFullYear()
                    txt_weight.text   = model_perosn.get(0)["WEIGHT"]
                    txt_height.text   = model_perosn.get(0)["HEIGHT"]

                    //txt_pass_serial.text  = model_perosn.get(0)["passport_series"]
                    txt_pass_number.text  = model_perosn.get(0)["PASSPORT_NUMBER"]
                    txt_pass_whoget.text  = model_perosn.get(0)["PASSPORT_GIVE"]
                    str = model_perosn.get(0)["PASSPORT_DATE"]
                    txt_pass_dateget.text = str.getDate() + "." +(str.getMonth()+1)  + "." + str.getFullYear()

//                    txt_medical_number.text = model_perosn.get(0)["POLICY_NUMBER"]
//                    txt_medical_series.text = model_perosn.get(0)["SNILS"]

                    txt_snils.text = model_perosn.get(0)["SNILS"]

                    txt_mobile_phone.text = model_perosn.get(0)["MOBILE_TEL"]
                    txt_home_address.text = model_perosn.get(0)["HOME_ADDRESS"]
                    txt_home_phone.text = model_perosn.get(0)["HOME_TEL"]

                    txt_work_phone.text = model_perosn.get(0)["WORK_TEL"]
                    txt_work_address.text = model_perosn.get(0)["WORK_ADDRESS"]
                    txt_work_email.text = model_perosn.get(0)["E_MAIL"]


                    ////////////////////////////////////////////////////////////////////////////////
                    /// генерируется сигнал о изменении выбранного сотрудника из спсика
                    var sex = (txt_gender.text === "М") ? "M" : "F"  /// txt_gender.text === "М", тут М на кириллице
                    var age = 25; /// ДОДЕЛАТЬ ОПРЕДЕЛЕНИЕ ВОЗРАСТА ВЫБРАННОГО СОТРУДНИКА
                    var fio_currentPerson = model_perosn.get(0)["W_SURNAME"] + "\n"
                                          + model_perosn.get(0)["W_NAME"] + " "
                                          + model_perosn.get(0)["W_PATRONYMIC"]
                    currentPersonChange(model_perosn.get(0)["ID_PERSON"], fio_currentPerson, sex, model_perosn.get(0)["STAFF_TYPE"], age)
                    ////////////////////////////////////////////////////////////////////////////////

                }

            }

        }

    }


    // добавление нового сотрудника в бд
    function createNewPerson(map_data) {
        console.log("createNewPerson: ");
        Query1.insertRecordIntoTable("WorkersCard" ,"EXT_PERSON", map_data) //wc_query.map_data

    }

    // обновление данных сотрудника в бд
    function updateOldPerson(map_data,id_person) {
        console.log("updateOldPerson: ",id_person);
        Query1.updateRecordIntoTable("WorkersCard" ,"EXT_PERSON", map_data, "ID_PERSON", id_person) //wc_query.map_data

    }

    /// ОКНО ДОБАВЛЕНИЯ НОВОГО СОТРУДНИКА
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
            model_adm_status:           main_.model_adm_status
            model_adm_organisation:     main_.model_adm_organisation
            model_adm_department_outer: main_.model_adm_department_outer
            model_adm_department_inner: main_.model_adm_department_inner
            model_adm_assignment:       main_.model_adm_assignment

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

    /// ОКНО ОБНОВЛЕНИЯ ВЫБРАННОГО СОТРУДНИКА
    Popup {
        id: popup_UpdateWorker
        width: updateWorker.width + padding*2
        height: updateWorker.height + padding*2

        modal: true
        focus: true
        closePolicy: Popup.NoAutoClose
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        padding: 0

        UpdateWorker {
            id: updateWorker
            model_worker: model_perosn
            model_adm_status:           main_.model_adm_status
            model_adm_organisation:     main_.model_adm_organisation
            model_adm_department_outer: main_.model_adm_department_outer
            model_adm_department_inner: main_.model_adm_department_inner
            model_adm_assignment:       main_.model_adm_assignment
            onUpdate_cancel: {
                popup_UpdateWorker.close();
            }
            onUpdate_confirm: {
                popup_UpdateWorker.close()
                updateOldPerson(data_record, id_person)
            }
        }


    }



    /// frame_listAllPersons.isOpen

/// группа основных элементов данных
Item {
    id: main_2
    anchors.left: parent.left
    anchors.right: parent.right
    //anchors.rightMargin: 260
    anchors.top: parent.top
    anchors.bottom: parent.bottom

    /// ЗАГОЛОВОК
    Frame {
        id: frame_headerPersons //frame_wmenu

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
                //font.capitalization: Font.AllUppercase // в верхний регистр
                //selectByMouse: true
                //selectionColor: Material.color(Material.Red)
                color: "#808080" //( main_.fio_currentPerson === "Сотрудник не выбран" ) ? "LightGray" : "#474747" // "Black" //Material.color(Material.DeepOrange)
                text: "СОТРУДНИКИ"
            }
            ToolSeparator {}
            Text {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20 //main_.sizeTxt
                font.bold: true
                //font.capitalization: Font.AllUppercase // в верхний регистр
                //selectByMouse: true
                //selectionColor: Material.color(Material.Red)
                color: "#808080" //( main_.fio_currentPerson === "Сотрудник не выбран" ) ? "LightGray" : "#474747" // "Black" //Material.color(Material.DeepOrange)
                text: (frame_listAllPersons.isOpen) ? "ПОИСК" : "ИНФОРМАЦИЯ О СОТРУДНИКЕ"
            }
        }


    }


    /// СПИСОК ВСЕХ СОТРУДНИКОВ
    Item {
        id: frame_listAllPersons

        property bool isOpen: true
        property int widthOpen: 700
        property int widthClose: 50
        property int speedAnimation: 500

        anchors.top: frame_headerPersons.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: space_margin
        width: widthOpen  //700 //isOpen ? 700 : 50
        clip: true        

        //color: "Transparent"
//        padding: 1
//        topPadding: 1
//        bottomPadding: 1

        onIsOpenChanged: {
            animation_allPersons1.stop();
            animation_allPersons1.running = true;

            animation_allPersons2.stop();
            animation_allPersons2.running = true;
        }

        NumberAnimation {
            id: animation_allPersons1
            target: frame_listAllPersons
            easing.period: 0.8
            properties: "width"
            easing.type: Easing.OutElastic
            from: frame_listAllPersons.isOpen ? frame_listAllPersons.widthOpen  :  frame_listAllPersons.widthClose
            to:   frame_listAllPersons.isOpen ? frame_listAllPersons.widthClose :  frame_listAllPersons.widthOpen
            duration: frame_listAllPersons.speedAnimation
            running: false
        }
        NumberAnimation {
            id: animation_allPersons2
            target: rect_AdvancedSearch
            properties: "opacity"
            easing.type: Easing.InOutElastic
            from:
            {
                return frame_listAllPersons.isOpen ? 1 : 0
            }
            to:
            {
                return frame_listAllPersons.isOpen ? 0 : 1
            }
            duration: frame_listAllPersons.speedAnimation + 800
            running: false
        }


        /// функция генерирует строку с добавочными условиями по поиску сотрудников
        function advancedSearch_fun() {
            var advancedSearch = "";
            var dataCurrent = "";
            var isAnd = false;

            /// просмотр флажка ПОЛ
            if(checkBox_SEX.checked) {
                if      (comboBox_SEX.currentIndex==0) { dataCurrent = "'M'"; }
                else if (comboBox_SEX.currentIndex==1) { dataCurrent = "'F'"; }
                else {
                    dataCurrent = "";
                }
                advancedSearch = advancedSearch + " SEX = " + dataCurrent;

                //if ( isAnd ) advancedSearch = " AND " + advancedSearch;
                isAnd = true;
            }

            /// просмотр флажка ДАТА РОЖДЕНИЯ
            if(checkBox_BIRTH_DATE.checked) {
                if ( comboBox_YEAR_DATE.currentIndex >= 0 ) {
                    if ( isAnd ) advancedSearch = advancedSearch + " AND ";
                    isAnd = true;
                    dataCurrent = comboBox_YEAR_DATE.currentText
                    advancedSearch = advancedSearch + " Extract(YEAR FROM BIRTH_DATE) = " + dataCurrent;  //= TO_DATE('" + dataCurrent + "','DD/MM/YY') "
                    //advancedSearch = advancedSearch + " Year(BIRTH_DATE) = " + dataCurrent;  //= TO_DATE('" + dataCurrent + "','DD/MM/YY') "
//                    dataCurrent = new Date(comboBox_YEAR_DATE.currentText).toLocaleDateString("ru_RU", "dd.MM.yyyy");;
//                    advancedSearch = advancedSearch + " BIRTH_DATE = TO_DATE('" + dataCurrent + "','DD/MM/YY') "
                }

//                if (myCalendar_BIRTH_DATE.ready) {
//                    if ( isAnd ) advancedSearch = advancedSearch + " AND ";
//                    isAnd = true;
//                    dataCurrent = myCalendar_BIRTH_DATE.date_val.toLocaleDateString("ru_RU", "dd.MM.yyyy");;
//                    advancedSearch = advancedSearch + " BIRTH_DATE = TO_DATE('" + dataCurrent + "','DD/MM/YY') "
//                }
            }

            /// просмотр флажка ТИП ПЕРСОНАЛА
            if(checkBox_STAFF_TYPE.checked) {
                if ( comboBox_STAFF_TYPE.currentIndex >= 0 ) {
                    if ( isAnd ) advancedSearch = advancedSearch + " AND ";
                    isAnd = true;
                    if      (comboBox_STAFF_TYPE.currentIndex==0) { dataCurrent = "'Персонал АЭС'"; }
                    else if (comboBox_STAFF_TYPE.currentIndex==1) { dataCurrent = "'Командировачный'"; }
                    else { dataCurrent = ""; }
                    advancedSearch = advancedSearch + " STAFF_TYPE = " + dataCurrent;
                }

            }
            /// просмотр флажка ДОЛЖНОСТЬ
            if(checkBox_ASSIGNEMENT.checked) {
                if ( comboBox_ASSIGNEMENT.currentIndex >= 0 ) {
                    if ( isAnd ) advancedSearch = advancedSearch + " AND ";
                    isAnd = true;
                    dataCurrent = parseInt( main_.model_adm_assignment.getFirstColumnInt(comboBox_ASSIGNEMENT.currentIndex), 10 )
                    advancedSearch = advancedSearch + " ID_ASSIGNEMENT = '" + dataCurrent + "'";
                }

            }


            return advancedSearch;
        }

        /// Список всех сотрудников с полем поиска
        Rectangle {
            id: allPersons
            //anchors.fill: parent
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: frame_listAllPersons.closeAllElem ? 0 : 350
            color: "#f7f7f7" //"#f7f7f5" //  //#EEEEEE
            border.color: "LightGray"
            //AnchorAnimation { duration: 100 }

            /// поле-заголовок
            Rectangle {
                id: header_allPersons
                //visible: frame_listAllPersons.closeAllElem ? false : true
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                //anchors.rightMargin: 320
                height:  45
                color: "#adadad" //"#009688"
                //border.color: "LightGray"


                /// поле ввода для поиска
                TextField {
                        id: field_PersonSearch
                        visible: (frame_listAllPersons.isOpen) ? true : false
                        property string quyrySQLAdvancedSearch: ""
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.right: parent.right
                        anchors.rightMargin: 40
                        height: 30

                        bottomPadding: 0
                        topPadding: 0
                        leftPadding: 8
                        rightPadding: 8

                        font.pixelSize: 16
                        placeholderText: qsTr("Поиск сотрудника..")
                        selectByMouse: true

                        //property bool havechoice: false

                        background: Rectangle {
                            anchors.fill: parent
                            radius: 5
                            color: "White"
                            border.color: "DarkGray"
                        }
                        onTextChanged: {
                                timer_updatePersonList.restart()
                        }
                }




                Timer {
                    id: timer_updatePersonList
                    interval: 500
                    repeat: false
                    onTriggered: {
                        var advancedSearch = frame_listAllPersons.advancedSearch_fun(); /// строка с добавочными условиями по поиску сотрудников

                        if (field_PersonSearch.text.length > 0) {
                            var txt = field_PersonSearch.text
                            if ( advancedSearch.length > 0) {
                                advancedSearch = " AND " + advancedSearch;
                            }

                            if(isNaN(txt)) { /// проверка число или текст                                
                                var query =
                                        " SELECT ID_PERSON, W_NAME, W_SURNAME, W_PATRONYMIC, PERSON_NUMBER, ID_TLD
                                          FROM EXT_PERSON
                                          WHERE (LOWER(W_SURNAME) LIKE '" + txt.toLowerCase() + "%') "
                                          //field_PersonSearch.quyrySQLAdvancedSearch +
                                          + advancedSearch +
                                          " ORDER BY W_SURNAME ";
                                console.log("query = /n", query);
                                list_Persons.model.query = query;

//                                        " SELECT ID_PERSON, W_NAME, W_SURNAME, W_PATRONYMIC, PERSON_NUMBER, ID_TLD
//                                          FROM EXT_PERSON
//                                          WHERE (LOWER(W_SURNAME) LIKE '" + txt.toLowerCase() + "%')
//                                          ORDER BY W_SURNAME "
                            } else {
                                list_Persons.model.query =
                                        " SELECT ID_PERSON, W_NAME, W_SURNAME, W_PATRONYMIC, PERSON_NUMBER, ID_TLD
                                          FROM EXT_PERSON
                                          WHERE (ID_TLD LIKE '" + txt + "%') "
                                          + advancedSearch +
                                          " ORDER BY W_SURNAME "
                            }
                        } else {
                            if ( advancedSearch.length > 0) {
                                advancedSearch = " WHERE " + advancedSearch;
                                list_Persons.model.query =
                                            " SELECT ID_PERSON, W_NAME, W_SURNAME, W_PATRONYMIC, PERSON_NUMBER, ID_TLD
                                              FROM EXT_PERSON "
                                              + advancedSearch +
                                              " ORDER BY W_SURNAME "
                            } else {
                                list_Persons.model.query =
                                            " SELECT ID_PERSON, W_NAME, W_SURNAME, W_PATRONYMIC, PERSON_NUMBER, ID_TLD
                                              FROM EXT_PERSON
                                              ORDER BY W_SURNAME "
                            }

                        }
                        stop();
                    }
                }


                /// кнопка обновить
                Rectangle {
                    //visible: frame_listAllPersons.closeAllElem ? false : true
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.margins: 1
                    color: "transparent"
                    width: 40
                    Text {
                        id: txt_button_update
                        anchors.centerIn: parent
//                        anchors.right: parent.right
//                        anchors.top: parent.top
//                        anchors.rightMargin: 2
//                        anchors.topMargin: -10
                        font.pixelSize: 35
                        color: "LightGray"
                        text: qsTr("⟳") //✓ ⟳ ☺ 😐
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered:  { txt_button_update.color = "#FF5722" }
                        onExited:   { txt_button_update.color = "LightGray" } // = "#4CAF50"
                        onPressed:  { /*parent.color = "#f6ffed" */}
                        onReleased: { /*parent.color = "transparent"*/ }
                        onClicked:  {
                            //modeles.model_ext_person_list.updateModel();
                            //timer_updatePersonList.interval = 100;
                            timer_updatePersonList.restart();
                        }
                    }
                }

            }

            /// список сотрудников
            Item {
                id: body_allPersons
                //visible: frame_listAllPersons.isOpen ? true : false
                anchors.top: header_allPersons.bottom
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                //anchors.rightMargin: 320

                ListView {
                    id: list_Persons
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    //anchors.topMargin: 1
                    //anchors.margins: 5
                    currentIndex: -1 //0
                    property string id_currentPerson: model_ext_person_list.getFirstColumnInt(currentIndex)
                    property string fio_currentPerson:
                    {
                        var str;
                        str = model_ext_person_list.getCurrentDate(1,currentIndex) + " " +
                              model_ext_person_list.getCurrentDate(2,currentIndex) + " " +
                              model_ext_person_list.getCurrentDate(3,currentIndex);
                        return str;
                    }

        //            onCurrentIndexChanged: {
        //                stackview_mainwindow.id_currentPerson = model_ext_person_list.getFirstColumnInt(list_Persons.currentIndex)
        //            }

        //            Component.onCompleted: {
        //                list_Persons.id_currentPerson = id_currentPerson //model_ext_person_list.getFirstColumnInt(list_Persons.currentIndex)
        //                //timer_persons.restart()
        //                //timer_persons0.restart()
        //            }


                    highlightFollowsCurrentItem: true
                    model: model_ext_person_list
        //                ListModel {
        //                ListElement {
        //                    name: "Name A"
        //                    number: "1113264"
        //                }
        //                ListElement {
        //                    name: "Name B"
        //                    number: "4564564"
        //                }
        //                ListElement {
        //                    name: "Name C"
        //                    number: "4654564"
        //                }
        //            }

                    ScrollBar.vertical: ScrollBar {
                        policy: "AsNeeded" //"AlwaysOn"
                    }

                    clip: true
                    delegate:
                        ItemDelegate {
                        width: 340 //325
                        height: 60
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
                                    text: W_SURNAME + " " + W_NAME + " " + W_PATRONYMIC
                                    font.pixelSize: 14
                                    color: {
                                     if (list_Persons.currentIndex == index) { "#FF5722" }
                                     else { "#4c4c4c" }
                                    }
                                    //font.bold: true
                                }
                                Text {
                                    text: "Таб. № " + PERSON_NUMBER
                                    font.pixelSize: 10
                                    color: "#777777"
                                }
                                Text {
                                    text: "ТЛД № " + ID_TLD
                                    font.pixelSize: 10
                                    color: "#777777"
                                }
                            }

                        }

                        onClicked: {
                            if (list_Persons.currentIndex !== index) {
                                list_Persons.currentIndex = index
                            }
                            list_Persons.id_currentPerson = model_ext_person_list.getFirstColumnInt(index)
                            timer_persons.restart()
                        }
                    }

                    highlight: Rectangle {
                        color: "transparent" // "#FF5722" //"#c9c9c9" // "#B0BEC5" //Material.color(Material.Grey, Material.Shade700)
                        border.color: "#FF5722"
        //                Image {
        //                    id: idrop
        //                    width: 24
        //                    height: 24
        //                    source: "icons/arrow-down-drop.svg"
        //                    sourceSize.height: 24
        //                    sourceSize.width: 24
        //                    fillMode: Image.Stretch
        //                    rotation: 90
        //                    anchors.right: parent.right
        //                    anchors.verticalCenter: parent.verticalCenter

        //                }
                    }
                    highlightMoveDuration: 400
                }

                Timer {
                    id: timer_persons0
                    interval: 100
                    repeat: false
                    onTriggered: {
                        list_Persons.id_currentPerson = model_ext_person_list.getFirstColumnInt(0);
                        stop();
                    }
                }


                Timer {
                    id: timer_persons
                    interval: 410
                    repeat: false
                    onTriggered: {
                        var query;

                        query = " SELECT PHOTO from EXT_PERSON WHERE ID_PERSON = " + list_Persons.id_currentPerson;
                        Query1.setQueryAndName(query, "pullOutPhotoCurrentPerson");
                        query = " select max(BURN_DATE) FROM EXT_DOSE WHERE ID_PERSON = " + list_Persons.id_currentPerson;
                        Query1.setQueryAndName(query, "getDATA_BURN_lust");

                        main_.workerModelQuery(list_Persons.id_currentPerson);


                        var now = new Date();
                        var date_begin = new Date((now.getFullYear()-1),now.getMonth(),now.getDate()).toLocaleDateString("ru_RU", "dd.MM.yyyy");
                        var date_end   = now.toLocaleDateString("ru_RU", "dd.MM.yyyy");

                        query = " SELECT " +
                                " SUM(TLD_G_HP10) Z21, SUM(TLD_N_HP10)  Z22, SUM(TLD_G_HP3)   Z25, SUM(TLD_N_HP3)   Z26, "  +
                                " SUM(TLD_B_HP3)  Z27, SUM(TLD_G_HP007) Z31, SUM(TLD_N_HP007) Z32, SUM(TLD_B_HP007) Z33, "  +
                                " SUM(TLD_G_HP10_DOWN) Z37, SUM(TLD_N_HP10_DOWN) Z38 "  + //, SUM(TLD_B_HP10_DOWN) Z39
                                " FROM EXT_DOSE WHERE " +

                                " ID_PERSON IN (" + list_Persons.id_currentPerson  + ")"
                                /// если отбор по датам то последнюю строку заменить на:
//                                " ID_PERSON IN (" + list_Persons.id_currentPerson  + ") AND " +
//                                " BURN_DATE >= TO_DATE('" + date_begin + "','DD/MM/YY') AND"  +
//                                " BURN_DATE <= TO_DATE('" + date_end   + "','DD/MM/YY') ";
                        Query1.setQueryAndName(query, "getMainPersonParam1");


                        query = " SELECT " +
                                " SUM(EPD_G_HP10) Z23, SUM(EPD_N_HP10)  Z24, SUM(EPD_G_HP3)   Z28, SUM(EPD_N_HP3)   Z29, "  +
                                " SUM(EPD_B_HP3)  Z30, SUM(EPD_G_HP007) Z34, SUM(EPD_N_HP007) Z35, SUM(EPD_B_HP007) Z36, "  +
                                " SUM(EPD_G_HP10_DOWN) Z40, SUM(EPD_N_HP10_DOWN) Z41 " +
                                " FROM OP_DOSE WHERE " +

                                " ID_PERSON IN (" + list_Persons.id_currentPerson  + ") "
                                /// если отбор по датам то последнюю строку заменить на:
//                                " ID_PERSON IN (" + list_Persons.id_currentPerson  + ") AND "  +
//                                " TIME_OUT >= TO_DATE('" + date_begin + "','DD/MM/YY')  AND "  +
//                                " TIME_OUT <= TO_DATE('" + date_end   + "','DD/MM/YY') ";
                        Query1.setQueryAndName(query, "getMainPersonParam2");


                        stop();
                     }
                }


            }

            /// кнопка добавить нового сотрудника
            Rectangle {
                id: button_Add
                //visible: frame_listAllPersons.isOpen ? true : false
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 20
                anchors.rightMargin: 30 //360
                property string mainColor: "#8BC34A" // "white" //"transparent"
                width: 50
                height: 50
                radius: 50
                color: mainColor
                //opacity: 0.7

                Rectangle {
                    id: txt_AddINFO
                    property bool open: false
                    property var width_: width
                    //visible: false
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    property string mainColor: "#8BC34A" // "white" //"transparent"
                    //width: 300
                    radius: parent.radius
                    color: mainColor
                    opacity: 0.9
                    onWidthChanged: {
                        if ( txt_AddINFO.width >= 260 ) { txt_txt_AddINFO.visible = true;  }
                        else                            { txt_txt_AddINFO.visible = false; }

//                        if ( txt_AddINFO.width == 0 )  { button_Add.opacity = 0.7 }
//                        else                           { button_Add.opacity = 1.0 }

                    }

                    onOpenChanged: {
                        console.log("onVisibleChanged:", visible, " ", width_)
                        animation_txt_AddINFO.stop();
                        //animation_txt_AddINFO.running = false;
                        animation_txt_AddINFO.startValue = txt_AddINFO.open ? 0   : width_
                        animation_txt_AddINFO.endValue   = txt_AddINFO.open ? 280 : 0
                        animation_txt_AddINFO.running = true;
                    }

                    Text {
                        id: txt_txt_AddINFO
                       // anchors.centerIn: parent
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        text: qsTr("Добавить сотрудника")
                        font.pixelSize: 18
                        font.bold: true
                        color: "white" //"LightGray"
                        //visible: (txt_AddINFO.width >= 260) ? true : false
                    }

                    NumberAnimation {
                        id: animation_txt_AddINFO
                        property int startValue
                        property int endValue
                        easing.type: Easing.OutCirc
                        target: txt_AddINFO
                        running: false//txt_AddINFO.visible
                        properties: "width"
                        //easing.type: Easing.InOutElastic
                        from: startValue
                        to:   endValue
                        duration: 500
                    }

                }

                Rectangle {
                    id: button_Add_bord
                    //anchors.fill: parent
                    anchors.centerIn: parent
                    height: parent.height + 4
                    width:  parent.width  + 4
                    color: "transparent"
                    radius: 50
                    border.color: "white"
                    border.width: 2
                    visible: false
                }

                Text {
                    id: txt_button_Add
                    //anchors.centerIn: parent
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 10
                    anchors.topMargin: -4
                    font.pixelSize: 42
                    color: "white" //"LightGray"
                    text: qsTr("+") //✓ ⟳ ☺ 😐
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered:  {
                        var rightMargin  = parent.anchors.rightMargin
                        var bottomMargin = parent.anchors.bottomMargin
                        //parent.opacity = 1
                        parent.width = 52; parent.height = 52;
                        parent.anchors.bottomMargin = bottomMargin - 1
                        parent.anchors.rightMargin  = rightMargin - 1
                        txt_button_Add.visible = false
//                        txt_button_Add.text = qsTr("☺")
                        txt_button_Add.font.pixelSize = 46
                        txt_button_Add.anchors.topMargin = -5
                        txt_AddINFO.open = true
                        button_Add_bord.visible = true
                    }
                    onExited:   {
                        var rightMargin  = parent.anchors.rightMargin
                        var bottomMargin = parent.anchors.bottomMargin
                        //parent.opacity = 0.7
                        parent.width = 50; parent.height = 50
                        parent.anchors.bottomMargin = bottomMargin + 1
                        parent.anchors.rightMargin  = rightMargin + 1
                        txt_button_Add.visible = true
//                        txt_button_Add.text = qsTr("+")
//                        txt_button_Add.anchors.rightMargin = 10
                        txt_button_Add.font.pixelSize = 42
                        txt_button_Add.anchors.topMargin = -4
                        txt_AddINFO.open = false
                        button_Add_bord.visible = false
                    }
                    onPressed:  { parent.color = "#cbf797" }
                    onReleased: { parent.color = parent.mainColor  }
                    onClicked:  {
                        //console.log("Click!");
                        popup_AddWorker.open()
                    }
                }



            }

        }

        /// поле с дополнительными параметрами поиска сотрудника
        Rectangle {
            id: rect_AdvancedSearch
            visible: frame_listAllPersons.isOpen ? true : false
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: allPersons.right
            anchors.right: parent.right
            anchors.leftMargin: space_margin
            color: "Transparent" //"#e8e8e8" // "#d1d1d1" // "#adadad"

            //border.color: "LightGray"

            Text {
                id: heder_AdvancedSearch
                visible: frame_listAllPersons.isOpen ? true : false
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Дополнительные параметры поиска")
                font.pixelSize: 15
                color: "#808080"
            }

            Column {
                //anchors.fill: parent
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: heder_AdvancedSearch.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 20

                Item {
                    width: 200
                    height: 50
                    Row {
                        spacing: 10
                        anchors.fill: parent
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        CheckBox {
                            id: checkBox_SEX
                            anchors.verticalCenter: parent.verticalCenter
                            Material.accent: Material.Green //Material.Purple
//                            Material.primary: Material.Purple
//                            Material.foreground: Material.Purple
                            text: qsTr("Пол")
                            checked: false
//                            onCheckedChanged: {
//                                if ( checked ) {

//                                }
//                            }
                        }
                        ComboBox {
                            id: comboBox_SEX
                            enabled: (checkBox_SEX.checked) ? true : false
                            anchors.verticalCenter: parent.verticalCenter
                            width: 100
                            model: [ "М", "Ж" ]
                        }
                    }
                }
                Item {
                    width: 200
                    height: 50
                    Row {
                        anchors.fill: parent
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        CheckBox {
                            id: checkBox_BIRTH_DATE
                            Material.accent: Material.Green
                            anchors.verticalCenter: parent.verticalCenter
                            text: qsTr("Год рождения") //qsTr("Дата рождения")
                            checked: false
                        }
                        ComboBox {
                            id: comboBox_YEAR_DATE
                            enabled: (checkBox_BIRTH_DATE.checked) ? true : false
                            anchors.verticalCenter: parent.verticalCenter
                            width: 100
                            model: //[ "2019", "2018" ]
                            {
                                var years = [];
                                var thisYear = new Date().getFullYear();
                                for(var i_year = thisYear; i_year > 1900; i_year --) {
                                    years.push(i_year);
                                }
                                return years;
                            }
                        }
//                        MyCalendar {
//                            id: myCalendar_BIRTH_DATE
//                            enabled: (checkBox_BIRTH_DATE.checked) ? true : false
//                            date_val: new Date()
//                        }
                    }
                }
                Item {
                    width: 200
                    height: 50
                    Row {
                        anchors.fill: parent
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        CheckBox {
                            id: checkBox_STAFF_TYPE
                            Material.accent: Material.Green
                            anchors.verticalCenter: parent.verticalCenter
                            text: qsTr("Тип персонала")
                            checked: false
                           }
                        ComboBox {
                            id: comboBox_STAFF_TYPE
                            enabled: (checkBox_STAFF_TYPE.checked) ? true : false
                            anchors.verticalCenter: parent.verticalCenter
                            width: 180
                            model: [ "Персонал АЭС", "Командировочный" ]
                        }
                    }

                }                
                Item {
                    width: 200
                    height: 50
                    Row {
                        anchors.fill: parent
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        CheckBox {
                            id: checkBox_ASSIGNEMENT
                            Material.accent: Material.Green
                            anchors.verticalCenter: parent.verticalCenter
                            text: qsTr("Должность")
                            checked: false
                        }
                        ComboBox {
                            id: comboBox_ASSIGNEMENT
                            enabled: (checkBox_ASSIGNEMENT.checked) ? true : false
                            anchors.verticalCenter: parent.verticalCenter
                            width: 160
                            model: main_.model_adm_assignment
                            textRole: "ASSIGNEMENT"
                        }
                    }
                }

                Item {
                    width: 200
                    height: 50
                    Row {
                        anchors.fill: parent
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        CheckBox {
                            id: checkBox_DEPARTMENT // ??? _OUTER _INNER
                            Material.accent: Material.Green
                            anchors.verticalCenter: parent.verticalCenter
                            text: qsTr("Подразделение")
                            checked: false

                            enabled: false
                        }
                        ComboBox {
                            id: comboBox_DEPARTMENT
                            enabled: (checkBox_DEPARTMENT.checked) ? true : false
                            anchors.verticalCenter: parent.verticalCenter
                            width: 160
                            model: [""]
                        }
                    }
                }




            }

        }

        /// кнопка развернуть список
        Rectangle {
            id: button_openPersonsList
            anchors.fill: parent
            color: "transparent"
//            visible: (frame_listAllPersons.width === frame_listAllPersons.widthClose) ? true : false
            visible: (frame_listAllPersons.width <= frame_listAllPersons.widthClose + 50) ? true : false
            border.color: "LightGray"
            Text {
                id: name
                anchors.centerIn: parent
                text: qsTr("РАСКРЫТЬ СПИСОК СОТРУДНИКОВ")
                font.bold: true
                font.pixelSize: 18
                color: "#808080"
                rotation: -90
            }
            MouseArea {
                enabled: frame_listAllPersons.isOpen ? false : true
                anchors.fill: parent
                hoverEnabled: true
                onEntered:  { parent.color = "#dbdbdb" }  // parent.color =  "#cbf797"
                onExited:   { parent.color = "transparent" }
                onPressed:  { parent.color = "white" }
                onReleased: { parent.color = "transparent"  }
                onClicked:  {
                    console.log("Click!");
                    frame_listAllPersons.isOpen = true;
                }
            }

        }

    }

    /// СОТРУДНИК
    Pane {
        id: frame_who
        anchors.left: frame_listAllPersons.right
        //anchors.leftMargin: frame_listAllPersons.isOpen ? 250 : space_margin
        //anchors.right: frame_listAllPersons.isOpen ? undefined : parent.right
        anchors.top: frame_headerPersons.bottom
        anchors.margins: space_margin


//        width: (txt_fio.width > 300) ? (frame_listAllPersons.isOpen ? (txt_fio.width + 250) : false) : 550


        width: (txt_fio.width > 300) ? (txt_fio.width + 250) : 550
        //width: frame_listAllPersons.isOpen ? ( (txt_fio.width > 300) ? (txt_fio.width + 250) : 550 ) : false

        Material.elevation: 4

        padding: 1
        topPadding: 1
        bottomPadding: 1

        height: 160 //implicitContentHeight
        //width: 670


//        background: Rectangle {
//            anchors.fill: parent
//            color: "White" // "#eaeaea" //"#d6d6d6"//"White"
//            border.color: "#9E9E9E" //"LightGray"
//            radius: 7
//        }

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
                            color: Material.color(Material.DeepOrange)
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
                                    color: "#808080"
                                }
                                Text {
                                    text: "№ ТЛД"
                                    //anchors.right: parent.right
                                    font.pixelSize: 14
                                    color: "#808080"
                                }
                                Text {
                                    text: "Тип персонала"
                                    //anchors.right: parent.right
                                    font.pixelSize: 14
                                    color: "#808080"
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
//                                Text {
//                                    id: txt_status
//                                    text: ".."//"Работал весь отчетный год"
//                                    font.pixelSize: 14
//                                    color: "darkslategrey"
//                                }
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


    /// ДАННЫЕ О ПРЕВЫШЕНИИ ПОКАЗАТЕЛЕЙ СОТРУДНИКА
    Frame {
        id: frame_MainParamsPerson
//        anchors.left: frame_listAllPersons.right
//        anchors.leftMargin: frame_listAllPersons.isOpen ? 100 : space_margin
//        anchors.right: frame_listAllPersons.isOpen ? undefined : parent.right
//        anchors.top: frame_headerPersons.bottom
//        anchors.margins: space_margin

        anchors.left: frame_listAllPersons.right
//        anchors.leftMargin: frame_listAllPersons.isOpen ? 100 : space_margin
        //anchors.right: frame_listAllPersons.isOpen ? undefined : parent.right
        anchors.top: frame_who.bottom
        anchors.margins: space_margin + 10
        width:  frame_listAllPersons.isOpen ? 500 : false  ///300
        visible: frame_listAllPersons.isOpen ? true : false


        padding: 1
        topPadding: 1
        bottomPadding: 1

        height: 150 //implicitContentHeight
        //width: 670


        background: Rectangle {
            anchors.fill: parent
            color: "Transparent" // "#eaeaea" //"#d6d6d6"//"White"
            //border.color: "#9E9E9E" //"LightGray"
            //radius: 7
        }

        Item {
            anchors.fill: parent

            Column {
                anchors.fill: parent
                spacing: 10
                padding: 10
                leftPadding: 20

                Row {
                    Text {
                        text: qsTr("Эффективная доза:  ")
                        color: "#808080"
                        font.pixelSize: 14
                    }
                    Text {
                        id: txt_mainParams1
                        text: qsTr("0")
                        color: (text < 50) ? "#808080" : "red" // <50 - Норма
                        font.pixelSize: 14
                        font.bold: true
                    }
                    Text {
                        visible: (txt_mainParams1.text < 50) ? false : true
                        text: {
                            var str = " (!) Превышение ";
                            str = str + (txt_mainParams1.text - 50)

                            str = " (!) "
                            return qsTr(str)
                        }
                        color: (text < 150) ? "#808080" : "red" // <150 - Норма
                        font.pixelSize: 14
                        font.bold: true
                    }
//                    Rectangle {
//                        width: 1
//                        height: 130
//                        color: "LightGray"
//                    }
                }

                Row {
                    Text {
                        text: qsTr("Эквивалентная доза облучения хрусталика глаза:  ")
                        color: "#808080"
                        font.pixelSize: 14
                    }
                    Text {
                        id: txt_mainParams2
                        text: qsTr("--")
                        color: (text < 150) ? "#808080" : "red" // <150 - Норма
                        font.pixelSize: 14
                        font.bold: true
                    }
                    Text {
                        visible: (txt_mainParams2.text < 150) ? false : true
                        text: {
                            var str = " (!) Превышение ";
                            str = str + (txt_mainParams2.text - 150)

                            str = " (!) "
                            return qsTr(str)
                        }
                        color: (text < 150) ? "#808080" : "red" // <150 - Норма
                        font.pixelSize: 14
                        font.bold: true
                    }
                }

                Row {
                    Text {
                        text: qsTr("Эквивалентная доза облучения кожи:  ")
                        color: "#808080"
                        font.pixelSize: 14
                    }
                    Text {
                        id: txt_mainParams3
                        text: qsTr("--")
                        color: (text < 500) ? "#808080" : "red" // <500 - Норма
                        font.pixelSize: 14
                        font.bold: true
                    }
                    Text {
                        visible: (txt_mainParams3.text < 500) ? false : true
                        text: {
                            var str = " (!) Превышение ";
                            str = str + (txt_mainParams3.text - 500)

                            str = " (!) "
                            return qsTr(str)
                        }
                        color: (text < 150) ? "#808080" : "red" // <150 - Норма
                        font.pixelSize: 14
                        font.bold: true
                    }
                }

                Row {
                    Text {
                        text: qsTr("Месячная эквивалентная доза  \nна поверхности нижней части области живота женщин  \nв возрасте до 45 лет:  ")
                        color: "#808080"
                        font.pixelSize: 14
                    }
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        id: txt_mainParams4
                        text: qsTr("--")
                        color: (text < 1) ? "#808080" : "red" // <1 - Норма
                        font.pixelSize: 14
                        font.bold: true
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
                        color: (text < 150) ? "#808080" : "red" // <150 - Норма
                        font.pixelSize: 14
                        font.bold: true
                    }
                }

            }

        }


        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: -30
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 70
            color: "Transparent"
            border.color: "#9E9E9E"

            Text {
                anchors.bottom: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 3
                text: qsTr("Порог")
                font.pixelSize: 12
                font.bold: true
                color: "#808080"
            }
            Column {
                anchors.fill: parent
                spacing: 10
                padding: 10
                leftPadding: 20
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("50")
                    font.pixelSize: 14
                    font.bold: true
                    color: "#808080"
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("150")
                    font.pixelSize: 14
                    font.bold: true
                    color: "#808080"
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("500")
                    font.pixelSize: 14
                    font.bold: true
                    color: "#808080"
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("\n1")
                    font.pixelSize: 14
                    font.bold: true
                    color: "#808080"
                }

            }





        }

    }

    /// КНОПКА ОТОБРАЗИТЬ БОЛЬШЕ ДАННЫХ О ВЫБРАННОМ СОТРУДНИКЕ
    Rectangle {
        id: button_openMoreInfo
        visible: frame_listAllPersons.isOpen ? true : false
        anchors.top: frame_MainParamsPerson.bottom
        anchors.left: frame_listAllPersons.right
        anchors.right: parent.right
        anchors.margins: space_margin
        height: 60
        border.color:  "#9E9E9E"
        radius: 30

        Text {
            anchors.centerIn: parent
            text: qsTr("ОТОБРАЗИТЬ БОЛЬШЕ ДАННЫХ")
            font.pixelSize: 18
            font.bold: true
            color: "#808080"
        }
        MouseArea {
            enabled: frame_listAllPersons.isOpen ? true : false
            anchors.fill: parent
            hoverEnabled: true
            onEntered:  { parent.color = "#dbdbdb" } //parent.color = "#cbf797"
            onExited:   { parent.color = "transparent" }
            onPressed:  { parent.color = "white" }
            onReleased: { parent.color = "transparent"  }
            onClicked:  {
                console.log("Click!");
                frame_listAllPersons.isOpen = false;
            }
        }

    }

    /// ВКЛАДКИ С ПОДРОБНЫМИ ДАННЫМИ О СОТРУДНИКЕ
    Frame {
        id: frame_tabbar
        visible: frame_listAllPersons.isOpen ? false : true
        anchors.left: frame_listAllPersons.right
        anchors.top: frame_who.bottom  //frame_dose_summary.bottom
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
                text: "Информация о работе"
                width: implicitWidth
                //enabled: false
            }
            TabButton {
                text: "Персональная информация"
                width: implicitWidth

            }
            TabButton {
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
//                    Row {
//                        spacing: 5
//                        Label {
//                            text: "Дознаряд:"
//                        }
//                        Rectangle {
//                            width: 150
//                            height: 20
//                            color: Material.color(Material.Lime)
//                            Label {
//                                id: doznarad_position
//                                anchors.centerIn: parent
//                                font.bold: true
//                                color: Material.color(Material.Teal)
//                            }

//                        }
//                    }

                    Row {
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        spacing: 20
                        Column {
                            spacing: 5
                            Label {
                                text: "Организация"
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

                        model: model_perosn

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
                                            color: textData_color //Material.color(Material.Teal)
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
                                            color: textData_color // Material.color(Material.Teal)
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
                                            color: textData_color //Material.color(Material.Teal)
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
                                        color: "Black"
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
//                            Rectangle {
//                                height: wtab2_passport.heightAll
//                                width:  400
//                                //border.color: "LightGray"
//                                Column {
//                                    spacing: 5
//                                    Label {
//                                        text: "Данные медицинского полиса"
//                                        verticalAlignment: Text.AlignVCenter
//                                        height: 25
//                                        font.pixelSize: wtab2_passport.sizeHeader
//                                        color: "Black"
//                                        leftPadding: 10
//                                    }
//                                    Rectangle {
//                                        height: 1
//                                        width: 400
//                                        color: "LightGray"
//                                    }
//                                    Row {
//                                        leftPadding: 10
//                                        spacing: 5

//                                        Label {
//                                            text: "Номер:"
//                                            font.pixelSize: wtab2_passport.sizeTxt
//                                        }
//                                        TextEdit {
//                                            id: txt_medical_number
//                                            font.pixelSize: wtab2_passport.sizeTxt
//                                            font.bold: true
//                                            color: Material.color(Material.Teal)
//                                            selectByMouse: true
//                                            selectionColor: Material.color(Material.Red)
//                                        }

//                                        Label {
//                                            leftPadding: 10
//                                            text: "Серия:(снилс)"
//                                            font.pixelSize: wtab2_passport.sizeTxt
//                                        }
//                                        TextEdit  {
//                                            id: txt_medical_series
//                                            font.pixelSize: wtab2_passport.sizeTxt
//                                            font.bold: true
//                                            color: Material.color(Material.Teal)
//                                            selectByMouse: true
//                                            selectionColor: Material.color(Material.Red)
//                                        }

//                                    }
//                                }
//                            }

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
                                                color: textData_color // Material.color(Material.Teal)
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
                                                color: textData_color // Material.color(Material.Teal)
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
                                                color: textData_color //Material.color(Material.Teal)
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
                                                color: textData_color // Material.color(Material.Teal)
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
                Pane {
                    id: wtab3_doze
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
//                   Column {
//                       spacing: 20
//                       Row {
//                           spacing: 30
//                           Column {
//                               Text {
//                                   text: "Дата постановки на учет"
//                                   font.pixelSize: 14
//                               }
//                               TextEdit {
//                                   id: nw_date_on
//                                   font.bold: true
//                                   color: Material.color(Material.Teal)
//                                   selectByMouse: true
//                                   selectionColor: Material.color(Material.Red)
//                                   text: "---"
//                                   font.pixelSize: 15
//                                   //horizontalAlignment: Text.AlignHCenter
////                                   onTextEdited: {
////                                       if (text.length === 1) text = text.toUpperCase()
////                                   }
//                               }
//                           }
//                           Column {
//                               Text {
//                                   text: "Дата снятия с учета"
//                                   font.pixelSize: 14
//                               }
//                               TextEdit {
//                                   id: nw_date_off
//                                   font.bold: true
//                                   color: Material.color(Material.Teal)
//                                   selectByMouse: true
//                                   selectionColor: Material.color(Material.Red)
//                                   text: "---"
//                                   font.pixelSize: 15
//                                   //horizontalAlignment: Text.AlignHCenter
////                                   onTextEdited: {
////                                       if (text.length === 1) text = text.toUpperCase()
////                                   }
//                               }
//                           }
//                       }

//                       Rectangle {
//                           height: 1
//                           width: 400
//                           color: "LightGray"
//                       }

//                       Column {
//                           spacing: 20
//                           Row {
//                               spacing: 10
//                               Item {
//                                   height: parent.height
//                                   width: 180
//                                   Text {
//                                       text: "Доза до АЭС"
//                                       font.pixelSize: 14
//                                   }
//                               }

//                               TextEdit {
//                                   id: nw_dose_before_npp
//                                   font.bold: true
//                                   color: Material.color(Material.Teal)
//                                   selectByMouse: true
//                                   selectionColor: Material.color(Material.Red)
//                                   text: "---"
//                                   font.pixelSize: 16
//                                   //horizontalAlignment: Text.AlignHCenter
////                                   onTextEdited: {
////                                       if (text.length === 1) text = text.toUpperCase()
////                                   }
//                               }
//                               Text {
//                                   text: qsTr("мЗв")
//                                   font.pixelSize: 14
//                               }
//                           }
//                           Row {
//                               spacing: 10
//                               Item {
//                                   height: parent.height
//                                   width: 180
//                                   Text {
//                                       text: "Доза, полученная на ЧАЭС"
//                                       font.pixelSize: 14
//                                   }
//                               }
//                               TextEdit {
//                                   id: nw_dose_chnpp
//                                   font.bold: true
//                                   color: Material.color(Material.Teal)
//                                   selectByMouse: true
//                                   selectionColor: Material.color(Material.Red)
//                                   text: "---"
//                                   font.pixelSize: 16
//                                   //horizontalAlignment: Text.AlignHCenter
////                                   onTextEdited: {
////                                       if (text.length === 1) text = text.toUpperCase()
////                                   }
//                               }
//                               Text {
//                                   text: qsTr("мЗв")
//                                   font.pixelSize: 14
//                               }
//                           }
//                       }

//                       Rectangle {
//                           height: 1
//                           width: 400
//                           color: "LightGray"
//                       }

//                       Row {
//                           spacing: 30
//                           Column {
//                               Text {
//                                   text: "Годовой ИКУ, мЗв"
//                                   font.pixelSize: 14
//                               }
//                               TextEdit {
//                                   id: nw_iku_year
//                                   font.bold: true
//                                   color: Material.color(Material.Teal)
//                                   selectByMouse: true
//                                   selectionColor: Material.color(Material.Red)
//                                   text: "---"
//                                   font.pixelSize: 15
//                                   //horizontalAlignment: Text.AlignHCenter
////                                   onTextEdited: {
////                                       if (text.length === 1) text = text.toUpperCase()
////                                   }
//                               }
//                           }
//                           Column {
//                               Text {
//                                   text: "Месячный ИКУ, мЗв"
//                                   font.pixelSize: 14
//                               }
//                               TextEdit {
//                                   id: nw_iku_month
//                                   font.bold: true
//                                   color: Material.color(Material.Teal)
//                                   selectByMouse: true
//                                   selectionColor: Material.color(Material.Red)
//                                   text: "---"
//                                   font.pixelSize: 15
//                                   //horizontalAlignment: Text.AlignHCenter
////                                   onTextEdited: {
////                                       if (text.length === 1) text = text.toUpperCase()
////                                   }
//                               }
//                           }
//                       }

//                       Rectangle {
//                           height: 1
//                           width: 400
//                           color: "LightGray"
//                       }




//                   }


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




}
