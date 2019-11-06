import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

Page {
    id: page_d1
    visible: true
    //property int space_margin: 15
    //    width: 1200
    //    height: 800

    Component.onCompleted: console.log("CurrentControl  completed")

    /// панель навигации (боковая слева)
    Pane {
        id: frame1
        //wheelEnabled: true
        width: 300
        anchors.margins: 0//8
        anchors.left: parent.left
        anchors.top: top_panel.bottom
        anchors.bottom: parent.bottom
        padding: 0

        background: Rectangle {
            anchors.fill: parent
            color: Material.color(Material.Grey, Material.Shade800)
        }

        /// список с основными вкладками для переключения основных страниц программы
        MyListViewUnfolding_v2 {
            anchors.fill: parent
            anchors.topMargin: 10

            model:
                ListModel {

                /// header: "имя заголовка not fold"  - блокирует сворачивание списка для данного заголовка

                //ListElement { image:"icons/face.svg"; name: "Выбор сотрудника 2";   header: "" } ///Карточка работника
//                ListElement { image:"icons/face.svg"; name: "Выбор сотрудника";   header: "" }
                ListElement { image:"icons/face.svg"; name: "Карточка";               header: "Сотрудники" }
                ListElement { image:"";               name: "Добавить сотрудника";    header: "Сотрудники" }
                ListElement { image:"";               name: "Ввод доз ТЛД";           header: "Сотрудники" }
                ListElement { image:"";               name: "СИЧ";                    header: "Сотрудники" }

                //ListElement { image:""; name: "Новый сотрудник";    header: "" }


                ListElement { image:""; name: "SQL запросы";        header: "Отчеты" } //Отчеты not fold
                ListElement { image:""; name: "Накопленные дозы";   header: "Отчеты" }
                ListElement { image:""; name: "Отчет № 1-ДОЗ";      header: "Отчеты" }

                ListElement { image:""; name: "Типы дозиметров";    header: "Справочник" } //Справочная информация
                ListElement { image:""; name: "Дозиметры";          header: "Справочник" }
                ListElement { image:""; name: "Касетницы";          header: "Справочник" }
                ListElement { image:""; name: "Зоны контроля";      header: "Справочник" }
                ListElement { image:""; name: "Подразделения";      header: "Справочник" }

                ListElement { image:""; name: "Тесты";      header: "Временное" }
                ListElement { image:""; name: "Тест системы подлючений";      header: "Временное" }
                }

//            onCurrentName: {
//                //if(name === "Касетница") { stackview_mainwindow.replace(".qml")
//                if(name === "Карточка работника") { stackview_mainwindow.replace("WorkersCard.qml") }
//                else {stackview_mainwindow.replace("TestPage.qml")}
//            }

            onCurrentName: {
                changePage(name)
                /// запуск основной функции старицы (обновление модели выбранного сотрудника)
                //functions.main_fun(variables.id_currentPerson);
            }
        }

    }

    /// функция смены страницы
    function changePage(name) {
        //var namePage
        pageNotVisible();
        switch(name) {
//        case "Выбор сотрудника": //Карточка работника
//            console.log("name = ", name);
//            namePage = "WorkersCard.qml";
//            //workerCard.visible = true;
//            break;

//        case "Выбор сотрудника": //Карточка работника
//            console.log("name = ", name);
//            persons.visible = true;

//            /// обновление моделей
//            //models.model_ext_person_list.updateModel()
//            models.model_adm_status.updateModel()
//            models.model_adm_assignment.updateModel()
//            models.model_adm_organisation.updateModel()
//            models.model_adm_department_outer.updateModel()
//            models.model_adm_department_inner.updateModel()

//            break;

        case "Карточка": //Карточка работника
            console.log("name = ", name);
            persons.visible = true;

            /// функции с запросами к БД о данных выбранного сотрудника
            functions.updatePersonModel(variables.id_currentPerson);
            functions.getPersonPhoto(variables.id_currentPerson);
            functions.getPersonParameters(variables.id_currentPerson,
                                          persons.date_begin.toLocaleDateString("ru_RU", "dd.MM.yyyy"),
                                          persons.date_end.toLocaleDateString("ru_RU", "dd.MM.yyyy")   );


            break;

        case "Добавить сотрудника":
            console.log("name = ", name);
            addPerson.visible = true;

            /// обновление моделей
            models.model_adm_status.updateModel();
            models.model_adm_assignment.updateModel();
            models.model_adm_organisation.updateModel();
            models.model_adm_department_outer.updateModel();
            models.model_adm_department_inner.updateModel();

            break;

        case "Ввод доз ТЛД":
            console.log("name = ", name);
            //namePage = "InputDoseTLD.qml";
            inputDoseTLD.visible = true;
            functions.getBurnDate(variables.id_currentPerson)
            break;

        case "СИЧ":
            console.log("name = ", name);
            sich.visible = true;
            functions.getResultsSICH(variables.id_currentPerson);
            break;

        case "SQL запросы":
            console.log("name = ", name);
            reports.visible = true; //namePage = "Report_1DOZ.qml";

            /// обновление моделей
            models.model_SQLQiueries.updateModel()
            models.model_tableReports.updateModel()

            break;

        case "Накопленные дозы":
            console.log("name = ", name);
            report_AccumulatedDose.visible = true; //namePage = "Report_AccumulatedDose.qml";
            functions.getPersonPhoto(variables.id_currentPerson);
            break;

        case "Отчет № 1-ДОЗ":
            console.log("name = ", name);
            report_1DOZ.visible = true; //namePage = "Report_1DOZ.qml";
            break;

        case "Тесты":
            console.log("name = ", name);
            testPage.visible = true;
            break;
        case "Тест системы подлючений":
            console.log("name = ", name);
            testCSPage.visible = true;
            break;

        default:
            console.log("name = ", name);
            emptyPage.visible = true;
            break;
        }
    }
    /// функция скрывания страниц
    function pageNotVisible(){
        //workerCard.visible             = false
        persons.visible                = false
        addPerson.visible              = false
        inputDoseTLD.visible           = false
        sich.visible                   = false
        report_AccumulatedDose.visible = false
        report_1DOZ.visible            = false
        reports.visible                = false
        testPage.visible               = false
        testCSPage.visible             = false

        emptyPage.visible              = false
    }


    /////////////////////////////////////////////////////////
    /// (!) /////////////////////////////////////////////////

    /// набор моделей
    Item {
        id: models

        property var model_person:  managerDB.createModel("", "m__select_person")

        property var model_ext_person_list:      managerDB.createModel(" SELECT ID_PERSON, W_NAME, W_SURNAME, W_PATRONYMIC, PERSON_NUMBER, ID_TLD FROM EXT_PERSON ORDER BY W_SURNAME", "m__ext_person_list" )

        //property var doseModel: managerDB.createModel(" ")

        property var model_adm_status:           managerDB.createModel(" SELECT STATUS_CODE, STATUS  FROM ADM_STATUS ",                        "m__adm_status")
        property var model_adm_assignment:       managerDB.createModel(" SELECT ID, ASSIGNEMENT      FROM ADM_ASSIGNEMENT ",                   "m__adm_assignment")
        property var model_adm_organisation:     managerDB.createModel(" SELECT ID, ORGANIZATION_    FROM ADM_ORGANIZATION ",                  "m__adm_organisation")
        property var model_adm_department_outer: managerDB.createModel(" SELECT ID, DEPARTMENT_OUTER FROM ADM_DEPARTMENT_OUTER WHERE ID = 0 ", "m__adm_department_outer")
        property var model_adm_department_inner: managerDB.createModel(" SELECT ID, DEPARTMENT_INNER FROM ADM_DEPARTMENT_INNER ",              "m__adm_department_inner")

        property var model_SQLQiueries:  managerDB.createModel(" SELECT ID, DOCX, DOCM, REPORTNAME, SQL, DESCRIPTION FROM REPORTS ", "m__rep_sqlqueries") //" SELECT ID, SQLQUERY, DESCRIPTION FROM REP_SQLQUERIES ", "rep_sqlqueries"
        property var model_tableReports: managerDB.createModel("", "m__tableReports")

        //property var model_sich: managerDB.createModel("  ", "sich")
        property var model_adm_nuclide: managerDB.createModel(" SELECT ID, NUCLIDE, MUSNUMBER, DECAY_TYPE, ENERGY  FROM ADM_NUCLIDE ", "m__nuclide")
        property var model_adm_nuclide_I: managerDB.createModel(" SELECT ID, NUCLIDE, MUSNUMBER, DECAY_TYPE, ENERGY  FROM ADM_NUCLIDE WHERE NUCLIDE = 'I'", "m__nuclide")


        /// обновить все модели
        function updateAllModels() {
            model_person.updateModel();
            model_ext_person_list.updateModel();
            model_adm_status.updateModel();
            model_adm_assignment.updateModel();
            model_adm_organisation.updateModel();
            model_adm_department_outer.updateModel();
            model_adm_department_inner.updateModel();

            model_SQLQiueries.updateModel();
            model_tableReports.updateModel();

            model_adm_nuclide.updateModel();
        }

    }

    /// набор функций с SQL запросами и моделями БД
    Item {
        id: functions

        /// ФУНКЦИИ ВЫЗЫВАЮЩАЯ ОСТАЛЬНЫЕ ФУНКЦИИ (обновление данных интерфейса) В ЗАВИСИМОСТИ ОТ ОТКРЫТОЙ СТРАНИЦЫ:
        /// SQL запросы
        function main_fun(id_person) {
            if (id_person == undefined) return false;

            if ( persons.visible ) {
                functions.getPersonPhoto(id_person);
                functions.getPersonParameters(id_person,
                                              persons.date_begin.toLocaleDateString("ru_RU", "dd.MM.yyyy"),
                                              persons.date_end.toLocaleDateString("ru_RU", "dd.MM.yyyy"));
            }
            if ( inputDoseTLD.visible ) {
                functions.getBurnDate(id_person);
            }
            if ( sich.visible ) {
                functions.getResultsSICH(id_person);
            }
            if ( reports.visible ) {}
            if ( report_1DOZ.visible ) {}
            if ( report_AccumulatedDose.visible ) {
                functions.getPersonPhoto(id_person);
            }

        }


        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////

        /// ФУНКЦИИ ПОЛУЧЕНИЯ ДАНЫХ О ВЫБРАННОМ СОТРУДНИКЕ:

        /// модель ( model_person ) задает запрос в бд на данные о сотруднике по его ID_PERSON
        function updatePersonModel(id_person){
            if (id_person == undefined) return false;
            models.model_person.query = " SELECT
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

        /// функция запроса о ФОТО сотрудника из БД ( "q1__pullOutPhotoCurrentPerson" )
        function getPersonPhoto(id_person) {
            if (id_person == undefined) return false;
            var query = " SELECT PHOTO from EXT_PERSON WHERE ID_PERSON = " + id_person
            Query1.setQueryAndName(query, "q1__photoCurrentPerson");
        }

        /// функция запроса данных о ДОЗАХ сотрудника из БД ( "q1__getMainPersonParam1", "q1__getMainPersonParam2" )
        function getPersonParameters(id_person, date_begin, date_end) {
            if (id_person == undefined) return false;

//            /// создаем массив длинною в 64 индекса (в первом индексе хранятся параметры)
//            report.clearZ();
//            report.setTypeReport(64,1)

            var query;
            var now = new Date();
            //date_begin = new Date((now.getFullYear()-1),now.getMonth(),now.getDate()).toLocaleDateString("ru_RU", "dd.MM.yyyy");
            //date_end   = now.toLocaleDateString("ru_RU", "dd.MM.yyyy");

            query = " SELECT " +
                    " SUM(TLD_G_HP10) Z21, SUM(TLD_N_HP10)  Z22, SUM(TLD_G_HP3)   Z25, SUM(TLD_N_HP3)   Z26, "  +
                    " SUM(TLD_B_HP3)  Z27, SUM(TLD_G_HP007) Z31, SUM(TLD_N_HP007) Z32, SUM(TLD_B_HP007) Z33, "  +
                    " SUM(TLD_G_HP10_DOWN) Z37, SUM(TLD_N_HP10_DOWN) Z38 "  + //, SUM(TLD_B_HP10_DOWN) Z39
                    " FROM EXT_DOSE WHERE " +
                    /// если отбор без дат, то следующую строку
                    //" ID_PERSON IN (" + id_person  + ")" +
                    /// на строки
                    " ID_PERSON IN (" + id_person  + ") AND " +
                    " BURN_DATE >= TO_DATE('" + date_begin + "','DD/MM/YY') AND"  +
                    " BURN_DATE <= TO_DATE('" + date_end   + "','DD/MM/YY') ";
            Query1.setQueryAndName(query, "q1__getMainPersonParam1");


            query = " SELECT " +
                    " SUM(EPD_G_HP10) Z23, SUM(EPD_N_HP10)  Z24, SUM(EPD_G_HP3)   Z28, SUM(EPD_N_HP3)   Z29, "  +
                    " SUM(EPD_B_HP3)  Z30, SUM(EPD_G_HP007) Z34, SUM(EPD_N_HP007) Z35, SUM(EPD_B_HP007) Z36, "  +
                    " SUM(EPD_G_HP10_DOWN) Z40, SUM(EPD_N_HP10_DOWN) Z41 " +
                    " FROM OP_DOSE WHERE " +
                    /// если отбор без дат, то следующую строку
                    //" ID_PERSON IN (" + id_person  + ") "
                    /// заменить на строки
                    " ID_PERSON IN (" + id_person  + ") AND "  +
                    " TIME_OUT >= TO_DATE('" + date_begin + "','DD/MM/YY')  AND "  +
                    " TIME_OUT <= TO_DATE('" + date_end   + "','DD/MM/YY') ";
            Query1.setQueryAndName(query, "q1__getMainPersonParam2");


            ////////////////////////////////////////////////////////////////////////////////
            query = " SELECT " +
                    " (select ADM_DEPARTMENT_INNER.DEPARTMENT_INNER from ADM_DEPARTMENT_INNER WHERE ADM_DEPARTMENT_INNER.ID = ( select EXT_PERSON.ID_DEPARTMENT_INNER from EXT_PERSON where EXT_PERSON.ID_PERSON = " + id_person + " )) Z6, "               +
                    " (select ADM_ASSIGNEMENT.ASSIGNEMENT from ADM_ASSIGNEMENT where ADM_ASSIGNEMENT.ID = (select EXT_PERSON.ID_ASSIGNEMENT from EXT_PERSON where EXT_PERSON.ID_PERSON =  " + id_person + ")) Z7, "                                         +

                    " (select sum(IN_CONTROL.EXP_EFF_DOSE_C)   from IN_CONTROL where IN_CONTROL.ID_PERSON = " + id_person + " and DATE_TIME >= TO_DATE('" + date_begin + "','DD/MM/YY') and DATE_TIME <= TO_DATE('" + date_end  + "','DD/MM/YY') ) Z43, "   +
                    " (select sum(IN_MEASURE.EXP_EFF_DOSE_M)   from IN_MEASURE where IN_MEASURE.ID_PERSON = " + id_person + " and DATE_TIME >= TO_DATE('" + date_begin + "','DD/MM/YY') and DATE_TIME <= TO_DATE('" + date_end  + "','DD/MM/YY') )  Z44,"   +
                    " (select sum(IN_IODINE.EXP_EFF_DOSE_I)    from IN_IODINE  where IN_IODINE.ID_PERSON = " + id_person + " and DATE_TIME >= TO_DATE('" + date_begin + "','DD/MM/YY') and DATE_TIME <= TO_DATE('" + date_end  + "','DD/MM/YY') )  Z46, "   +
                    " (select sum(IN_CONTROL.ACTIVITY_CONTROL) from IN_CONTROL where IN_CONTROL.ID_PERSON = " + id_person + " and DATE_TIME >= TO_DATE('" + date_begin + "','DD/MM/YY') and DATE_TIME <= TO_DATE('" + date_end  + "','DD/MM/YY') ) Z48,"    +
                    " (select sum(ACTIVITY_MEASURE)            from IN_MEASURE where  ID_PERSON = " + id_person + " and DATE_TIME >= TO_DATE('" + date_begin + "','DD/MM/YY') and DATE_TIME <= TO_DATE('" + date_end  + "','DD/MM/YY') ) Z49, "             +
                    " (select sum(IN_MEASURE.ACTIVITY_MEASURE) from IN_MEASURE where IN_MEASURE.ID_PERSON = " + id_person + " and DATE_TIME >= TO_DATE('" + date_begin + "','DD/MM/YY') and DATE_TIME <= TO_DATE('" + date_end  + "','DD/MM/YY') ) Z54, "   +
                    " (select sum(IN_IODINE.ACTIVITY_IODINE)   from IN_IODINE  where IN_IODINE.ID_PERSON = " + id_person + " and DATE_TIME >= TO_DATE('" + date_begin + "','DD/MM/YY') and DATE_TIME <= TO_DATE('" + date_end  + "','DD/MM/YY') ) Z55, "     +
                    " (select sum(IN_MEASURE.ACTIVITY_MEASURE) from IN_MEASURE where ((select ADM_NUCLIDE.NUCLIDE from ADM_NUCLIDE where ADM_NUCLIDE.ID = IN_MEASURE.NUCLIDE) != 'Co' or (select ADM_NUCLIDE.NUCLIDE from ADM_NUCLIDE where ADM_NUCLIDE.ID = IN_MEASURE.NUCLIDE) is null) and IN_MEASURE.ID_PERSON = " + id_person +" and DATE_TIME >= TO_DATE('" + date_begin + "','DD/MM/YY') and DATE_TIME <= TO_DATE('" + date_end  + "','DD/MM/YY') ) Z59 " +

                    " FROM EXT_PERSON  " +
//                    " LEFT JOIN IN_CONTROL ON EXT_PERSON.ID_PERSON = IN_CONTROL.ID_PERSON  " +
//                    " LEFT JOIN IN_MEASURE ON EXT_PERSON.ID_PERSON = IN_MEASURE.ID_PERSON  " +
                    " WHERE EXT_PERSON.ID_PERSON = " + id_person  +
                    " GROUP BY EXT_PERSON.ID_PERSON "

            Query1.setQueryAndName(query, "q1__getMainPersonParam3");

//            //////////////////////////////////////////////////////////////////////////////
//            /// IN_CONTROL
//            query = " SELECT " +
//                       " SUM(EXP_EFF_DOSE_C) Z43, SUM(ACTIVITY_CONTROL) Z48 " +
//                       " FROM IN_CONTROL WHERE " +
//                       " ID_PERSON IN (" + page_main_.id_currentPerson  + ") AND " +
//                       " DATE_TIME >= TO_DATE('" + date_begin_send + "','DD/MM/YY') AND" +
//                       " DATE_TIME <= TO_DATE('" + date_end_send   + "','DD/MM/YY') ";

//            Query1.setQueryAndName(query, "q1__getMainPersonParam3_1");

//            /// IN_MEASURE
//            query = " SELECT " +
//                       " SUM(ACTIVITY_MEASURE) Z49 " +
//                       " FROM IN_MEASURE WHERE " +
//                       " ID_PERSON IN (" + page_main_.id_currentPerson  + ") AND " +
//                       " NUCLIDE = 'Co-60' AND " +
//                       " DATE_TIME >= TO_DATE('" + date_begin_send + "','DD/MM/YY') AND" +
//                       " DATE_TIME <= TO_DATE('" + date_end_send   + "','DD/MM/YY') ";

//            Query1.setQueryAndName(query, "q1__getMainPersonParam3_2");

//            query = " SELECT " +
//                       " SUM(ACTIVITY_MEASURE) Z54 " +
//                       " FROM IN_MEASURE WHERE " +
//                       " ID_PERSON IN (" + page_main_.id_currentPerson  + ") AND " +
//                       " DATE_TIME >= TO_DATE('" + date_begin_send + "','DD/MM/YY') AND" +
//                       " DATE_TIME <= TO_DATE('" + date_end_send   + "','DD/MM/YY') ";

//            Query1.setQueryAndName(query, "q1__getMainPersonParam3_3");

//            query = " SELECT " +
//                       " SUM(ACTIVITY_MEASURE) Z59 " +
//                       " FROM IN_MEASURE WHERE " +
//                       " ID_PERSON IN (" + page_main_.id_currentPerson  + ") AND " +
//                       " NUCLIDE <> 'Co-60' AND " +
//                       " DATE_TIME >= TO_DATE('" + date_begin_send + "','DD/MM/YY') AND" +
//                       " DATE_TIME <= TO_DATE('" + date_end_send   + "','DD/MM/YY') ";

//            Query1.setQueryAndName(query, "q1__getMainPersonParam3_4");


//            /// IN_IODINE
//            query = " SELECT " +
//                       " SUM(EXP_EFF_DOSE_I) Z46, SUM(ACTIVITY_IODINE) Z55 " +
//                       " FROM IN_IODINE WHERE " +
//                       " ID_PERSON IN (" + page_main_.id_currentPerson  + ") AND " +
//                       " DATE_TIME >= TO_DATE('" + date_begin_send + "','DD/MM/YY') AND" +
//                       " DATE_TIME <= TO_DATE('" + date_end_send   + "','DD/MM/YY') ";

//            Query1.setQueryAndName(query, "q1__getMainPersonParam3_5");

//            /// IN_MEASURE: EXP_EFF_DOSE_M
//            query = " SELECT " +
//                       " SUM(EXP_EFF_DOSE_M) Z44 " +
//                       " FROM IN_MEASURE WHERE " +
//                       " ID_PERSON IN (" + page_main_.id_currentPerson  + ") AND " +
//                       " ORGAN = 'Легкие' AND " +
//                       " DATE_TIME >= TO_DATE('" + date_begin_send + "','DD/MM/YY') AND" +
//                       " DATE_TIME <= TO_DATE('" + date_end_send   + "','DD/MM/YY') ";

//            Query1.setQueryAndName(query, "q1__getMainPersonParam3_6");

//            //////////////////////////////////////////////////////////////////////////////



        }


        /// ФУНКЦИИ для страницы "ввод доз ТЛД"
        /// запрос с последней датой отжига тлд
        function getBurnDate(id_person) {
            if (id_person == undefined) return false;
            var query = " select max(BURN_DATE) FROM EXT_DOSE WHERE ID_PERSON = " + id_person;
            Query1.setQueryAndName(query, "q1__getBurnDate_last"); //q1__getBURN_DATE_lust
        }

        /// ФУНКЦИИ для страницы "добавить новго сотрудника"


        /// ФУНКЦИИ для страницы "СИЧ"
        function getResultsSICH(id_person) {
            if (id_person == undefined) return false;
            var query = " Select " +
                        " (SELECT SUM(IN_CONTROL.ACTIVITY_CONTROL) from IN_CONTROL WHERE IN_CONTROL.ID_PERSON = " + id_person + " ) SUM_ACTIVITY_C," +
                        " (SELECT SUM(IN_MEASURE.ACTIVITY_MEASURE) from IN_MEASURE WHERE IN_MEASURE.ID_PERSON = " + id_person + " ) SUM_ACTIVITY_M_CO, " +
                        " (SELECT SUM(IN_MEASURE.ACTIVITY_MEASURE) from IN_MEASURE WHERE " +
                        " ((select ADM_NUCLIDE.NUCLIDE from ADM_NUCLIDE WHERE ADM_NUCLIDE.ID = IN_MEASURE.NUCLIDE) != 'Co' OR (select ADM_NUCLIDE.NUCLIDE from ADM_NUCLIDE WHERE ADM_NUCLIDE.ID = IN_MEASURE.NUCLIDE) IS NULL) " +
                        " AND IN_MEASURE.ID_PERSON = " + id_person + ") SUM_ACTIVITY_M, " +
                        " (SELECT SUM(IN_IODINE.ACTIVITY_IODINE) from IN_IODINE WHERE IN_IODINE.ID_PERSON = " + id_person + " ) SUM_ACTIVITY_I, " +

                        " max (IN_CONTROL.DATE_TIME) MAX_DATE_TIME_C, " +
                        " (select count(*) from IN_CONTROL where IN_CONTROL.ID_PERSON = " + id_person + ") COUNT_C, " +

                        " max (IN_MEASURE.DATE_TIME) MAX_DATE_TIME_M, " +
                        " (select count(*) from IN_MEASURE where IN_MEASURE.ID_PERSON = " + id_person + ") COUNT_M, " +

                        " max (IN_IODINE .DATE_TIME) MAX_DATE_TIME_I, " +
                        " (select count(*) from IN_IODINE where IN_IODINE.ID_PERSON = " + id_person + ") COUNT_I " +

                        " FROM EXT_PERSON " +
                        " LEFT JOIN IN_CONTROL ON EXT_PERSON.ID_PERSON = IN_CONTROL.ID_PERSON " +
                        " LEFT JOIN IN_MEASURE ON EXT_PERSON.ID_PERSON = IN_MEASURE.ID_PERSON " +
                        " LEFT JOIN IN_IODINE  ON EXT_PERSON.ID_PERSON = IN_IODINE.ID_PERSON "  +

                        " WHERE EXT_PERSON.ID_PERSON = " + id_person +
                        " GROUP BY EXT_PERSON.ID_PERSON "

            Query1.setQueryAndName( query, "q1__resultSICH" );
        }

        /// ФУНКЦИИ для страницы "SQL запросы"
        /// ФУНКЦИИ для страницы "Накопленные дозы"
        /// ФУНКЦИИ для страницы "Отчет № 1-ДОЗ"
        /// ФУНКЦИИ для страницы "Тест системы подключений"

        ////////////////////////////////////////////////////////////////
        /// ФУНКЦИЯ ФСТАВКИ ДАННЫХ В ТАБЛИЦУ
        function insertIntoDB(nameQuery, nameTable, data) {
            Query1.insertRecordIntoTable(nameQuery, nameTable, data)
        }




    }

    /// набор основных переменных
    Item {
        id: variables

        property var id_currentPerson: undefined
        property string fio_currentPerson: "Сотрудник не выбран"
        property string sex
        property string staff_type: "Сотрудник не выбран"
        property int age: 0
        property string imagePath: "icons/face.svg"
        property string burn_date_lost: "Сотрудник не выбран"
    }

    /////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////



    /// разворачивающийся список сотрудников
    Rectangle {
        id: rect_allPersons
        anchors.top: top_panel.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 70
        anchors.right: parent.right

        color: "transparent"

        clip: true

        /// линия слева
        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: 1
            color: "#7c7c7c"
        }

        /// открыть панель
        function openPanel(width) {
            rect_allPersons.visible = true;

            rect_allPersons_animation.from = 0;
            rect_allPersons_animation.to   = width;

            rect_allPersons_animation.stop();
            rect_allPersons_animation.running = true;
        }
        /// закрыть панель
        function closePanel(width) {
            rect_allPersons.visible = false;

            rect_allPersons_animation.from = rect_allPersons.width;
            rect_allPersons_animation.to   = 0;

            rect_allPersons_animation.stop();
            rect_allPersons_animation.running = true;
        }

        NumberAnimation {
            id: rect_allPersons_animation
            target: rect_allPersons
            properties: "width"

            easing.type: Easing.OutQuad
            duration: 200
            running: false
        }

        /// список сотрудников
        ListView {
            id: list_Persons
            anchors.fill: parent
            anchors.leftMargin: 5
            currentIndex: -1

            highlightFollowsCurrentItem: true
            model: models.model_ext_person_list

            ScrollBar.vertical: ScrollBar {
                policy: "AsNeeded" //"AlwaysOn"
            }

            clip: true
            delegate:
                ItemDelegate {
                width: rect_allPersons.width - 10 //340 //325
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

                    var id_currentPerson                    = models.model_ext_person_list.getFirstColumnInt(index)
                    console.log(" (!) id_currentPerson = ", id_currentPerson)
                    findFieldPerson_panel.pn_currentPerson  = PERSON_NUMBER
                    findFieldPerson_panel.tld_currentPerson = ID_TLD
                    findFieldPerson_panel.fio_currentPerson = W_SURNAME + "\n" + W_NAME + " " + W_PATRONYMIC


                    variables.id_currentPerson = id_currentPerson;

                    functions.updatePersonModel(id_currentPerson);
                    functions.main_fun(id_currentPerson);



//                    persons.id_currentPerson = id_currentPerson;
//                    sich.currentPerson       = id_currentPerson;

//                    if ( sich.visible ) {
//                        sich.currentPerson = id_currentPerson
//                        sich.results_fun();
//                    }
//                    if ( persons.visible ) {
//                        persons.id_currentPerson = id_currentPerson
//                        persons.mainFunction();
//                    }


                }
            }

            highlight: Rectangle {
                color: "transparent" // "#FF5722" //"#c9c9c9" // "#B0BEC5" //Material.color(Material.Grey, Material.Shade700)
                border.color: "#FF5722"

            }
            highlightMoveDuration: 400
        }



    }

    /// панель с основными страницами
    Item {
        id: pages_main //stackview_mainwindow

        anchors.left: frame1.right
        anchors.right: rect_allPersons.left //parent.right
        //anchors.rightMargin: 250
        anchors.top: top_panel.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 70



        /// СТРАНИЦЫ
        Persons {
            id: persons
            anchors.fill: parent
            visible: true

            id_currentPerson: variables.id_currentPerson

            model_person:               models.model_person
//            model_ext_person_list:      models.model_ext_person_list
//            model_adm_status:           models.model_adm_status
//            model_adm_assignment:       models.model_adm_assignment
//            model_adm_organisation:     models.model_adm_organisation
//            model_adm_department_outer: models.model_adm_department_outer
//            model_adm_department_inner: models.model_adm_department_inner

//            onCurrentPersonChange: {
//                variables.id_currentPerson  = id_currentPerson
//                variables.fio_currentPerson = fio_currentPerson
//                variables.sex = sex
//                variables.staff_type = staff_type
//                variables.age = age
//                console.log(" (!) onCurrentPersonChange: ", variables.id_currentPerson);
//            }
//            onCurrentPersonChange_photo: {
//                variables.imagePath = imagePath
//            }
//            onCurrentPersonChange_date_burn: {
//                variables.burn_date_lost = burn_date_lost
//            }
            onUpdatePersonParameters: {
                functions.getPersonParameters(id_person, date_begin, date_end)
            }
        }

        AddPerson {
            id: addPerson
            anchors.fill: parent
            visible: false
            id_currentPerson: variables.id_currentPerson

            model_adm_status:           models.model_adm_status
            model_adm_assignment:       models.model_adm_assignment
            model_adm_organisation:     models.model_adm_organisation
            model_adm_department_outer: models.model_adm_department_outer
            model_adm_department_inner: models.model_adm_department_inner

            onSignalUpdatePersonsList: {
                models.model_ext_person_list.updateModel();
            }

        }

        InputDoseTLD {
            id: inputDoseTLD
            anchors.fill: parent
            visible: false
            id_currentPerson: variables.id_currentPerson
            fio_currentPerson: variables.fio_currentPerson
            sex: (models.model_person.get(0)["SEX"] != undefined) ? models.model_person.get(0)["SEX"] : "Сотрудник не выбран" //(models.model_person.get(0)["SEX"] === "M") ? "M" : "F"
            //burn_date_lost: variables.burn_date_lost
            model_person: models.model_person //model_adm_status //
            onInsertIntoDB_DoseTLD: {
                functions.insertIntoDB(nameQuery, nameTable, data)
            }

        }
        SICH {
            id: sich
            anchors.fill: parent
            visible: false

            currentPerson: variables.id_currentPerson
            model_nuclide: models.model_adm_nuclide
            model_nuclide_I: models.model_adm_nuclide_I

            onUpdateDataUI: {
                functions.getResultsSICH(variables.id_currentPerson)
            }
            onInsertIntoDB_sich: {
                functions.insertIntoDB(nameQuery, nameTable, data)
            }
        }
        Reports {
            id: reports
            anchors.fill: parent
            visible: false

            model_SQLQiueries: models.model_SQLQiueries
            model_tableReports: models.model_tableReports
        }
        Report_1DOZ {
            id: report_1DOZ
            anchors.fill: parent
            visible: false
            id_currentPerson: variables.id_currentPerson
        }
        Report_AccumulatedDose {
            id: report_AccumulatedDose
            anchors.fill: parent
            visible: false

            id_currentPerson: variables.id_currentPerson
            fio_currentPerson: variables.fio_currentPerson
            staff_type: variables.staff_type
            sex: variables.sex
            age: variables.age
            imagePath: variables.imagePath
        }

        TestPage {
            id: testPage
            anchors.fill: parent
            visible: false
        }
        TestConnectionSystem {
            id: testCSPage
            anchors.fill: parent
            visible: false
        }
        EmptyPage {
            id: emptyPage
            anchors.fill: parent
            visible: false
        }

    }

    /// верхняя панель, в которой выводится заголовок или меню, например меню поиска сотрудника
    Item {
        id: top_panel
        height: 70
        anchors.left:  parent.left //frame1.right
        anchors.right: parent.right


        Rectangle {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 1
            color: "#7c7c7c"
            //opacity: 0.3
        }

        MyFindField2 {
            id: findFieldPerson_panel
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            open: true

            model_ext_person_list: models.model_ext_person_list
            model_adm_assignment: models.model_adm_assignment

            onSendIDPerson: {
                //console.log(" (!) id_currentPerson = ",id_currentPerson)

                variables.id_currentPerson = id_currentPerson;

                functions.updatePersonModel(id_currentPerson);
                functions.getPersonPhoto(id_currentPerson);
                functions.getPersonParameters(id_currentPerson);


//                if ( sich.visible ) {
//                    sich.currentPerson = id_currentPerson
//                    sich.results_fun();
//                }
//                if ( persons.visible ) {
//                    persons.id_currentPerson = id_currentPerson
//                    persons.mainFunction();
//                }
//                persons.workerModelQuery(id_currentPerson);
            }
            onOpenListPerson: {
                if ( isOpen ) {
                    //rect_allPersons.width = findFieldPerson_panel.widthListPersonsPanel
                    rect_allPersons.openPanel(findFieldPerson_panel.widthListPersonsPanel);
                }
                else {
                    //rect_allPersons.width = 0;
                    rect_allPersons.closePanel(0);
                }
            }

        }
    }




    /////////////////////////////////////////////////
    /// индикаторы сосотояний подключения

    Rectangle {
        anchors.bottom: rect_mainStatusPanel.top
        anchors.margins: 10
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: 370

        //width: 1120
        height: 1
        color: "LightGray"

    }

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
                    if(message.includes("begin")){ //message=="begin"
                        if(message=="begin_") {
                            //txt_statusConnection.append("<p style='color:#9cc17f'>" + "begin" + ": " + iBegin + "</p>") //txt_statusConnection.text = message;
                            txt_statusConnection.append("<p style='color:#9cc17f'>" + "begin: " + iBegin  +  "<span style='color:#c1b17f'>" + " (!) " +"</span >" + "</p>") //txt_statusConnection.text = message;
                        }
                        else {
                            if(~message.indexOf("|")) {
                                var senderName =  message.split('|').pop();
                            }
                            txt_statusConnection.append("<p style='color:#9cc17f'>" + "begin" + ": " + iBegin + "   ( "  +  "<span style='color:#c1b17f'>" + senderName +"</span > )" + "</p>") //txt_statusConnection.text = message;
                        }
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
                        console.log(" !!!!!!!!!!!!!!!!!!!!! 1", currentConnectionName, "; " ,message, "; status = ",status)
                        txt_nameConnection.text = currentConnectionName;
                        //indicatorConnect_local.lightOff();

                        if(currentConnectionName=="machine 0") {
                            console.log(" !!!!!!!!!!!!!!!!!!!!! 2", currentConnectionName, "; lightTrue()")
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

            Rectangle {
                id: machine0
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                width: 40
                border.color: "LightGray"
                Text {
                    anchors.centerIn: parent
                    text: qsTr("0")
                    font.pixelSize: 15
                    color: "#494848"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        //rect_changeConnect.currentMachine = 0
                        indicatorConnect_0.lightOff();
                        indicatorConnect_1.lightOff();
                        popup_txt.text = qsTr("Подлючение к machine 0");
                        txt_statusConnection.append("<p style='color:#9cc17f'> Переключение БД </p>")
                        popup_wait_2.open();

                        //managerDB.connectionDB(0);
                        managerDB.checkConnectionDB(0);

                        models.updateAllModels();
                    }
                    onEntered: {
                        parent.color = "#dbdbdb" // "LightGray"
                    }
                    onExited:  {
                        parent.color = "Transparent"
                    }
                }
            }
            Rectangle {
                id: machine1
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                width: 40
                border.color: "LightGray"
                Text {
                    anchors.centerIn: parent
                    text: qsTr("1")
                    font.pixelSize: 15
                    color: "#494848"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        //rect_changeConnect.currentMachine = 1
                        indicatorConnect_0.lightOff();
                        indicatorConnect_1.lightOff();
                        popup_txt.text = qsTr("Подлючение к machine 1");
                        popup_wait_2.open();
                        txt_statusConnection.append("<p style='color:#9cc17f'> Переключение БД </p>")
                        //managerDB.connectionDB(1);
                        managerDB.checkConnectionDB(1);

                        models.updateAllModels();
                    }
                    onEntered: {
                        parent.color = "#dbdbdb" //"LightGray"
                    }
                    onExited:  {
                        parent.color = "Transparent"
                    }
                }
            }

//            Row {
//                anchors.centerIn: parent
//                //Tumbler { model: 5 }
//                //Switch {}
//                //RadioButton {}
//            }
        }

        /// разоврачивающаяся информационная панель
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
                    onLengthChanged: {
                        //console.log(" (!) Length = ", length)
                        if(length >= 5000) {
                            console.log(" (!) Length = ", length, " | clear txt_statusConnection ...")
                            clear();

                        }
                    }
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

        /// индикторы
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


}

