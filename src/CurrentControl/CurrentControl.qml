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

        MyListViewUnfolding_v2 {
            anchors.fill: parent
            anchors.topMargin: 10

            model:
                ListModel {

                /// header: "имя заголовка not fold"  - блокирует сворачивание списка для данного заголовка

                //ListElement { image:"icons/face.svg"; name: "Выбор сотрудника 2";   header: "" } ///Карточка работника
//                ListElement { image:"icons/face.svg"; name: "Выбор сотрудника";   header: "" }
                ListElement { image:"icons/face.svg"; name: "Данные";           header: "Сотрудники" }
                ListElement { image:"";               name: "Ввод доз ТЛД";     header: "Сотрудники" }
                ListElement { image:"";               name: "СИЧ";              header: "Сотрудники" }

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
                }

//            onCurrentName: {
//                //if(name === "Касетница") { stackview_mainwindow.replace(".qml")
//                if(name === "Карточка работника") { stackview_mainwindow.replace("WorkersCard.qml") }
//                else {stackview_mainwindow.replace("TestPage.qml")}
//            }

            onCurrentName: {
                changePage(name)
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
//            //namePage = "WorkersCard.qml";
//            workerCard.visible = true;
//            break;

        case "Выбор сотрудника": //Карточка работника
            console.log("name = ", name);
            persons.visible = true;

            /// обновление моделей
            //models.model_ext_person_list.updateModel()
            models.model_adm_status.updateModel()
            models.model_adm_assignment.updateModel()
            models.model_adm_organisation.updateModel()
            models.model_adm_department_outer.updateModel()
            models.model_adm_department_inner.updateModel()

            break;

        case "Ввод доз ТЛД":
            console.log("name = ", name);
            //namePage = "InputDoseTLD.qml";
            inputDoseTLD.visible = true;
            break;

        case "СИЧ":
            console.log("name = ", name);
            //sich.visible = true;
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
            break;
        case "Отчет № 1-ДОЗ":
            console.log("name = ", name);            
            report_1DOZ.visible = true; //namePage = "Report_1DOZ.qml";
            break;

        case "Тесты":
            console.log("name = ", name);
            testPage.visible = true;
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
        inputDoseTLD.visible           = false
        //sich.visible                   = fasle
        report_AccumulatedDose.visible = false
        report_1DOZ.visible            = false
        reports.visible                = false
        testPage.visible               = false

        emptyPage.visible              = false
    }

    /// модели
    Item {
        id: models

        property var  model_perosn:  managerDB.createModel("", "select_person")

        property var model_ext_person_list:      managerDB.createModel(" SELECT ID_PERSON, W_NAME, W_SURNAME, W_PATRONYMIC, PERSON_NUMBER, ID_TLD FROM EXT_PERSON ORDER BY W_SURNAME", "ext_person" )
        property var model_adm_status:           managerDB.createModel(" SELECT STATUS_CODE, STATUS  FROM ADM_STATUS ",                    "adm_status_update")
        property var model_adm_assignment:       managerDB.createModel(" SELECT ID, ASSIGNEMENT      FROM ADM_ASSIGNEMENT ",               "adm_department_nnp_update")
        property var model_adm_organisation:     managerDB.createModel(" SELECT ID, ORGANIZATION_    FROM ADM_ORGANIZATION ",                 "adm_organisation")
        property var model_adm_department_outer: managerDB.createModel(" SELECT ID, DEPARTMENT_OUTER FROM ADM_DEPARTMENT_OUTER WHERE ID = 0", "adm_department_outer")
        property var model_adm_department_inner: managerDB.createModel(" SELECT ID, DEPARTMENT_INNER FROM ADM_DEPARTMENT_INNER ",             "adm_department_inner")

        property var model_SQLQiueries:  managerDB.createModel(" SELECT ID, DOCX, DOCM, REPORTNAME, SQL, DESCRIPTION FROM REPORTS ", "rep_sqlqueries") //" SELECT ID, SQLQUERY, DESCRIPTION FROM REP_SQLQUERIES ", "rep_sqlqueries"
        property var model_tableReports: managerDB.createModel("", "tableReports")


        /// обновить все модели
        function updateAllModels() {
            model_ext_person_list.updateModel();
            model_adm_status.updateModel();
            model_adm_assignment.updateModel();
            model_adm_organisation.updateModel();
            model_adm_department_outer.updateModel();
            model_adm_department_inner.updateModel();

            model_SQLQiueries.updateModel();
            model_tableReports.updateModel();
        }

    }


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
            property string id_currentPerson: models.model_ext_person_list.getFirstColumnInt(currentIndex)
            property string pn_currentPerson
            property string tld_currentPerson
            property string fio_currentPerson


            highlightFollowsCurrentItem: true
            model: models.model_ext_person_list //model_ext_person_list


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
                    list_Persons.id_currentPerson = models.model_ext_person_list.getFirstColumnInt(index)
                    list_Persons.fio_currentPerson = W_SURNAME + "\n" + W_NAME + " " + W_PATRONYMIC
                    //timer_persons.restart()
                    findFieldPerson_panel.searchPerson(list_Persons.id_currentPerson);
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

        property string id_currentPerson: "Сотрудник не выбран"
        property string fio_currentPerson: "Сотрудник не выбран"
        property string sex: "Сотрудник не выбран"
        property string staff_type: "Сотрудник не выбран"
        property int age: 0
        property string imagePath: "icons/face.svg"
        property string burn_date_lost: "Сотрудник не выбран"

        /// СТРАНИЦЫ
        Persons {
            id: persons
            anchors.fill: parent
            visible: true


            model_perosn:               models.model_perosn
            model_ext_person_list:      models.model_ext_person_list
            model_adm_status:           models.model_adm_status
            model_adm_assignment:       models.model_adm_assignment
            model_adm_organisation:     models.model_adm_organisation
            model_adm_department_outer: models.model_adm_department_outer
            model_adm_department_inner: models.model_adm_department_inner

            onCurrentPersonChange: {               
                pages_main.id_currentPerson  = id_currentPerson
                pages_main.fio_currentPerson = fio_currentPerson
                pages_main.sex = sex
                pages_main.staff_type = staff_type
                pages_main.age = age
                console.log(" (!) onCurrentPersonChange: ", pages_main.id_currentPerson);
            }
            onCurrentPersonChange_photo: {
                pages_main.imagePath = imagePath
            }
            onCurrentPersonChange_date_burn: {
                pages_main.burn_date_lost = burn_date_lost
            }
        }
        InputDoseTLD {
            id: inputDoseTLD
            anchors.fill: parent
            visible: false
            id_currentPerson: pages_main.id_currentPerson
            fio_currentPerson: pages_main.fio_currentPerson
            sex: pages_main.sex
            burn_date_lost: pages_main.burn_date_lost

        }
//        SICH {
//            id: sich
//            anchors.fill: parent
//            visible: false
//        }
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
            id_currentPerson: pages_main.id_currentPerson
        }
        Report_AccumulatedDose {
            id: report_AccumulatedDose
            anchors.fill: parent
            visible: false

            id_currentPerson: pages_main.id_currentPerson
            fio_currentPerson: pages_main.fio_currentPerson
            staff_type: pages_main.staff_type
            sex: pages_main.sex
            age: pages_main.age
            imagePath: pages_main.imagePath
        }
        TestPage {
            id: testPage
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
                persons.workerModelQuery(id_currentPerson);
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

//    StackView {
//        id: stackview_mainwindow
//        anchors.left: frame1.right
//        anchors.right: parent.right
//        //anchors.rightMargin: 250
//        anchors.top: parent.top
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 70

//        property var model_adm_status:           managerDB.createModel(" SELECT STATUS_CODE, STATUS  FROM ADM_STATUS ",                    "adm_status_update")
//        property var model_adm_assignment:       managerDB.createModel(" SELECT ID, ASSIGNEMENT      FROM ADM_ASSIGNEMENT ",               "adm_department_nnp_update")
//        property var model_adm_organisation:     managerDB.createModel(" SELECT ID, ORGANIZATION_    FROM ADM_ORGANIZATION ",                 "adm_organisation")
//        property var model_adm_department_outer: managerDB.createModel(" SELECT ID, DEPARTMENT_OUTER FROM ADM_DEPARTMENT_OUTER WHERE ID = 0", "adm_department_outer")
//        property var model_adm_department_inner: managerDB.createModel(" SELECT ID, DEPARTMENT_INNER FROM ADM_DEPARTMENT_INNER ",             "adm_department_inner")

//        property var id_currentPerson

//        //property var testVar: "Hello"

//        initialItem: "WorkersCard.qml"

//        replaceEnter: Transition {
//            PropertyAnimation {
//                property: "opacity"
//                from: 0
//                to:1
//                duration: 0
//            }
//        }
//        replaceExit: Transition {
//            PropertyAnimation {
//                property: "opacity"
//                from: 1
//                to:0
//                duration: 0
//            }
//        }

//    }


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


}

