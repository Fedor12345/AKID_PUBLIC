import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
//import Foo 1.0

Item {
    id: element
    width: 200
    height: 30

    property alias ffwidth: element.width
    property alias ffheight: element.height
    property alias ffbackground: find_workers_control.background

    property int font_pixel: 16

    property alias findtext: find_workers_control.text
    //property alias sql_query: popup_listview.model.query //find_sql_model.query


    property string phtext: "Поиск.."
    property int id_rec: -1
    property int find_width: 200
    property bool flg_f: false //нужно ли искать


//    function setIdRec(id_val) {

//        if (id_val === -1) {
//            findtext = ""
//            id_rec = id_val
//        } else {
//            var ftmp = flg_f
//            flg_f = false

//            //popup_listview.model = null //???

//            popup_listview.model.query = "SELECT (w_surname || ' ' || SUBSTR(w_name,1,1) || '.' || SUBSTR(w_patronymic, 1, 1)  || '.') FIO
//                                          FROM table_workers
//                                          WHERE ID = "+id_val.toString()

//            if (popup_listview.model.rowCount() > 0) {
//                findtext = popup_listview.model.get(0)["FIO"]
//                id_rec = id_val
//            }

//            popup_listview.model.query = ""
//            //popup_listview.model = find_sql_model //???
//            flg_f = ftmp
//        }
//    }

    TextField {
            id: find_workers_control

            width: element.width
            height: element.height
            anchors.verticalCenter: parent.verticalCenter

            bottomPadding: 0
            topPadding: 0
            leftPadding: 8
            rightPadding: 8

            font.pixelSize: font_pixel
            placeholderText: phtext//qsTr("find")

            selectByMouse: true

            property bool havechoice: false

//            background: Rectangle {
//                id: flashingblob

//                anchors.fill: parent
//                radius: 5
//                color: "White"//find_workers_control.activeFocus ? "White": "transparent"
//                border.color: "DarkGray" //Material.color(Material.Grey, Material.Shade800)//
//            }

            onTextChanged: {
                if (flg_f)
                    mytimer.restart()
            }


        }


    //fname - Фамилия И.О.
    //tld - № ТЛД
//    SqlQueryModel {
//        id: find_sql_model
//        onQueryStrChanged: {
//            if (flg_f) {
//                if (popup_listview.count > 0) {
//                    if (!find_popup.opened) {
//                        find_popup.open()
//                    }
//                }
//            }
//        }
//    }

    //событие по таймеру срабатывает, когда пауза на нажатие кнопки больше 500мс
    //при условии, что в строке поиска есть что-то
    Timer {
        id: mytimer
        interval: 500
        repeat: false
        onTriggered: {
            if (find_workers_control.text.length > 0) {
                //root_find.readyforfind()
                //console.log("->>>",findtext, isNaN(findtext));
                if(isNaN(findtext)) {
                    popup_listview.model.query = " SELECT W_NAME NAME, W_SURNAME SURNAME, W_PATRONYMIC PATRONYMIC,
                                  ID_TLD TLD, id_person PN, id_person ID

                                  FROM EXT_PERSON

                                  WHERE (LOWER(W_SURNAME) LIKE '"+ findtext.toLowerCase() +"%')
                                  ORDER BY w_surname "

                    //tek_person
                    //ext_person

//                    popup_listview.model.query = " SELECT (w_surname || ' ' || SUBSTR(w_name, 1, 1) || '. ' || SUBSTR(w_patronymic, 1, 1) || '.') fname,
//                                  tld_number tld, PERSON_NUMBER PN, ID
//                                  FROM table_workers
//                                  WHERE (LOWER(w_surname) LIKE '"+ findtext.toLowerCase() +"%')
//                                  ORDER BY w_surname "


                } else {
                    popup_listview.model.query = " SELECT (w_surname || ' ' || SUBSTR(w_name, 1, 1)) FNAME, id_tld TLD
                                                   FROM workers
                                                   WHERE id_person=1 "



//                    popup_listview.model.query = " SELECT (w_surname || ' ' || SUBSTR(w_name, 1, 1)  || '. ' || SUBSTR(w_patronymic, 1, 1) || '.') fname,
//                                  tld_number tld, PERSON_NUMBER PN, ID
//                                  FROM table_workers
//                                  WHERE (tld_number LIKE '" + findtext + "%')
//                                  ORDER BY w_surname "


//                    SELECT (w_surname || ' ' || SUBSTR(w_name, 1, 1)  || '. ' || SUBSTR(w_patronymic, 1, 1) || '.') fname,
//                    tld_number tld, PERSON_NUMBER PN,ID
//                    FROM table_workers
//                    WHERE (tld_number LIKE '1%') OR (PERSON_NUMBER LIKE '1%')
//                    ORDER BY w_surname
                }


            } else {
                find_popup.close()
                id_rec = -1
            }
        }
    }

    Connections {
        target: popup_listview.model
        onSignalUpdateDone: {
            if (flg_f) {
                if (popup_listview.count > 0) {
                    if (!find_popup.opened) {
                        find_popup.open()
                    }
                }
            }
        }
    }

    Popup {
        id: find_popup
        width: find_workers_control.width
        height: (popup_listview.contentHeight > 200) ? 200 : (popup_listview.contentHeight + find_popup.padding*2)

        y: find_workers_control.y+find_workers_control.height
        x: find_workers_control.x
        padding: 8

        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        ListView {
            id: popup_listview
            anchors.fill: parent
            highlightFollowsCurrentItem: true
            model: managerDB.createModel("", "model_SearchPerson")

            ScrollBar.vertical: ScrollBar {
                policy: "AlwaysOn"
            }

            clip: true

            delegate: ItemDelegate {
                spacing: 3
                height: 25
                width: parent.width

                property int rowIdx: index

                onClicked: {
                    findtext = SURNAME + " " + NAME.charAt(0) + "." + PATRONYMIC.charAt(0)+ "." //FNAME// + " ("+tld+")"
//                    placeholdertext = fname + " ("+tld+")"
                    id_rec = ID
//                    console.log("id_rec = ", id_rec, "ID = ", ID)
                    find_workers_control.havechoice = true

                    mytimer.stop()
                    find_popup.close()
                }

                Row {
                    id: row
                    height: parent.height
                    leftPadding: 5
                    spacing: 5
                    Label {
                        text: SURNAME + " " + NAME.charAt(0) + "." + PATRONYMIC.charAt(0)+ "." //FNAME//find_sql_model.get(rowIdx)[hmodel.get(0).trole]
                        anchors.verticalCenter: parent.verticalCenter
                        width: 150
                        font.pixelSize: 14
                    }
                    Label {
                        text: TLD//find_sql_model.get(rowIdx)[hmodel.get(1).trole]
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 14
                    }
//                    Label {
//                        text: PN//find_sql_model.get(rowIdx)[hmodel.get(1).trole]
//                        anchors.verticalCenter: parent.verticalCenter
//                        font.pixelSize: 14
//                    }
                }
            }
        }
    }
}




