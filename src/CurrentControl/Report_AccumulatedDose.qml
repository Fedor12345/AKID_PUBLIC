import QtQuick 2.12
import QtQuick.Controls 2.5

import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

import QtQuick.Dialogs 1.2


Page {
    id: page_main_
    property int space_margin: 15

    property var id_currentPerson
    property string fio_currentPerson
    property string staff_type
    property string sex
    property int age
    property string imagePath



    Frame {
        id: frame_header

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
                color: "#808080"
                text: "ОТЧЕТЫ"
            }
            ToolSeparator {}
            Text {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20 //main_.sizeTxt
                font.bold: true
                color: "#808080"
                text: "ОТЧЕТ НАКОПЛЕННЫЕ ДОЗЫ"
            }
        }


//        Label {
//            anchors.centerIn: parent
//            text: "ОТЧЕТЫ"
//            font.pixelSize: 14
//            font.bold: true
//        }

    }


    Rectangle {
        id: rect_header_Person
        anchors.top: frame_header.bottom
        anchors.topMargin: 20 // 100
        anchors.left: parent.left
        anchors.leftMargin: 30

        color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
        border.color: "LightGray"
        radius: 7

        height: 50
        width:  300

        Label {
            anchors.centerIn: parent
            font.pixelSize: 15
            text: "Отчет для сотрудника" //"Выбранный сотрудник"
        }
    }

    Pane {
        id: rect_Person
        anchors.top: rect_header_Person.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 30

        height: 300
        width:  300

        Material.elevation: 6

        //border.color: (page_main_.id_currentPerson !== "Сотрудник не выбран" ) ? "LightGray" : Material.color(Material.Teal)
        //border.width: (page_main_.id_currentPerson !== "Сотрудник не выбран" ) ? 1 : 2
        //color: "transparent"

        Label {
            anchors.top: parent.top
            anchors.left: parent.left
            text: page_main_.imagePath
        }


        Column {
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 40            
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 150
                height: 150
                //border.color: "LightGray"
                color: "transparent"

                Image {
                    id:image_photoPerson
                    //property bool emptyPhoto: true
                    cache: false
                    fillMode: Image.PreserveAspectFit
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom

//                    anchors.topMargin:    2
//                    anchors.leftMargin:   2
//                    anchors.rightMargin:  2
//                    anchors.bottomMargin: 2
//                    opacity: 1

                    anchors.topMargin:    (~page_main_.imagePath.indexOf("icons/face.svg")) ? 0 : 2
                    anchors.leftMargin:   (~page_main_.imagePath.indexOf("icons/face.svg")) ? 0 : 2
                    anchors.rightMargin:  (~page_main_.imagePath.indexOf("icons/face.svg")) ? 0 : 2
                    anchors.bottomMargin: (~page_main_.imagePath.indexOf("icons/face.svg")) ? 0 : 2
                    opacity: (~page_main_.imagePath.indexOf("icons/face.svg")) ? 0.2 : 1
                    sourceSize.height: 200
                    sourceSize.width:  200
                    source: page_main_.imagePath ///"icons/face.svg"
                }

            }
            TextEdit {
                id: txt_PersonFIO
                anchors.horizontalCenter: parent.horizontalCenter
                width: rect_Person.width
                font.pixelSize: 20 //main_.sizeTxt
                font.bold: true
                font.capitalization: Font.AllUppercase // в верхний регистр
                color: Material.color(Material.Teal)
                selectByMouse: true
                selectionColor: Material.color(Material.Red)
                wrapMode: Text.WordWrap
                horizontalAlignment: TextEdit.AlignHCenter

                text: page_main_.fio_currentPerson
            }

        }

    }



    Rectangle {
        id: rect_header_choiceDate
        anchors.top: frame_header.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter

        color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
        border.color: "LightGray"
        radius: 7

        height: 50
        width:  500

        Label {
            anchors.centerIn: parent
            font.pixelSize: 15
            text: "Выберите интервал времени"
        }

    }

    Rectangle {
        id: rect_choiceDate
        anchors.top: rect_header_choiceDate.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        height: 400
        width:  500

        border.color: "LightGray"
        color: "transparent"

        Rectangle { //ColumnLayout {
            //anchors.fill: parent
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: 20
            anchors.bottomMargin: 40
            width: 50

            color: "transparent"
            //border.color: "LightGray"

            //spacing: 5
            RadioButton {
                id: radioB_date1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top:parent.top
                anchors.topMargin: 20
                //text: "1 – от 1 января по текущую дату"
            }
            RadioButton {
                id: radioB_date2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top:parent.top
                anchors.topMargin: 105
                //text: "2 – от текущей даты минус год назад"
            }
            RadioButton {
                id: radioB_date3
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top:parent.top
                anchors.topMargin: 240
                //text: "3 – от одной даты до другой"
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            anchors.leftMargin: 80
            spacing: 10

            Rectangle {
                Layout.fillWidth: true
                //width: 200
                height: 50
                color: "transparent"
                //border.color: "LightGray"

                Row {
                    //anchors.fill: parent
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 15

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        height: 50
                        width: 1
                        color: (radioB_date1.checked) ? Material.color(Material.LightBlue) : "transparent" //"LightGray"
                    }

                    ColumnLayout {
                        Label {
                            font.pixelSize: 15
                            text: "От начала года"

                        }
                        Label {
                            font.pixelSize: 15
                            text: "По сегодня"
                        }
                    }

                    ColumnLayout {
                        Label {
                            font.pixelSize: 15
                            text: {
                                var now = new Date;
                                return "1 января " + now.getFullYear();
                            }
                        }
                        Label {
                            font.pixelSize: 15
                            text: {
                                var now = new Date();
                                var month = now.getMonth()
                                if(month === 0)  month = "января"
                                if(month === 1)  month = "февраля"
                                if(month === 2)  month = "марта"
                                if(month === 3)  month = "апреля"
                                if(month === 4)  month = "мая"
                                if(month === 5)  month = "июня"
                                if(month === 6)  month = "июля"
                                if(month === 7)  month = "августа"
                                if(month === 8)  month = "сентября"
                                if(month === 9)  month = "октября"
                                if(month === 10) month = "ноября"
                                if(month === 11) month = "декабря"

                                var date = now.getDate() + " " + month + " " + now.getFullYear();
                                return date;
                            }
                        }
                    }

                    Rectangle {
                        //anchors.verticalCenter: parent.verticalCenter
                        height: parent.height // 40
                        width: 1
                        color: "LightGray"
                    }

                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 15
                        text: {
                            var now = new Date;
                            var date0 = new Date(now.getFullYear(), 0, 1)
                            var today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                            var diff =  Math.floor((today - date0) / 1000 / 3600 / 24);

                            return "За "  + diff + " (дней)";
                        }
                    }


                }
            }

            Rectangle {
                Layout.fillWidth: true
                //width: 200
                height: 50
                color: "transparent"
                //border.color: "LightGray"

                Row {
                    //anchors.fill: parent
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 15

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        height: 50
                        width: 1
                        color: (radioB_date2.checked) ? Material.color(Material.LightBlue) : "transparent" //"LightGray"
                    }


                    ColumnLayout {
                        Label {
                            font.pixelSize: 15
                            text: "От текущей даты"
                        }
                        Label {
                            font.pixelSize: 15
                            text: "Минус год назад"
                        }
                    }

                    ColumnLayout {
                        Label {
                            font.pixelSize: 15
                            text: {
                                var now = new Date();
                                var month = now.getMonth()
                                if(month === 0)  month = "января"
                                if(month === 1)  month = "февраля"
                                if(month === 2)  month = "марта"
                                if(month === 3)  month = "апреля"
                                if(month === 4)  month = "мая"
                                if(month === 5)  month = "июня"
                                if(month === 6)  month = "июля"
                                if(month === 7)  month = "августа"
                                if(month === 8)  month = "сентября"
                                if(month === 9)  month = "октября"
                                if(month === 10) month = "ноября"
                                if(month === 11) month = "декабря"

                                var date = now.getDate() + " " + month + " " + now.getFullYear();
                                return date;
                            }
                        }
                        Label {
                            font.pixelSize: 15
                            text: {
                                var now = new Date();
                                var date = new Date((now.getFullYear()-1),now.getMonth(),now.getDate());

                                var month = now.getMonth()
                                if(month === 0)  month = "января"
                                if(month === 1)  month = "февраля"
                                if(month === 2)  month = "марта"
                                if(month === 3)  month = "апреля"
                                if(month === 4)  month = "мая"
                                if(month === 5)  month = "июня"
                                if(month === 6)  month = "июля"
                                if(month === 7)  month = "августа"
                                if(month === 8)  month = "сентября"
                                if(month === 9)  month = "октября"
                                if(month === 10) month = "ноября"
                                if(month === 11) month = "декабря"

                                return date.getDate() + " " + month + " " + date.getFullYear();
                            }
                        }
                    }

                    Rectangle {
                        //Layout.fillHeight: true
                        //anchors.verticalCenter: parent.verticalCenter
                        height: parent.height // 40
                        width: 1
                        color: "LightGray"
                    }

                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 15
                        text: "За последний год"
                    }


                }
            }

            Rectangle {
                Layout.fillWidth: true
                //width: 200
                height: 120
                color: "transparent"
                //border.color: "LightGray"

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 15

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        height: 110
                        width: 1
                        color: (radioB_date3.checked) ? Material.color(Material.LightBlue) : "transparent" //"LightGray"
                    }

                    ColumnLayout {
                        spacing: 20
                        Row {
                            spacing: 10
                            Label {
                                // Layout.alignmen
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: 15
                                text: "От"
                            }
                            MyCalendar {
                                id: date_begin
                                date_val: new Date()
                            }
                        }
                        Row {
                            spacing: 10
                            Label {
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: 15
                                text: "До"
                            }
                            MyCalendar {
                                id: date_end
                                date_val: new Date() //new Date().getFullYear(), new Date().getMonth(), new Date().getDate()
                            }
                        }
                    }

                    Rectangle {
                        //Layout.fillHeight: true
                        anchors.verticalCenter: parent.verticalCenter

                        height: 110
                        width: 1
                        color: "LightGray"
                    }
                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 15
                        text: {
                            var date_1 = date_begin.date_val
                            var date_2 = date_end.date_val
                            var date = Math.round((date_2 - date_1) / 1000 / 3600 / 24)
                            return "За " + date + " (дней)";
                        }
                    }
                }
                Label {
                    anchors.top: parent.bottom
                    anchors.right: parent.horizontalCenter
                    anchors.rightMargin: 70

                    font.pixelSize: 15
                    text: {
                        if (date_end.ready &&
                            date_end.date_val.getFullYear() == new Date().getFullYear() &&
                            date_end.date_val.getMonth()    == new Date().getMonth()    &&
                            date_end.date_val.getDate()     == new Date().getDate()        )
                        {
                            return "(сегодня)";
                        }
                        else return "";
                    }
                }
            }

        }

    }


    Button {
        id: button_createReport
        anchors.top: rect_choiceDate.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter

        height: 50
        width:  500

        enabled: ((radioB_date1.checked || radioB_date2.checked || radioB_date3.checked)
                  && page_main_.id_currentPerson !== "Сотрудник не выбран" ) ? true : false

        Material.background: Material.LightGreen

        Label {
            anchors.centerIn: parent
            font.pixelSize: 15
            text: "Создать отчет"
        }
        onClicked: {

//            var date_0 = new Date();
//            new Date(now.getFullYear(), now.getMonth(), now.getDate());
//            date_0.toLocaleDateString("ru_RU", new Date(), "dd.MM.yyyy")
//            console.log(" date_0 = ", date_0.toLocaleDateString("ru_RU", new Date(), "dd.MM.yyyy"));

            var date_begin_send;
            var date_end_send;
            var now = new Date; // задает сегодняшнее число и время

            var test_var = 0;
            if (radioB_date1.checked) {
                test_var = 1
                date_begin_send = new Date(now.getFullYear(), 0 , 1).toLocaleDateString("ru_RU", "dd.MM.yyyy");
                date_end_send   = now.toLocaleDateString("ru_RU", "dd.MM.yyyy");
            }
            if (radioB_date2.checked) {
                test_var = 2
                date_begin_send = new Date((now.getFullYear()-1),now.getMonth(),now.getDate()).toLocaleDateString("ru_RU", "dd.MM.yyyy");
                date_end_send   = now.toLocaleDateString("ru_RU", "dd.MM.yyyy");
            }
            if (radioB_date3.checked) {
                test_var = 3
                date_begin_send = date_begin.date_val.toLocaleDateString("ru_RU", "dd.MM.yyyy");
                date_end_send   = date_end.date_val.toLocaleDateString("ru_RU", "dd.MM.yyyy"); //.toLocaleDateString("ru_RU", date_begin.date_val, "dd.MM.yyyy");
                //console.log("date_begin_send = ", date_begin_send, " |  date_end_send = ", date_end_send);
            }
            console.log( "\n", " параметры дат: ",test_var, "; ", date_begin_send, " ", date_end_send, "\n" );


            /// задается размерность массива данных (64) и число строк в текстовом файле данных (1)
            report.setTypeReport(64,1);
            /// пол и возраст сотрудника и ин-фа за какой период времени передаются в массив с индексом ноль (он не отображается в отчете)
            var Z = {};            
            Z["Z0"] = page_main_.sex + "|" + page_main_.age + "|" + test_var;
            Z["Z1"] = date_begin_send + " - " + date_end_send;
            Z["Z64"] = new Date().toLocaleString("ru_RU");
            report.setZ(Z);

            var querySql;

            /////////////////////////////////////////////////
            /// данные из таблицы EXT_PERSON запроса query2_1
            if (page_main_.staff_type === "Командировачный") {
                querySql = " SELECT PERSON_NUMBER Z2,  (W_SURNAME || ' ' ||  W_NAME || ' ' || W_PATRONYMIC) Z4, STAFF_TYPE Z5, " + // PHOTO Z3
                           " (ADM_ORGANIZATION.ORGANIZATION_ || ' ' || ADM_DEPARTMENT_OUTER.DEPARTMENT_OUTER) Z6, "  +
                         //" ADM_DEPARTMENT_INNER.DEPARTMENT_INNER Z6, "  +
                           " ADM_ASSIGNEMENT.ASSIGNEMENT Z7, ID_TLD Z8 "  +
                           " FROM EXT_PERSON " +
                           " LEFT JOIN ADM_ORGANIZATION     ON ext_person.ID_ORGANIZATION     = ADM_ORGANIZATION.ID "      +
                         //" LEFT JOIN ADM_DEPARTMENT_INNER ON ext_person.ID_DEPARTMENT_INNER = ADM_DEPARTMENT_INNER.ID "  +
                           " LEFT JOIN ADM_DEPARTMENT_OUTER ON ext_person.ID_DEPARTMENT_OUTER = ADM_DEPARTMENT_OUTER.ID "  +
                           " LEFT JOIN ADM_ASSIGNEMENT      ON ext_person.ID_ASSIGNEMENT      = ADM_ASSIGNEMENT.ID "       +

                           " WHERE " +
                           " ID_PERSON IN (" + page_main_.id_currentPerson  + ")  ";

            }
            else {
                querySql = " SELECT ID_PERSON Z2,  (W_SURNAME || ' ' ||  W_NAME || ' ' || W_PATRONYMIC) Z4, STAFF_TYPE Z5, " + // PHOTO Z3
                         //" (ADM_ORGANIZATION.ORGANIZATION_ || ' ' || ADM_DEPARTMENT_OUTER.DEPARTMENT_OUTER) Z6, "  +
                           " ADM_DEPARTMENT_INNER.DEPARTMENT_INNER Z6, "  +
                           " ADM_ASSIGNEMENT.ASSIGNEMENT Z7, ID_TLD Z8 "  +
                           " FROM EXT_PERSON " +
                         //" LEFT JOIN ADM_ORGANIZATION     ON ext_person.ID_ORGANIZATION     = ADM_ORGANIZATION.ID "      +
                           " LEFT JOIN ADM_DEPARTMENT_INNER ON ext_person.ID_DEPARTMENT_INNER = ADM_DEPARTMENT_INNER.ID "  +
                         //" LEFT JOIN ADM_DEPARTMENT_OUTER ON ext_person.ID_DEPARTMENT_OUTER = ADM_DEPARTMENT_OUTER.ID "  +
                           " LEFT JOIN ADM_ASSIGNEMENT      ON ext_person.ID_ASSIGNEMENT      = ADM_ASSIGNEMENT.ID "       +

                           " WHERE " +
                           " ID_PERSON IN (" + page_main_.id_currentPerson  + ")  ";
            }

            Query1.setQueryAndName(querySql, "q1__report_AccumulatedDose_query2_1");


            /////////////////////////////////////////////////
            /// данные запроса query2_2
            querySql = " SELECT " +
                       " SUM(TLD_G_HP10) Z21, SUM(TLD_N_HP10)  Z22, SUM(TLD_G_HP3)   Z25, SUM(TLD_N_HP3)   Z26, " +
                       " SUM(TLD_B_HP3)  Z27, SUM(TLD_G_HP007) Z31, SUM(TLD_N_HP007) Z32, SUM(TLD_B_HP007) Z33 "  +
                       //" SUM(TLD_G_HP10_DOWN) Z37, SUM(TLD_N_HP10_DOWN) Z38"  + //, SUM(TLD_B_HP10_DOWN) Z39
                       " FROM EXT_DOSE WHERE " +
                       " ID_PERSON IN (" + page_main_.id_currentPerson  + ") AND " +
                       " BURN_DATE >= TO_DATE('" + date_begin_send + "','DD/MM/YY') AND"  +
                       " BURN_DATE <= TO_DATE('" + date_end_send   + "','DD/MM/YY') ";

            Query1.setQueryAndName(querySql, "q1__report_AccumulatedDose_query2_2_1");

            querySql = " SELECT " +
                       " SUM(EPD_G_HP10) Z23, SUM(EPD_N_HP10)  Z24, SUM(EPD_G_HP3)   Z28, SUM(EPD_N_HP3)   Z29, "  +
                       " SUM(EPD_B_HP3)  Z30, SUM(EPD_G_HP007) Z34, SUM(EPD_N_HP007) Z35, SUM(EPD_B_HP007) Z36 "   +
                       " FROM OP_DOSE WHERE " +
                       " ID_PERSON IN (" + page_main_.id_currentPerson  + ") AND " +
                       " TIME_OUT >= TO_DATE('" + date_begin_send + "','DD/MM/YY') AND"   +
                       " TIME_OUT <= TO_DATE('" + date_end_send   + "','DD/MM/YY') ";

            Query1.setQueryAndName(querySql, "q1__report_AccumulatedDose_query2_2_2");

            /////////////////////////////////////////////////
            /// данные запроса query2_3

            querySql = " SELECT " +
                       " SUM(TLD_G_HP10_DOWN) Z37, SUM(TLD_N_HP10_DOWN) Z38 " +
                       " FROM EXT_DOSE WHERE " +
                       " ID_PERSON IN (" + page_main_.id_currentPerson  + ") AND " +
                       " BURN_DATE >= TO_DATE('" + date_begin_send + "','DD/MM/YY') AND" +
                       " BURN_DATE <= TO_DATE('" + date_end_send   + "','DD/MM/YY') ";

            Query1.setQueryAndName(querySql, "q1__report_AccumulatedDose_query2_3_1");

            querySql = " SELECT " +
                       " SUM(EPD_G_HP10_DOWN) Z40, SUM(EPD_N_HP10_DOWN) Z41 " +
                       " FROM OP_DOSE WHERE " +
                       " ID_PERSON IN (" + page_main_.id_currentPerson  + ") AND " +
                       " TIME_OUT >= TO_DATE('" + date_begin_send + "','DD/MM/YY') AND" +
                       " TIME_OUT <= TO_DATE('" + date_end_send   + "','DD/MM/YY') ";

            Query1.setQueryAndName(querySql, "q1__report_AccumulatedDose_query2_3_2");


            /////////////////////////////////////////////////
            /// данные запроса query2_4

            /// IN_CONTROL
            querySql = " SELECT " +
                       " SUM(EXP_EFF_DOSE_C) Z43, SUM(ACTIVITY_CONTROL) Z48 " +
                       " FROM IN_CONTROL WHERE " +
                       " ID_PERSON IN (" + page_main_.id_currentPerson  + ") AND " +
                       " DATE_TIME >= TO_DATE('" + date_begin_send + "','DD/MM/YY') AND" +
                       " DATE_TIME <= TO_DATE('" + date_end_send   + "','DD/MM/YY') ";

            Query1.setQueryAndName(querySql, "q1__report_AccumulatedDose_query2_4_1");

            /// IN_MEASURE
            querySql = " SELECT " +
                       " SUM(ACTIVITY_MEASURE) Z49 " +
                       " FROM IN_MEASURE WHERE " +
                       " ID_PERSON IN (" + page_main_.id_currentPerson  + ") AND " +
                       " NUCLIDE = 'Co-60' AND " +
                       " DATE_TIME >= TO_DATE('" + date_begin_send + "','DD/MM/YY') AND" +
                       " DATE_TIME <= TO_DATE('" + date_end_send   + "','DD/MM/YY') ";

            Query1.setQueryAndName(querySql, "q1__report_AccumulatedDose_query2_4_2");

            querySql = " SELECT " +
                       " SUM(ACTIVITY_MEASURE) Z54 " +
                       " FROM IN_MEASURE WHERE " +
                       " ID_PERSON IN (" + page_main_.id_currentPerson  + ") AND " +
                       " DATE_TIME >= TO_DATE('" + date_begin_send + "','DD/MM/YY') AND" +
                       " DATE_TIME <= TO_DATE('" + date_end_send   + "','DD/MM/YY') ";

            Query1.setQueryAndName(querySql, "q1__report_AccumulatedDose_query2_4_3");

            querySql = " SELECT " +
                       " SUM(ACTIVITY_MEASURE) Z59 " +
                       " FROM IN_MEASURE WHERE " +
                       " ID_PERSON IN (" + page_main_.id_currentPerson  + ") AND " +
                       " NUCLIDE <> 'Co-60' AND " +
                       " DATE_TIME >= TO_DATE('" + date_begin_send + "','DD/MM/YY') AND" +
                       " DATE_TIME <= TO_DATE('" + date_end_send   + "','DD/MM/YY') ";

            Query1.setQueryAndName(querySql, "q1__report_AccumulatedDose_query2_4_4");


            /// IN_IODINE
            querySql = " SELECT " +
                       " SUM(EXP_EFF_DOSE_I) Z46, SUM(ACTIVITY_IODINE) Z55 " +
                       " FROM IN_IODINE WHERE " +
                       " ID_PERSON IN (" + page_main_.id_currentPerson  + ") AND " +
                       " DATE_TIME >= TO_DATE('" + date_begin_send + "','DD/MM/YY') AND" +
                       " DATE_TIME <= TO_DATE('" + date_end_send   + "','DD/MM/YY') ";

            Query1.setQueryAndName(querySql, "q1__report_AccumulatedDose_query2_4_5");

            /// IN_MEASURE: EXP_EFF_DOSE_M
            querySql = " SELECT " +
                       " SUM(EXP_EFF_DOSE_M) Z44 " +
                       " FROM IN_MEASURE WHERE " +
                       " ID_PERSON IN (" + page_main_.id_currentPerson  + ") AND " +
                       " ORGAN = 'Легкие' AND " +
                       " DATE_TIME >= TO_DATE('" + date_begin_send + "','DD/MM/YY') AND" +
                       " DATE_TIME <= TO_DATE('" + date_end_send   + "','DD/MM/YY') ";

            Query1.setQueryAndName(querySql, "q1__report_AccumulatedDose_query2_4_6");



        }

    }

    Connections {
        id: report_query
        target: Query1

        onSignalSendResult: {
            if (res) {
                //completedZ = 0;
                if (owner_name == "q1__report_AccumulatedDose_query2_1") {
                    /// 2 4 5 6 7 8
                    report.setZ(var_res);
                    console.log(" var_res2_1 ==== ", var_res, " ", var_res["Z2"], var_res["Z4"], var_res["Z5"], var_res["Z6"], var_res["Z7"], var_res["Z8"]);
                }
                if (owner_name == "q1__report_AccumulatedDose_query2_2_1") {
                    /// 21 22 25 26 27 31 32 33
                    report.setZ(var_res);
                    console.log(" var_res2_2_1 ==== ", var_res, " ",var_res["Z2"], var_res["Z21"], var_res["Z22"], var_res["Z25"]);
                }
                if (owner_name == "q1__report_AccumulatedDose_query2_2_2") {
                    /// 23 24 28 29 30 34 35 36
                    report.setZ(var_res);
                    console.log(" var_res2_2_2 ==== ", var_res, " ", var_res["Z23"], var_res["Z24"], var_res["Z28"]);
                }

                if (owner_name == "q1__report_AccumulatedDose_query2_3_1") {
                    /// 37 38
                    report.setZ(var_res);
                    console.log(" var_res2_3_1 ==== ", var_res, " ", var_res["Z37"], var_res["Z38"]);
                }
                if (owner_name == "q1__report_AccumulatedDose_query2_3_2") {
                    /// 40 41
                    report.setZ(var_res);
                    console.log(" var_res2_3_2 ==== ", var_res, " ", var_res["Z40"], var_res["Z41"]);


                }

                if (owner_name == "q1__report_AccumulatedDose_query2_4_1") {
                    /// 43 48
                    report.setZ(var_res);
                    console.log(" var_res2_4_1 ==== ", var_res, " ", var_res["Z43"], var_res["Z48"]);
                }
                if (owner_name == "q1__report_AccumulatedDose_query2_4_2") {
                    /// 49
                    var Z = {};
                    Z["Z49"] = var_res;
                    report.setZ(Z);
                    console.log(" var_res2_4_2 ==== ", var_res);
                    Z = 0;
                }
                if (owner_name == "q1__report_AccumulatedDose_query2_4_3") {
                    /// 54
                    var Z = {};
                    Z["Z54"] = var_res;
                    report.setZ(Z);
                    console.log(" var_res2_4_3 ==== ", var_res);
                    Z = 0;
                }
                if (owner_name == "q1__report_AccumulatedDose_query2_4_4") {
                    /// 59
                    var Z = {};
                    Z["Z59"] = var_res;
                    report.setZ(Z);
                    console.log(" var_res2_4_4 ==== ", var_res);
                }
                if (owner_name == "q1__report_AccumulatedDose_query2_4_5") {
                    /// 46 55
                    report.setZ(var_res);
                    console.log(" var_res2_4_5 ==== ", var_res, " ", var_res["Z46"], var_res["Z55"]);
                }
                if (owner_name == "q1__report_AccumulatedDose_query2_4_6") {
                    /// 44
                    var Z = {};
                    Z["Z44"] = var_res;
                    report.setZ(Z);
                    console.log(" var_res2_4_6 ==== ", var_res, " ", var_res["Z44"]);
                    Z = 0;

                    report.beginCreateReport_AccumulatedDose();
                    report.showZ();
                    report.clearZ();
                }

                //Z = 0;
            }


        }




    }


}







/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
