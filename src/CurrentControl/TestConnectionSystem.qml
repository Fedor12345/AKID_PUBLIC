import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

Page {
    id: main_

    property string text_color: "#808080"
    property int numberAddPerson: 0
     property int numberSelectPerson: 0

    transformOrigin: Item.Center

    Connections {
        target: Query1
        onSignalSendResult: {

            if ( owner_name === "q1__AddPerson_test" ) {
                //console.log(" (!) q1__AddPerson_test_Result");
                listModel_infoTest.append({ nameQuery: owner_name,
                                            executeQuery: res
                                          })
                list_infoTest.positionViewAtEnd();

            }

            if ( owner_name === "q1__SelectPerson_test" ) {
                console.log(" (!) q1__SelectPerson_test_Result ", res , " ", var_res, " ", messageError);
                listModel_infoTest.append({ nameQuery: owner_name,
                                            executeQuery: res
                                          })
                list_infoTest.positionViewAtEnd();
            }

        }
    }


    Connections {
        target: managerDB

        onSignalSetQuery: {
            //console.log(typeQuery);
            //            listModel_infoTest.append({ name: typeQuery
            //                                      })
            //            list_infoTest.positionViewAtEnd();


            /// выполнение SQL запроса Select из таблицы EXT_PERSON по полю PERSON_NUMBER
            if ( typeQuery == "Select" ) {
                var query = " SELECT * FROM EXT_PERSON WHERE PERSON_NUMBER = " + main_.numberSelectPerson ;
                console.log(" (!) q1__SelectPerson_test: ", numberSelectPerson);

                Query1.setQueryAndName(query, "q1__SelectPerson_test");
                main_.numberSelectPerson++;
            }


            /// создание и выполнение SQL запроса для добавления случайно генерируемых данных в таблицу EXT_PERSON
            if (typeQuery == "AddPerson") {
                console.log(" (!) q1__AddPerson_test: ", numberAddPerson);
                ////////////////////////////////////////////////////////////////////////////
                /// генерация псевдослучайного числа от min до max (включительно)
                function randomInteger(min, max) {
                    // случайное число от min до (max+1)
                    let rand = min + Math.random() * (max + 1 - min);
                    return Math.floor(rand);
                }

                function random(min, max) {
                    // случайное число от min до (max+1)
                    let rand = min + Math.random() * (max + 1 - min);
                    return rand.toFixed(4);
                }

                /// генерация даты в предлеах от from до to
                function getRandomDate(from, to) {
                    from = from.getTime();
                    to = to.getTime();
                    return new Date(from + Math.random() * (to - from));
                }

                /// генерация псевдослучайного числа из массива
                function randomArray(myArray) {
                    var rand = myArray[Math.floor(Math.random() * myArray.length)];
                    return rand;
                }
                ////////////////////////////////////////////////////////////////////////////




//                var fromD = new Date(1940, 0, 1);
//                var toD = new Date(2000, 0, 1);
//                var randomN = getRandomDate(fromD, toD) // randomInteger(0,5);
                //var m = [1,3,5,7];
//                var randomN = randomArray([1,3,5,7]);
//                var randomN = random(0,2);
//                var randomN = randomArray(["Obninsk","Zelenograd","Moskow"]) + " " + randomInteger(1,99) + "," + randomInteger(1,99) //randomInteger(1111111111,9999999999);
//                listModel_infoTest.append({ nameQuery: randomN
//                                          })
//                list_infoTest.positionViewAtEnd();


                var data_arr = {};


                var nameF = ["Алена", "Екатерина", "Ольга", "Мария", "Полина", "Светлана", "Анастасия", "Анна", "Валентина", "Вероника",
                             "Дарья", "Зоя" ,"Анфиса" ,"Ирина" ,"Лариса" ,"Людмила" ,"Маргарита" ,"Надежда" ,"Наталья" ,"Инна" ,
                             "Серафима" ,"Оксана" ,"Татьяна" ,"Юлия" ,"Снежана" ,"Виолетта" ,"Грета" ,"Лара" ,"Ника" ,"София"]

                var nameM = ["Андрей", "Федор", "Дмитрий", "Антон", "Алексей", "Иван", "Михаил" ,"Артур" ,"Борис" ,"Вадим",
                             "Валентин" ,"Валерий" ,"Виктор" ,"Геннадий" ,"Герман" ,"Даниил" ,"Евгений" ,"Егор" ,"Игорь" ,"Кирилл",
                             "Лев" ,"Леонид" ,"Макар" ,"Олег" ,"Павел" ,"Пётр" ,"Руслан" ,"Семён" ,"Сергей" ,"Гуго"]

                var surname = ["Смирнов","Иванов","Кузнецов","Соколов","Попов","Лебедев", "Козлов", "Новиков", "Морозов", "Петров",
                                "Волков", "Соловьёв", "Васильев", "Зайцев", "Павлов", "Семёнов", "Голубев", "Виноградов", "Богданов", "Воробьёв", "Фёдоров", "Михайлов",
                                "Беляев" ,"Тарасов", "Белов", "Комаров", "Орлов", "Киселёв", "Макаров", "Андреев", "Ковалёв", "Ильин", "Гусев", "Титов", "Кузьмин",
                                "Кудрявцев", "Баранов", "Куликов", "Алексеев", "Степанов", "Яковлев", "Сорокин", "Сергеев", "Романов", "Захаров", "Борисов",
                                "Королёв", "Герасимов", "Пономарёв", "Григорьев"]

                var patronymicF = ["Алексевна", "Андреевна", "Антоновна", "Дмитриевна", "Ивановна", "Михаиловна", "Федоровна"]
                var patronymicM = ["Алексевич", "Андреевич", "Антонович", "Дмитриевич", "Иванович", "Михаилович", "Федорович"]


                data_arr["PERSON_NUMBER"] = numberAddPerson; //12 +
                data_arr["SEX"] = (randomInteger(0,1) === 0) ? "M" : "F";
                data_arr["W_NAME"]       = ((data_arr["SEX"] === "M") ? randomArray(nameM) : randomArray(nameF))
                data_arr["W_SURNAME"]    = randomArray(surname) + ((data_arr["SEX"] === "M") ? "" : "а");
                data_arr["W_PATRONYMIC"] = ((data_arr["SEX"] === "M") ? randomArray(patronymicM) : randomArray(patronymicF)) ;
                data_arr["STATUS_CODE"] = randomInteger(0,5);
                data_arr["BIRTH_DATE"]  = getRandomDate(new Date(1940, 0, 1), new Date(2000, 0, 1)); //.toLocaleDateString("ru_RU", "dd.MM.yyyy")
                data_arr["WEIGHT"] = randomInteger(50,150);
                data_arr["HEIGHT"] = randomInteger(140,220);
                data_arr["STAFF_TYPE"] = (randomInteger(0,1) === 0) ? "Персонал АЭС" : "Командировочный";
                data_arr["ID_DEPARTMENT_INNER"] = randomArray([1,3,5,7]);
                data_arr["ID_DEPARTMENT_OUTER"] = 0
                data_arr["ID_ORGANIZATION"] = randomArray([1,3,5]);
                data_arr["ID_ASSIGNEMENT"] = randomArray([1,3,5,7]);
                data_arr["ID_TLD"] = numberAddPerson; //12 +
                data_arr["DOSE_BEFORE_NPP"] = random(0, 5) //.replace(".", ",");
                data_arr["DOSE_CHNPP"] = random(0, 5) //.replace(".", ",");
                data_arr["IKU_YEAR"] = random(0, 5) //.replace(".", ",");
                data_arr["IKU_MONTH"] = random(0, 5) //.replace(".", ",");
                data_arr["AU"] = random(0, 5) //.replace(".", ",");
                data_arr["IU"] = random(0, 5) //.replace(".", ",");
                data_arr["EMERGENCY_DOSE"] = randomInteger(0, 1);
                data_arr["DISABLE_RADIATION"] = randomInteger(0, 1);
                data_arr["PASSPORT_NUMBER"] = randomInteger(1111111111,9999999999);
                data_arr["PASSPORT_GIVE"] = "ОВД г." + randomArray(["Obninsk","Zelenograd","Moskow","Saint Petersburg"]);
                data_arr["PASSPORT_DATE"] = getRandomDate(new Date(1960, 0, 1), new Date(2019, 0, 1)); //.toLocaleDateString("ru_RU", "dd.MM.yyyy")
                data_arr["SNILS"] = randomInteger(11111111111,99999999999);
                data_arr["WORK_TEL"] = randomInteger(11111,99999);
                data_arr["WORK_ADDRESS"] = randomArray(["Obninsk","Zelenograd","Moskow"]) + " " + randomInteger(1,99) + "," + randomInteger(1,99);
                data_arr["MOBILE_TEL"] = randomInteger(11111111111,99999999999);
                data_arr["HOME_TEL"]   = randomInteger(11111111111,99999999999);
                data_arr["HOME_ADDRESS"] = randomArray(["Obninsk","Zelenograd","Moskow","Saint Petersburg"]) + " " + randomInteger(1,99) + "," + randomInteger(1,99);
                var alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
                data_arr["E_MAIL"] = randomArray(alphabet) + randomArray(alphabet) + randomArray(alphabet) + randomArray(alphabet)+ randomArray(alphabet)+ randomArray(alphabet)
                                   + randomArray(["@mail.ru"], ["@gmail.com"], ["@yandex.ru"]);


                Query1.insertRecordIntoTable("q1__AddPerson_test","EXT_PERSON", data_arr);
                numberAddPerson ++;


//                var PERSON_NUMBER = 12 + numberAddPerson;
//                var SEX = (randomInteger(0,1) === 0) ? "M" : "F";

//                var W_NAME       = ((SEX === "M") ? randomArray(nameM) : randomArray(nameF))
//                var W_SURNAME    = randomArray(surname) + ((SEX === "M") ? "" : "а");
//                var W_PATRONYMIC = ((SEX === "M") ? randomArray(patronymicM) : randomArray(patronymicF));


//                var randomN = W_NAME + " " + W_SURNAME + " " + W_PATRONYMIC
//                listModel_infoTest.append({ name: randomN
//                                          })
//                list_infoTest.positionViewAtEnd();


//                var STATUS_CODE = randomInteger(0,5);
//                var BIRTH_DATE = "to_date('" + getRandomDate(new Date(1940, 0, 1), new Date(2000, 0, 1)).toLocaleDateString("ru_RU", "dd.MM.yyyy") + "','DD.MM.RR')";
//                var WEIGHT = randomInteger(50,150);
//                var HEIGHT = randomInteger(140,220);
//                var STAFF_TYPE = (randomInteger(0,1) === 0) ? "Персонал АЭС" : "Командировочный";
//                var ID_DEPARTMENT_INNER = randomArray([1,3,5,7]);
//                var ID_DEPARTMENT_OUTER = 0
//                var ID_ORGANIZATION = randomArray([1,3,5]);
//                var ID_ASSIGNEMENT = randomArray([1,3,5,7]);
//                var ID_TLD = 12 + numberAddPerson;
//                var DOSE_BEFORE_NPP = random(0, 5).replace(".", ",");
//                var DOSE_CHNPP = random(0, 5).replace(".", ",");;
//                var IKU_YEAR = random(0, 5).replace(".", ",");;
//                var IKU_MONTH = random(0, 5).replace(".", ",");;
//                var AU = random(0, 5).replace(".", ",");;
//                var IU = random(0, 5).replace(".", ",");;
//                var EMERGENCY_DOSE = randomInteger(0, 1);
//                var DISABLE_RADIATION = randomInteger(0, 1);
//                var PASSPORT_NUMBER = randomInteger(1111111111,9999999999);
//                var PASSPORT_GIVE = "ОВД г." + randomArray(["Obninsk","Zelenograd","Moskow","Saint Petersburg"]);
//                var PASSPORT_DATE = "to_date('" + getRandomDate(new Date(1960, 0, 1), new Date(2019, 0, 1)).toLocaleDateString("ru_RU", "dd.MM.yyyy") + "','DD.MM.RR')";
//                var SNILS = randomInteger(11111111111,99999999999);
//                var WORK_TEL = randomInteger(11111,99999);
//                var WORK_ADDRESS = randomArray(["Obninsk","Zelenograd","Moskow"]) + " " + randomInteger(1,99) + "," + randomInteger(1,99);
//                var MOBILE_TEL = randomInteger(11111111111,99999999999);
//                var HOME_TEL = randomInteger(11111111111,99999999999);
//                var HOME_ADDRESS = randomArray(["Obninsk","Zelenograd","Moskow","Saint Petersburg"]) + " " + randomInteger(1,99) + "," + randomInteger(1,99);
//                var alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
//                var E_MAIL = randomArray(alphabet) + randomArray(alphabet) + randomArray(alphabet) + randomArray(alphabet)+ randomArray(alphabet)+ randomArray(alphabet)
//                           + randomArray(["@mail.ru"], ["@gmail.com"], ["@yandex.ru"]);

//                var query = " Insert into " +
//                            " EXT_PERSON (PERSON_NUMBER, W_NAME, W_SURNAME, W_PATRONYMIC, STATUS_CODE, SEX, BIRTH_DATE, WEIGHT, HEIGHT, "           +
//                            " STAFF_TYPE, ID_DEPARTMENT_OUTER, ID_DEPARTMENT_INNER, ID_ORGANIZATION, ID_ASSIGNEMENT, ID_TLD, "                      +
//                            " DOSE_BEFORE_NPP, DOSE_CHNPP, IKU_YEAR, IKU_MONTH, AU, IU, EMERGENCY_DOSE, DISABLE_RADIATION, PASSPORT_NUMBER, "       +
//                            " PASSPORT_GIVE, PASSPORT_DATE, SNILS, WORK_TEL, WORK_ADDRESS, MOBILE_TEL, HOME_TEL, HOME_ADDRESS, E_MAIL) "            +
//                            " values ( '" + PERSON_NUMBER   + "','" + W_NAME           + "','" + W_SURNAME + "','" + W_PATRONYMIC    + "','" + STATUS_CODE         + "','" + SEX                 + "', " +
//                                            BIRTH_DATE      + " ,'" + WEIGHT           + "','" + HEIGHT    + "','" + STAFF_TYPE      + "','" + ID_DEPARTMENT_OUTER + "','" + ID_DEPARTMENT_INNER + "','" +
//                                            ID_ORGANIZATION + "','" + ID_ASSIGNEMENT   + "','" + ID_TLD    + "','" + DOSE_BEFORE_NPP + "','" + DOSE_CHNPP          + "','" + IKU_YEAR            + "','" +
//                                            IKU_MONTH       + "','" + AU               + "','" + IU        + "','" + EMERGENCY_DOSE  + "','" + DISABLE_RADIATION   + "','" + PASSPORT_NUMBER     + "','" +
//                                            PASSPORT_GIVE   + "', " + PASSPORT_DATE    + " ,'" + SNILS     + "','" + WORK_TEL        + "','" + WORK_ADDRESS        + "','" + MOBILE_TEL          + "','" +
//                                            HOME_TEL        + "','" + HOME_ADDRESS     + "','" + E_MAIL    + "')";




//                var query = " Insert into " +
//                            " EXT_PERSON (PERSON_NUMBER, W_NAME, W_SURNAME, W_PATRONYMIC, STATUS_CODE, SEX, BIRTH_DATE, WEIGHT, HEIGHT, " +
//                            " STAFF_TYPE, ID_DEPARTMENT_OUTER, ID_DEPARTMENT_INNER, ID_ORGANIZATION, ID_ASSIGNEMENT, ID_TLD, "                      +
//                            " DOSE_BEFORE_NPP, DOSE_CHNPP, IKU_YEAR, IKU_MONTH, AU, IU, EMERGENCY_DOSE, DISABLE_RADIATION, PASSPORT_NUMBER, "       +
//                            " PASSPORT_GIVE, PASSPORT_DATE, SNILS, WORK_TEL, WORK_ADDRESS, MOBILE_TEL, HOME_TEL, HOME_ADDRESS, E_MAIL) "            +
//                            " values ('5555', 'Иван', 'Иванов', 'Васильевич', '1', 'M', to_date('02.06.81','DD.MM.RR'),'90','170', "           +
//                            " 'Командировочный','17','0','1','5','6','1','2','3','4','5','6','0','0','123564','ОВД г. Обниск',to_date('27.08.10','DD.MM.RR')," +
//                            " '123456','36644','Обнинск 2,1','436734','35434','Обнинск 1,2','Jdkf@mail.ru') ";

                //Query1.setQueryAndName(query, "q1__AddPerson_test");


            }
        }

    }

    TextField {
        id: maxLenght
        anchors.bottom: test_elevation_start.top
        anchors.topMargin: 20
        anchors.horizontalCenter: test_elevation_start.horizontalCenter
        font.bold: true
        color: main_.text_color // Material.color(Material.Teal)
        selectByMouse: true
        selectionColor: Material.color(Material.Red)
        horizontalAlignment: Text.AlignHCenter
        placeholderText: qsTr("0")
        text: "0"
        width: 90
        onFocusChanged: {
            if (focus) { select(0, text.length) }
        }

        ToolTip {
            //parent: slider.handle
            visible: parent.focus
            //text: "Добавляет скрипт в список на выполнение\nв данный момент работают Select и AddPerson"
            contentItem: Text {
                text:"Число итераций\n\n0 - означает, что будет выполняться\nпока не будет нажата кнопка STOP TEST"
                    //parent.text
                font.pixelSize: 15
                color: "white" //"#21be2b"
            }
        }


    }


    /// кнопка начать тест
    Pane {
        id: test_elevation_start
        property double elevation_: 1.0
        //anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.left: parent.left
        anchors.leftMargin: 50
        width: 120
        height: 120 //120

        Material.elevation: elevation_

        Rectangle {
            anchors.fill:  parent
            border.width: 1
        }       

        MouseArea {
            anchors.fill: parent
            anchors.margins: -10
            hoverEnabled: true
            onEntered:  { test_elevation_start.animationStart(1.0, 6.0,"elevation_" ) }
            onExited:   { test_elevation_start.animationStart(6.0, 1.0,"elevation_" ) }
            onPressed:  {  }
            onReleased: {  }
            onClicked:  {
                if ( listModel_scripts.count > 0 ) {
                    console.log(" (!) START TEST ", listModel_scripts.count);

                    var scripts = {};
                    for ( var i = 0; i < listModel_scripts.count; i++ ) {
                        scripts[i] = [];
                        for ( var key in listModel_scripts.get(i) ) {
                            scripts[i].push( listModel_scripts.get(i)[key] );
                        }
                    }
    //                scripts = {};
    //                scripts[0] = [ "1", "Select", "10" ]
    //                scripts[1] = [ "10","Delete", "5"  ]

                    managerDB.pauseTest1();
                    managerDB.startTest1(scripts,maxLenght.text);
                }

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
            target: test_elevation_start
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
            text: qsTr("START\nTEST")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
            //color: Material.color(Material.Green)
        }
    }

    /// остановаить тест
    Pane {
        id: test_elevation_stop
        property double elevation_: 1.0
        anchors.top: test_elevation_start.bottom
        anchors.topMargin: 50
        anchors.left: parent.left
        anchors.leftMargin: 50
        width:  120
        height: 120

        Material.elevation: elevation_

        Rectangle {
            anchors.fill:  parent
            border.width: 1
        }

        MouseArea {
            anchors.fill: parent
            anchors.margins: -10
            hoverEnabled: true
            onEntered:  { test_elevation_stop.animationStart(1.0, 6.0,"elevation_" ) }
            onExited:   { test_elevation_stop.animationStart(6.0, 1.0,"elevation_" ) }
            onPressed:  {  }
            onReleased: {  }
            onClicked:  {
                console.log(" (!) STOP TEST ");
                managerDB.pauseTest1();

            }
        }

        function animationStart (startValue, endValue, properties) {
            animation_stopButton.startValue = startValue;
            animation_stopButton.endValue = endValue;
            animation_stopButton.properties = properties;
            animation_stopButton.stop();
            animation_stopButton.running = true;
        }
        NumberAnimation {
            id: animation_stopButton
            property double startValue
            property double endValue
            target: test_elevation_stop
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
            text: qsTr("STOP\nTEST")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
            //color: Material.color(Material.Red)
        }
    }

    /// линии от кнопок к панели (для ркасоты)
    Rectangle {
        anchors.top:   test_elevation_start.verticalCenter
        anchors.left:  test_elevation_start.right
        anchors.right: pane_Scripts.left
        height: 1
        color: "LightGray"
    }
    Rectangle {
        anchors.top:   test_elevation_stop.verticalCenter
        anchors.left:  test_elevation_stop.right
        anchors.right: pane_Scripts.left
        height: 1
        color: "LightGray"
    }

    /// панель с опциями теста
    Pane {
        id: pane_Scripts
        property double elevation_: 1.0

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: test_elevation_start.right
        anchors.margins: 20
        width: 370

        Material.elevation: elevation_

        Rectangle {
            anchors.fill:  parent
            border.color: "LightGray"
        }



        Rectangle {
            id: header_listScript
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 40
            color: "#ececec"  //Transparent
            border.color: "LightGray"
            Text {
                anchors.centerIn: parent
                text: qsTr("Последовательность")
                font.pixelSize: 17
                font.bold: true
                color: main_.text_color
            }

            Rectangle {
                id: item_deleteScript
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                width: 30
                height: 30
                border.color: "LightGray"
                Image {
                    id: img_deleteScript
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 5
                    height: width
                    source: "icons/delete-24px.svg"
                    opacity: 0.3
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: { img_deleteScript.opacity = 0.7 }
                    onExited:  { img_deleteScript.opacity = 0.3 }
                    onClicked: { listModel_scripts.remove(list_scripts.currentIndex) }

                    ToolTip {
                        visible: parent.containsMouse
                        contentItem: Text {
                            text: "Удалить выбранную строку"
                            font.pixelSize: 15
                            color: "white"
                        }
                    }
                }




            }


        }

        Item {
            id: rect_listScript
            anchors.top: header_listScript.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: header_rect_optionsScript.top
            //height: 300
            //color: "transparent"
            //border.color: "LightGray"


            Item {
                id: header_rect_listScript
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: 40
                //color: "transparent"
                //border.color: "LightGray"
                RowLayout {
                    anchors.fill: parent
                    spacing: 0
                    Item {
                        Layout.minimumWidth: 40
                        Layout.maximumWidth: 40
                        Layout.fillHeight: true
                        Text {
                            width: parent.width
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 12
                            color: main_.text_color
                            font.bold: true
                            text: "№"
                        }
                        Rectangle {
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            width: 1
                            color: "LightGray"
                        }
                    }
                    Item {
                        Layout.fillWidth:  true
                        Layout.fillHeight: true
                        Text {
                            width: parent.width
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 12
                            color: main_.text_color
                            wrapMode: Text.WordWrap
                            font.bold: true
                            text: "Интервал времени"
                        }
                        Rectangle {
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            width: 1
                            color: "LightGray"
                        }
                    }
                    Item {
                        Layout.minimumWidth: 120
                        Layout.maximumWidth: 120
                        Layout.fillHeight: true
                        //border.color: "LightGray"
                        Text {
                            width: parent.width
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 12
                            color: main_.text_color
                            wrapMode: Text.WordWrap
                            font.bold: true
                            text: "Тип запросов"
                        }
                        Rectangle {
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            width: 1
                            color: "LightGray"
                        }
                    }
                    Item {
                        Layout.fillWidth:  true
                        Layout.fillHeight: true
                        Text {
                            width: parent.width
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 12
                            color: main_.text_color
                            wrapMode: Text.WordWrap
                            font.bold: true
                            text: "Количество запросов"
                        }
                    }
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 1
                    color: "LightGray"
                }
            }


            Item {
                id: rect_deleteScript
//                MouseArea {
//                    anchors.fill: parent
//                    hoverEnabled: true
//                    onEntered: { }
//                    onExited:  { }
//                    onClicked: { }
//                }
            }

            ListView {
                id: list_scripts
                anchors.top: header_rect_listScript.bottom
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right

                clip: true


//                onCountChanged: {
//                    console.log("This prints properly.")
//                    var newIndex = count - 1 // last index
//                    positionViewAtEnd();
//                    currentIndex = newIndex
//                }

                model: ListModel {
                    id: listModel_scripts
                }
                highlightFollowsCurrentItem: true
                highlight: Rectangle {
                    color: "#dedede"
                }
                highlightMoveDuration: 100


                delegate: ItemDelegate {
                    //width: parent.width
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 40
                    //anchors.margins: 10
                    RowLayout {
                        anchors.fill: parent
                        spacing: 0
                        Item {
                            Layout.minimumWidth: 40
                            Layout.maximumWidth: 40
                            Layout.fillHeight: true
                            //Layout.alignment: Qt.AlignCenter
                            Text {
                                anchors.centerIn: parent
                                font.pixelSize: 11
                                color: main_.text_color
                                text: index
                            }
                            Rectangle {
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.right: parent.right
                                width: 1
                                color: "LightGray"
                            }
                        }
                        Item {
                            Layout.fillWidth:  true
                            Layout.fillHeight: true
                            Text {
                                anchors.centerIn: parent
                                font.pixelSize: 11
                                color: main_.text_color
                                text: timeInterval
                            }
                        }
                        Item {
                            Layout.minimumWidth: 120
                            Layout.maximumWidth: 120
                            Layout.fillHeight: true
                            Text {
                                anchors.centerIn: parent
                                font.pixelSize: 11
                                color: main_.text_color
                                text: typeOfQueries
                            }
                        }
                        Item {
                            Layout.fillWidth:  true
                            Layout.fillHeight: true

                            Text {
                                anchors.centerIn: parent
                                font.pixelSize: 11
                                color: main_.text_color
                                text: numberOfQueries
                            }
                        }
                    }

                    onClicked: {
                        if (list_scripts.currentIndex !== index) {
                            list_scripts.currentIndex = index
                        }
                        rect_deleteScript.x = x + width
                        rect_deleteScript.y = y + height
                        rect_deleteScript.height = height
                        rect_deleteScript.width = 30
                        //menu_deleteScript.open();
                    }
                    Menu {
                        id: menu_deleteScript
//                        x: mouseX
//                        y: mouseY

                        MenuItem {
                            text: "Удалить"
                        }
                        MenuSeparator { }

                        Menu {
                            title: "Далее"
                            Action { text: "First" }
                            Action { text: "Secont" }
                            Action { text: "Third" }
                        }


                    }
                }

            }

        }

        Rectangle {
            id: header_rect_optionsScript
            //anchors.top: rect_listScript.bottom
            anchors.bottom: rect_optionsScript.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 40
            color: "#ececec"  //Transparent
            border.color: "LightGray"
            Text {
                anchors.centerIn: parent
                text: qsTr("Опции последовательности")
                font.pixelSize: 17
                font.bold: true
                color: main_.text_color
            }
        }

        Item {
            id: rect_optionsScript
            property int typeQuery: 1
            //anchors.top: header_rect_optionsScript.bottom
            anchors.bottom: rect_addScript.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 150
            //color: "Transparent"
            //border.color: "LightGray"
            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                RowLayout {
                    spacing: 0
                    //Layout.minimumHeight: 50
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Item {
                        Layout.fillHeight: true
                        Layout.minimumWidth: 170
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            color: main_.text_color
                            text: qsTr("Интервал времени, мс:")
                            font.pixelSize: 15
                        }
                    }
                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        TextField {
                            id: timeInterval
                            anchors.centerIn: parent
                            font.bold: true
                            color: main_.text_color // Material.color(Material.Teal)
                            selectByMouse: true
                            selectionColor: Material.color(Material.Red)
                            horizontalAlignment: Text.AlignHCenter
                            placeholderText: qsTr("100")
                            text: "100"

                            onTextChanged: {
                                if (text < 10)     { text = 10 }
                                if (text > 300000) { text = 30000 }
                            }
//                            validator:
//                                //IntValidator {bottom: 10; top: 20 }
////                                RegExpValidator {
////                                    regExp: /[10-300000]+/
////                                }
                            width: 90
                            onFocusChanged: {
                                if (focus) { select(0, text.length) }
                            }
                        }
                    }
                }
                RowLayout {
                    spacing: 0
                    //Layout.minimumHeight: 50
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Item {
                        Layout.fillHeight: true
                        Layout.minimumWidth: 120
                        //border.color: "LightGray"
                        Text {
//                            anchors.centerIn: parent
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            color: main_.text_color
                            text: qsTr("Тип запросов:")
                            font.pixelSize: 15
                        }
                    }
                    Item {
                        Layout.fillHeight: true
                        Layout.minimumWidth: 50

                        Column {
                            anchors.centerIn: parent
                            Rectangle {
                             width: 20
                             height: 20
                             border.color: "LightGray"
                             Text {
                                 anchors.centerIn: parent
                                 text: qsTr("1")
                                 color: main_.text_color
                             }
                             MouseArea {
                                 anchors.fill: parent
                                 hoverEnabled: true
                                 onEntered:  { parent.color = "#e3e3e3" }
                                 onExited:   { parent.color = "white"   }
                                 onPressed:  {  }
                                 onReleased: {  }
                                 onClicked:  {
                                     rect_optionsScript.typeQuery = 1;
                                 }
                             }
                            }
                            Rectangle {
                                width: 20
                                height: 20
                                border.color: "LightGray"
                                Text {
                                    anchors.centerIn: parent
                                    text: qsTr("2")
                                    color: main_.text_color
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered:  { parent.color = "#e3e3e3" }
                                    onExited:   { parent.color = "white"   }
                                    onPressed:  {  }
                                    onReleased: {  }
                                    onClicked:  {
                                        rect_optionsScript.typeQuery = 2;
                                    }
                                }
                            }

                        }


//                        Row {
//                            anchors.verticalCenter: parent.verticalCenter
//                            spacing: 2
//                            Column {
//                                //visible: false
//                                anchors.verticalCenter: parent.verticalCenter
//                                //anchors.centerIn: parent
//                                Rectangle {
//                                 width: 20
//                                 height: 20
//                                 border.color: "LightGray"
//                                 Text {
//                                     anchors.centerIn: parent
//                                     text: qsTr("1")
//                                     color: main_.text_color
//                                 }
//                                 MouseArea {
//                                     anchors.fill: parent
//                                     hoverEnabled: true
//                                     onEntered:  { parent.color = "#e3e3e3" }
//                                     onExited:   { parent.color = "white"   }
//                                     onPressed:  {  }
//                                     onReleased: {  }
//                                     onClicked:  {
//                                         tumbler_optionsScript.currentIndex = 0;
//                                         //rect_optionsScript.typeQuery = 1;
//                                     }
//                                 }
//                                }
//                                Rectangle {
//                                    width: 20
//                                    height: 20
//                                    border.color: "LightGray"
//                                    Text {
//                                        anchors.centerIn: parent
//                                        text: qsTr("2")
//                                        color: main_.text_color
//                                    }
//                                    MouseArea {
//                                        anchors.fill: parent
//                                        hoverEnabled: true
//                                        onEntered:  { parent.color = "#e3e3e3" }
//                                        onExited:   { parent.color = "white"   }
//                                        onPressed:  {  }
//                                        onReleased: {  }
//                                        onClicked:  {
//                                            tumbler_optionsScript.currentIndex = 1;
//                                            //rect_optionsScript.typeQuery = 2;
//                                        }
//                                    }
//                                }

//                            }

//                            Tumbler {
//                                id: tumbler_optionsScript
//                                //anchors.centerIn: parent
//                                anchors.verticalCenter: parent.verticalCenter
//                                height: 80
//                                width: 20
//                                model: 2
//                            }
//                        }



//                        Switch {
//                                text: qsTr("Случайный/функции")
//                            }
                    }
                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        //Layout.minimumWidth: 50
                        //border.color: "LightGray"
                        ComboBox {
                            id: typeOfQueries_2
                            visible: (rect_optionsScript.typeQuery == 2) ? true : false //( tumbler_optionsScript.currentIndex == 1) ? true : false //
                            model: ["updatePersonModel", "getPersonPhoto", "getPersonParameters","getBurnDate", "getResultsSICH", "insertIntoDB"]
                            anchors.centerIn: parent
                            width: 170
                            font.pixelSize: 14

                            delegate: ItemDelegate {
                                    width: parent.width
                                    contentItem: Text {
                                        text: modelData
                                        color: main_.text_color// "#21be2b"
                                        font.pixelSize: 14
                                        //font: control.font
                                        //elide: Text.ElideRight
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    highlighted: parent.highlightedIndex === index
                                }

                        }

                        SpinBox {
                            id: typeOfQueries_1
                            visible: (rect_optionsScript.typeQuery == 1) ? true : false //( tumbler_optionsScript.currentIndex == 0) ? true : false //
                            anchors.centerIn: parent
                            width: 170
                            to: items.length - 1
                            value: 0 // "Select"

                            property var items: ["Select", "Add", "Delete", "AddPerson"]
                            onDisplayTextChanged: {
                                if ( displayText == "AddPerson") {
                                popup_setPERSON_NUMBER.open();
                                }
                            }

//                            validator: RegExpValidator {
//                                regExp: new RegExp("(Select|Add|Delete)", "i")
//                            }

                            textFromValue: function(value) {
                                return items[value];
                            }

                            valueFromText: function(text) {
                                for (var i = 0; i < items.length; ++i) {
                                    if (items[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                                        return i
                                }
                                return sb.value
                            }

                            contentItem: TextInput {
                                    z: 2
                                    text: typeOfQueries_1.textFromValue(typeOfQueries_1.value, typeOfQueries_1.locale)

                                    //font: control.font
                                    font.pixelSize: 14
                                    font.bold: true
                                    color: main_.text_color //Material.color(Material.Teal)
                                    //selectionColor: "#21be2b"
                                    //selectedTextColor: "#ffffff"
                                    horizontalAlignment: Qt.AlignHCenter
                                    verticalAlignment: Qt.AlignVCenter

                                    //readOnly: !control.editable
                                    //validator: control.validator
                                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                                }
                            up.indicator: Item {
                                x: typeOfQueries_1.mirrored ? 0 : parent.width - width
                                height: parent.height
                                implicitWidth: 40
                                implicitHeight: 40
                                //color: control.up.pressed ? "#e4e4e4" : "#f6f6f6"
                                //border.color: enabled ? "#21be2b" : "#bdbebf"

                                Text {
                                    text: ">"
                                    opacity: (typeOfQueries_1.value < 3) ? 1 : 0.2
                                    font.pixelSize: typeOfQueries_1.font.pixelSize * 1.5
                                    color: main_.text_color //"#21be2b"
                                    anchors.fill: parent
                                    fontSizeMode: Text.Fit
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                            down.indicator:  Item {
                                x: typeOfQueries_1.mirrored ? parent.width - width : 0
                                height: parent.height
                                implicitWidth: 40
                                implicitHeight: 40
                                //color: control.down.pressed ? "#e4e4e4" : "#f6f6f6"
                                //border.color: enabled ? "#21be2b" : "#bdbebf"

                                Text {
                                    text: "<"
                                    opacity: (typeOfQueries_1.value > 0) ? 1 : 0.2
                                    font.pixelSize: typeOfQueries_1.font.pixelSize * 1.5
                                    color: main_.text_color // "#21be2b"
                                    anchors.fill: parent
                                    fontSizeMode: Text.Fit
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }


                        Popup {
                            id: popup_setPERSON_NUMBER
                            width: itrm_setPERSON_NUMBER.width + padding*2
                            height: itrm_setPERSON_NUMBER.height + padding*2
                            modal: true
                            focus: true
                            closePolicy: Popup.NoAutoClose //Popup.CloseOnEscape
                            parent: Overlay.overlay
                            x: Math.round((parent.width - width) / 2)
                            y: Math.round((parent.height - height) / 2)
                            padding: 0

                            Item {
                                id: itrm_setPERSON_NUMBER
                                height: 80
                                width:  400
                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 20
                                    Text {
                                        color: main_.text_color
                                        font.pixelSize: 15
                                        text: qsTr("PERSON_NUMBER:")
                                    }
                                    TextField {
                                        id: txt_setPERSON_NUMBER
                                        Layout.minimumWidth: 100
                                        font.bold: true
                                        color: main_.text_color // Material.color(Material.Teal)
                                        selectByMouse: true
                                        selectionColor: Material.color(Material.Red)
                                        horizontalAlignment: Text.AlignHCenter
                                        placeholderText: qsTr("NUMBER")
                                        validator: RegExpValidator { regExp: /[0-9]+/ }
                                        onFocusChanged: {
                                            if (focus) { select(0, text.length) }
                                        }
                                    }
                                    Button {
                                        text: "ok"
                                        onClicked: {
                                            if (txt_setPERSON_NUMBER.text > 0) {
                                                main_.numberAddPerson = txt_setPERSON_NUMBER.text;
                                                popup_setPERSON_NUMBER.close();
                                            }
                                        }

                                    }

                                }

                            }
                        }

                    }
                }
                RowLayout {
                    spacing: 0
                    //Layout.minimumHeight: 50
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Item {
                        Layout.fillHeight: true
                        Layout.minimumWidth: 170
                        //border.color: "LightGray"
                        Text {
                            //                            anchors.centerIn: parent
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            color: main_.text_color
                            text: qsTr("Число запросов:")
                            font.pixelSize: 15

                            ////////////
                            enabled: false
                            opacity: 0.5
                        }
                    }
                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        //Layout.minimumWidth: 50
                        //border.color: "LightGray"
                        TextField {
                            id: numberOfQueries
                            anchors.centerIn: parent
                            font.bold: true
                            color: main_.text_color // Material.color(Material.Teal)
                            selectByMouse: true
                            selectionColor: Material.color(Material.Red)
                            horizontalAlignment: Text.AlignHCenter
                            placeholderText: qsTr("1")
                            text: "1"
                            width: 90
                            onFocusChanged: {
                                if (focus) { select(0, text.length) }
                            }

                            ////////////
                            enabled: false
                            opacity: 0.5
                        }
                    }
                }

            }


        }

        Rectangle {
            id: rect_addScript
            //visible: false
            //anchors.top: rect_optionsScript.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 50
            color: "Transparent" //Transparent
            border.color: "LightGray"

            Rectangle {
                id: color_addScript
                anchors.fill: parent
                anchors.margins: 1
                //anchors.centerIn: parent
                height: 40
                width: 80

                color: Material.color(Material.LightGreen)

                Behavior on color {
                    ColorAnimation { duration: 200 } //NumberAnimation //ColorAnimation
                }
            }

            Text {
                anchors.centerIn: parent
                color: "White" //main_.text_color
                font.pixelSize: 17
                text: "Добавить последовательность"
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered:  { color_addScript.color = Material.color(Material.Lime) /*"#e3e3e3"*/ } //cfcfcf //#e3e3e3
                onExited:   { color_addScript.color = Material.color(Material.LightGreen) /*"white"*/ }
                onPressed:  {  }
                onReleased: {  }
                onClicked:  {
                    console.log(" (!) CLICK! ")                    
                    listModel_scripts.append({ timeInterval: timeInterval.text,
                                               typeOfQueries: (rect_optionsScript.typeQuery == 1) ? typeOfQueries_1.displayText : typeOfQueries_2.displayText, //typeOfQueries.displayText,
                                               numberOfQueries: numberOfQueries.text
                                             })
                    list_scripts.positionViewAtEnd();
                }


                ToolTip {
                    //parent: slider.handle
                    visible: parent.containsMouse
                    contentItem: Text {
                        text:"Добавляет скрипт в список на выполнение\n\nВ данный момент работают:\nSelect и AddPerson"
                            //parent.text
                        font.pixelSize: 15
                        color: "white" //"#21be2b"
                    }
                }
            }





        }


    }


    /// панель с результатами теста
    Pane {
        id: rect_info
        property double elevation_: 1.0

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: pane_Scripts.right
        anchors.margins: 20
        anchors.right: parent.right
//        color: "transparent"
//        border.color: "LightGray"

        Material.elevation: elevation_


        Rectangle {
            anchors.fill:  parent
            border.color: "LightGray"
        }

        Rectangle {
            id: header_listResult
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 40
            color: "#ececec"  //Transparent
            border.color: "LightGray"
            Text {
                anchors.centerIn: parent
                text: qsTr("Результаты")
                font.pixelSize: 17
                font.bold: true
                color: main_.text_color
            }

            Rectangle {
                id: item_deleteResult
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                width: 30
                height: 30
                border.color: "LightGray"
                Image {
                    id: img_deleteResult
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 5
                    height: width
                    source: "icons/delete-24px.svg"
                    opacity: 0.3
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: { img_deleteResult.opacity = 0.7 }
                    onExited:  { img_deleteResult.opacity = 0.3 }
                    onClicked: { listModel_infoTest.clear(); }
                    ToolTip {
                        visible: parent.containsMouse
                        contentItem: Text {
                            text: "Очистить весь список"
                            font.pixelSize: 15
                            color: "white"
                        }
                    }
                }
            }


        }


        ListView {
            id: list_infoTest
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.top: header_listResult.bottom

            //anchors.fill: parent
            clip: true

//            onCountChanged: {
//                console.log("This prints properly.")
//                var newIndex = count - 1 // last index
//                positionViewAtEnd();
//                currentIndex = newIndex
//            }

            model: ListModel {
                id: listModel_infoTest
            }

//            onCountChanged: {
//                if( count >= 50000 ) {
//                    managerDB.pauseTest1();
//                }
//            }


            highlightFollowsCurrentItem: true
            highlight: Rectangle {
                color: "#b2b2b2"
            }
            highlightMoveDuration: 100

            delegate: ItemDelegate {
                //width: parent.width
                anchors.left: parent.left
                anchors.right: parent.right
                //anchors.margins: 10
                RowLayout {
                    anchors.fill: parent
                    spacing: 0
                    Item {
                        Layout.minimumWidth: 40
                        Layout.maximumWidth: 40
                        Layout.fillHeight: true
                        //Layout.alignment: Qt.AlignCenter
                        Text {
                            anchors.centerIn: parent
                            font.pixelSize: 11
                            color: main_.text_color
                            text: index
                        }
                        Rectangle {
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            width: 1
                            color: "LightGray"
                        }
                    }
                    Item {
                        Layout.fillWidth:  true
                        Layout.fillHeight: true
                        Text {
                            anchors.centerIn: parent
                            font.pixelSize: 11
                            color: main_.text_color
                            text: nameQuery
                        }
                    }
                    Item {
                        Layout.fillWidth:  true
                        Layout.fillHeight: true
                        Text {
                            anchors.centerIn: parent
                            font.pixelSize: 11
                            color: main_.text_color
                            text: executeQuery
                        }
                    }


                }

                onClicked: {
                    if (list_infoTest.currentIndex !== index) {
                        list_infoTest.currentIndex = index
                    }
                }

            }

        }

    }

}




/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:7;anchors_height:110;anchors_width:356;anchors_x:8;anchors_y:8}
}
 ##^##*/
