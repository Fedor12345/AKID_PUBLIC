import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    id: element
    width: 200
    height: 30

    property alias ffwidth: element.width
    property alias ffheight: element.height
    property alias ffbackground: find_workers_control.background
    property int font_pixel: 16
    property alias findtext: find_workers_control.text

    property string phtext: ""
    property int id_rec: -1
    property bool flg_f: false //нужно ли искать

    property string add_filter: ""

    function setIdRec(id_val, fio_val) {
        if (id_val === -1) {
            findtext = ""
            id_rec = id_val
        } else {
            var ftmp = flg_f
            flg_f = false

            id_rec = id_val
            findtext = fio_val

            flg_f = ftmp
        }
    }

    Connections {
        target: popup_listview.model
        onQueryStrChanged: {
            if (element.flg_f) {
                if (popup_listview.count > 0) {
                    if (!find_popup.opened) {
                        find_popup.open()
                    }
                }
            }
        }
    }

    TextField {
            id: find_workers_control

            width: element.width
            anchors.verticalCenter: parent.verticalCenter

            bottomPadding: 0
            topPadding: 0
            leftPadding: 8
            rightPadding: 8

            font.pixelSize: font_pixel
            placeholderText: phtext//qsTr("find")

            selectByMouse: true
            color: ((flg_f) && (id_rec !== -1)) ? "black" : "brown"//"cornflowerblue"

            property bool havechoice: false

//            background: Rectangle {
//                id: flashingblob

//                anchors.fill: parent
//                radius: 5
//                color: "White"//find_workers_control.activeFocus ? "White": "transparent"
//                border.color: "DarkGray" //Material.color(Material.Grey, Material.Shade800)//
//            }

            onTextChanged: {
                if (element.flg_f) {
                    id_rec = -1 // ??
                    mytimer.restart()
                    //console.log("text changed")
                }
            }
        }

    //событие по таймеру срабатывает, когда пауза на нажатие кнопки больше 500мс
    //при условии, что в строке поиска что-то есть
    Timer {
        id: mytimer
        interval: 500
        repeat: false
        onTriggered: {
            if (find_workers_control.text.length > 0) {

                var sf = ""
                if (add_filter.length > 0) {
                    sf = " and ("+ add_filter +") "
                }

                if(isNaN(findtext)) {
                    popup_listview.model.query = " SELECT (W_SURNAME || ' ' || SUBSTR(W_NAME, 1, 1) || '. ' || SUBSTR(W_PATRONYMIC, 1, 1) || '.') FNAME,
                                  ID_TLD tld, ID_PERSON
                                  FROM EXT_PERSON
                                  WHERE (LOWER(W_SURNAME || ' ' || W_NAME) LIKE '"+ findtext.toLowerCase() +"%') " + sf +
                                 "ORDER BY W_SURNAME "
                } else {
                    popup_listview.model.query = " SELECT (W_SURNAME || ' ' || SUBSTR(W_NAME, 1, 1)  || '. ' || SUBSTR(W_PATRONYMIC, 1, 1) || '.') FNAME,
                                  ID_TLD tld, ID_PERSON
                                  FROM EXT_PERSON
                                  WHERE (ID_TLD LIKE '" + findtext + "%') " + sf +
                                 "ORDER BY ID_TLD "
                }
            } else {
                find_popup.close()
                id_rec = -1
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
            model: managerDB.createModel("")

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
                    mytimer.stop()
                    find_popup.close()

                    setIdRec(ID_PERSON, FNAME)
                }

                Row {
                    id: row
                    height: parent.height
                    leftPadding: 5
                    spacing: 5
                    Label {
                        text: FNAME//find_sql_model.get(rowIdx)[hmodel.get(0).trole]
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




