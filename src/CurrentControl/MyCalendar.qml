import QtQuick 2.12
import QtQuick.Controls 2.5
import Qt.labs.calendar 1.0
import QtQuick.Layouts 1.3

import QtQuick.Controls.Material 2.3

Item {
    id: root
    width: 170 //id_cb.width//+img_erase.width+8   //contentWidth
    height: id_cb.height //contentHeight
    //border.width: 1
    //color: "transparent"

    property date date_val
    //property date date_buf: date_val
    property bool ready: controlField()
    property var cbwidth: width
    property var sizeNumbers: 14

    property alias openCalendarMenu: mycalendar.visible

    onReadyChanged: {
        if (ready == false) {
            date_val = ""
            txt_day.text   = "";
            txt_month.text = "";
            txt_year.text  = "";
        }
    }

//    onDate_valChanged: {
//        ready = true;
//        date_buf = date_val;
//        txt_day.text   = qsTr(date_val.getDate().toString());
//        txt_month.text = qsTr(( date_val.getMonth()+1 ).toString());
//        txt_year.text  = qsTr(date_val.getFullYear().toString());
//    }



    /// проверка на заполненность полей даты
    function controlField () {
        //console.log("check field...")
        var isOk

        if (txt_day.text.length > 0) { isOk = true }
        else                         { return false }

        if (txt_month.text.length > 0) { isOk = true }
        else                           { return false }

        if (Number(txt_year.text) >= 1901) { isOk = true }
        else                               { return false }

        return isOk
    }


    ComboBox {
        id: id_cb
        anchors.right: parent.right
        anchors.rightMargin: 10
        width: root.cbwidth - 20 //img_erase.width
        padding: 0
        font.pixelSize: 16
        hoverEnabled: true
        //displayText: !ready ? "":date_val.toLocaleDateString("ru_RU", date_val, "dd.MM.yyyy")


//        TextField {
//            id:textEditTD
//            text: {
//                var day = date_val.getDate().toString();
//                if ( day.length < 2 ) {
//                    day = "0" + day;
//                }
//                var month = ( date_val.getMonth() + 1 ).toString();
//                if ( month.length < 2 ) {
//                    month = "0" + month;
//                }
////                var year = date_val.getFullYear().toString();
////                if ( year.length < 2 ) {
////                    year = "000" + year;
////                }
//                qsTr(day + ":" + month + ":" + date_val.getFullYear().toString()) //"00:00:00"

//            }
//            inputMask: "99.99.9999"
//            inputMethodHints: Qt.ImhDigitsOnly
//            selectByMouse: true
//            //validator: RegExpValidator { regExp: /^([0-1]?[0-9]|2[0-3]).([0-5][0-9]).[0-5][0-9]$ / }
//            //validator: RegExpValidator { regExp: /[0-9A-F]+/  }
//            //    /[0-9A-F]+/
//            validator: RegExpValidator { regExp: /^([0-3]?[0-9]).([0-1][0-9]).[0-9A-F]+/ }

//            width:100
//            height:50
////            background:Rectangle{
////                color:"transparent"
////                border.color: "red"
////                border.width:2
////                radius:(width * 0.05)
////            }
//        }



        Row {
            anchors.right: parent.right
            anchors.rightMargin: 45
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            spacing: 3
            TextField {
                id: txt_day
                width: 20
                //top
                //topPadding: 10
                selectByMouse: true
                horizontalAlignment: Text.AlignHCenter
                //placeholderText: qsTr(date_val.getDate().toString())
                text: (root.date_val.getDate()) ? root.date_val.getDate() : ""
                font.pixelSize: root.sizeNumbers
                maximumLength: 2
                validator: RegExpValidator { regExp: /[0-9A-F]+/ } /// ограничение для ввода: только числа
                onFocusChanged: { if(focus) { select(0, text.length) } }
                onTextEdited: {
                    if (txt_year.text.length > 0 && txt_month.text.length > 0 && txt_day.text.length > 0) {
                        if (Number(text) !== 0) {
                            date_val = new Date(Number(txt_year.text), Number(txt_month.text)-1, Number(txt_day.text));
                            txt_day.text   = qsTr(date_val.getDate().toString());
                            txt_month.text = qsTr(( date_val.getMonth()+1 ).toString());
                            txt_year.text  = qsTr(date_val.getFullYear().toString());
                            console.log(" (!) txt_day: date_val = ", date_val);
                        }
                    }

                    if (cursorPosition == 2) {
                        txt_month.focus = true
                    }

                    ready = controlField();

                }

            }
            Text {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                text: "."
            }
            TextField {
                id: txt_month
                width: 20
                selectByMouse: true
                horizontalAlignment: Text.AlignHCenter
                //placeholderText: qsTr((date_val.getMonth()+1).toString())
                text: (root.date_val.getMonth()) ? root.date_val.getMonth()+1 : ""
                font.pixelSize: root.sizeNumbers
                maximumLength: 2
                validator: RegExpValidator { regExp: /[0-9A-F]+/ } /// ограничение для ввода: только числа
                onFocusChanged: { if(focus) { select(0, text.length) } }
                onTextEdited: {
                    console.log(" (!) txt_month: text = ", text);
                    if (txt_year.text.length > 0 && txt_month.text.length > 0 && txt_day.text.length > 0) {
                        if (Number(text) !== 0) {
                            date_val = new Date(Number(txt_year.text), Number(txt_month.text)-1, Number(txt_day.text));
                            txt_day.text   = qsTr(date_val.getDate().toString());
                            txt_month.text = qsTr(( date_val.getMonth()+1 ).toString());
                            txt_year.text  = qsTr(date_val.getFullYear().toString());
                            console.log(" (!) txt_month: text = ", text);
                            console.log(" (!) txt_month: date_val = ", date_val);
                        }

                    }
                    if (cursorPosition == 2) {
                        txt_year.focus = true
                    }

                    ready = controlField();

                }
            }
            Text {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                text: "."
            }
            TextField {
                id: txt_year
                width: 40
                selectByMouse: true
                horizontalAlignment: Text.AlignHCenter
                //placeholderText: qsTr(date_val.getFullYear().toString())
                text: (root.date_val.getFullYear()) ? root.date_val.getFullYear() : ""
                font.pixelSize: root.sizeNumbers
                maximumLength: 4
                validator: RegExpValidator { regExp: /[0-9A-F]+/ } /// ограничение для ввода: только числа
                onFocusChanged: { if(focus) { select(0, text.length) } }
                onTextEdited: {
                    if ( Number(text) >= 1901 ) {
                        if ( txt_year.text.length > 0 && txt_month.text.length > 0 && txt_day.text.length > 0 ) {
                            date_val = new Date(Number(txt_year.text), Number(txt_month.text)-1, Number(txt_day.text));
                            txt_day.text   = qsTr(date_val.getDate().toString());
                            txt_month.text = qsTr(( date_val.getMonth()+1 ).toString());
                            txt_year.text  = qsTr(date_val.getFullYear().toString());
                            console.log(" (!) txt_year: date_val = ", date_val);
                        Material.accent = Material.LightBlue
                        }
                    }
                    else {
                        Material.accent = Material.Red
                    }

                    ready = controlField();
                }
            }
        }


        indicator: Image {
            id: ind
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            source: "icons/calendar.svg"
            opacity: (root.enabled) ? 0.7 : 0.2
        }

        popup: Popup {
            id: mycalendar
            parent: id_cb


            onOpened:  {
                if ( txt_year.text.length > 0 )   grid.year  = txt_year.text;
                if ( txt_month.text.length > 0 )  grid.month = txt_month.text - 1; // grid.month = date_val.getMonth();
            }
            onClosed: {
                popup_findYear.close();
                if ( txt_year.text.length > 0 )   grid.year  = txt_year.text;
                if ( txt_month.text.length > 0 )  grid.month = txt_month.text - 1; // grid.month = date_val.getMonth();
            }

            ColumnLayout {
                spacing: 1

                /// заголовок год
                Rectangle {
                    id: rect_year
                    width:grid.width
                    height: 25
                    color: "LightGrey"


                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top:  parent.top
                        anchors.bottom: parent.bottom
                        anchors.margins: 1
                        width: 70  // implicitContentWidth
                        border.color: "#444444"
                        color: "transparent"
                        Label {
                            text: {
                                var str = grid.title;
                                str = str.split(" ");
                                return str[1];
                            }
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            font.pixelSize: 14
                        }
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered:  { parent.border.width = 1 }
                            onExited:   { parent.border.width = 0 }
                            onPressed:  { }
                            onReleased: { }
                            onClicked:  {
                                popup_findYear.close()
                                model_year.clear()
                                var thisYear = new Date().getFullYear() //2019
                                for(var i_year = thisYear; i_year > 1900; i_year --) {
                                    model_year.append({ name: i_year })
                                }

                                var str = grid.title;
                                str = str.split(" ");
                                var yearCurrent = thisYear - Number(str[1]);
                                console. log(" (!) yearCurrent = ", yearCurrent)
                                popup_findYear.currentIndex = Number(yearCurrent)
                                popup_findYear.open()
                            }
                        }
                    }

                    Image {
                        //id: name
                        anchors.left: parent.left
                        source: "icons/menu-left.svg"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                grid.year--
                            }
                        }
                    }
                    Image {
                        anchors.right: parent.right
                        source: "icons/menu-right.svg"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                grid.year++
                            }
                        }
                    }


                }

                /// заголовок месяц
                Rectangle {
                    id: rectangle
                    width:grid.width
                    height: 25
                    color: "LightGrey"
                    Label {
                        text: {
                            var str = grid.title;
                            str = str.split(" ");
                            return str[0];
                        }
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.pixelSize: 14
                    }

                    Image {
                        //id: name
                        anchors.left: parent.left
                        source: "icons/menu-left.svg"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (grid.month === Calendar.January) {
                                    grid.year--
                                    grid.month = Calendar.December
                                } else {
                                    grid.month--
                                }
                            }
                        }
                    }
                    Image {
                        anchors.right: parent.right
                        source: "icons/menu-right.svg"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (grid.month === Calendar.December) {
                                    grid.year++
                                    grid.month = Calendar.January
                                } else {
                                    grid.month++
                                }
                            }
                        }
                    }
                }

                DayOfWeekRow {
                    locale: grid.locale
                    Layout.fillWidth: true
                    delegate: Text {
                        text: model.shortName
                        color: "SteelBlue"
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                MonthGrid {
                    id: grid
                    month: (date_val.getMonth()) ? date_val.getMonth() : now.getMonth()  //curmonth     //curdate.getMonth()//Calendar.December
                    year:  (date_val.getFullYear()) ? date_val.getFullYear() : now.getFullYear() //curyear
                    //property int day: date_val.getDate()
                    property var now: new Date()


                    locale: Qt.locale("ru_RU")
                    Layout.fillWidth: true
                    Layout.fillHeight: true


                    delegate: Text {
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter



                        opacity: (model.month === grid.month) ? 1 : 0.5

                        text: model.day
                        //font: control.font
                        font.pixelSize: 12
//                        color: ((model.day === root.date_val.getDay() ) &&
//                               (model.month === root.date_val.getMonth()) &&
//                               (model.year === root.date_val.getFullYear()) ) ? "Blue" : "Black"

                        color: model.today ? "Crimson" : "Black"
                        MouseArea {
                            anchors.fill: parent
                            anchors.margins: -2
                            hoverEnabled: true
                            onEntered:  {
                                var currentDate = new Date(model.year, model.month, model.day)

//                                console.log(" (!)  currentDate = ", grid.currentDate);
                                if (currentDate <=  grid.now)
                                { rect_day.visible = true;  parent.font.pixelSize = 17 }

                            }
                            onExited:   { rect_day.visible = false; parent.font.pixelSize = 12  }
                            onPressed:  {
                                var currentDate = new Date(model.year, model.month, model.day)
                                if (currentDate <=  grid.now) parent.font.bold = true
                            }
                            onReleased: { parent.font.bold = false  }
                            onClicked: {
                                var currentDate = new Date(model.year, model.month, model.day)
                                if (currentDate <=  grid.now)
                                {
                                    date_val = date
                                    //date_buf = date
                                    id_cb.popup.close()
                                    ready = true
                                    txt_day.text   = qsTr(date_val.getDate().toString())
                                    txt_month.text = qsTr((date_val.getMonth()+1).toString())
                                    txt_year.text  = qsTr(date_val.getFullYear().toString())
                                }

                            }
                        }
                        Rectangle {
                            id: rect_day
                            anchors.fill: parent
                            anchors.margins: -5
                            color: "transparent"
                            border.color: "#444444"
                            visible: false
                        }
                    }
//                    onClicked: {
//                        date_val = date
//                        id_cb.popup.close()
//                        ready = true
//                    }
                }
            }
        }
    }

    /// выпадающий список с годами
    Popup {
        id: popup_findYear
        width: 240 //380 //year_.width
        height: 200 //350 //(listview_popup.contentHeight > 200) ? 200 : (listview_popup.contentHeight + popup_findYear.padding*2)

        property alias currentIndex: gridYear.currentIndex


        y: rect_year.y - 40 //80 //+year_.height
        x: rect_year.x + 180  //- 100
        padding: 8

        property var selectYear ///: new Date() //изначально должен определяться текущий год

        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        //closed: ( mycalendar.opened ) ? false : true
        onClosed: {gridYear.moveCurrentIndexDown()}

        ListModel { // года добавляются в модель по нажатию на элемент year_
            id: model_year
            ListElement {
                name: 2019
            }
        }
        Rectangle {
            anchors.top: parent.top //row_selectYears.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            //anchors.leftMargin: 10
            anchors.right: parent.right
            //anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            border.color: "LightGray"
            layer.enabled: true
            GridView {
                id: gridYear
                anchors.fill: parent
                anchors.margins: 10
                cellWidth: 50; cellHeight: 50

                //currentIndex:  10


                model: model_year
                delegate: ItemDelegate {
                    width: 50 // 85
                    height: 50 //85
                    Text {
                        anchors.centerIn: parent
                        text:name
                        font.pixelSize: 15// 20
                    }
                    onClicked: {
                        if (gridYear.currentIndex !== index) {
                            gridYear.currentIndex = index
                        }
                        popup_findYear.close()
                        popup_findYear.selectYear = name

                        grid.year = name;
                    }
                }

                highlight: Rectangle { color: "LightGray"}
                //highlightFollowsCurrentItem: true
                //focus: true
                //highlightMoveDuration: 200

            }
        }
    }





    Image {
        id: img_erase
        sourceSize.height: 21 /// 16
        sourceSize.width: 21 /// 16

        anchors.left: id_cb.right
        anchors.verticalCenter: id_cb.verticalCenter

        ///////////////////////////
        // anchors.right: id_cb.right
        // anchors.bottom: id_cb.top
        ///////////////////////////

        anchors.leftMargin: 8
        source: "icons/eraser-variant.svg"
        opacity: (root.enabled) ?  0.5 : 0.2

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered:  { parent.sourceSize.height = 23; parent.sourceSize.width = 23 }
            onExited:   { parent.sourceSize.height = 21; parent.sourceSize.width = 21 }
            onClicked: {
                ready = false
                date_val = ""
                txt_day.text   = "";
                txt_month.text = "";
                txt_year.text  = "";
                //date_val = "" //new Date();
            }
        }
    }

}
