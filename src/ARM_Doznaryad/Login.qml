import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

Item {
    id: login_item

    signal login_OK

    property bool flg_active_state: true

    Connections {
        target: managerDB
        onSignalBlockingGUI:{
            if (login_item.flg_active_state === true) {
                btn_login.enabled = false
                busy_control.running = true
                uname_field.enabled = false
                pass_field.enabled = false
                err_label.text = "подключение к базе данных.."
            } else {
                //popup_wait.open()
            }

            //console.log("signal LOCK")
        }

        onSignalUnlockingGUI: {
            if (login_item.flg_active_state === true) {
                btn_login.enabled = true
                busy_control.running = false
                uname_field.enabled = true
                pass_field.enabled = true
            } else {
                //popup_wait.close()
            }
            //console.log("signal UNLOCK: " + res)
        }

        onSignalSendGUI_status: {
            if (login_item.flg_active_state) {

//                console.log("~~~~~~~~~~~~~~~~~~ SignalSendGUI_status ~~~~~~~~~~~~~~~~~")
//                console.log(status)
//                console.log(message)
//                console.log(currentConnectionName)
//                console.log("^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^")

                if ((status) && (currentConnectionName !== "0")) {
                    err_label.text = ""
                    flg_active_state = false
                    login_item.login_OK()

                    dozModel.query =
                           "SELECT t1.ID, t1.doz_number, d1.department, t1.doz_get_date,
                            t1.open_date, t1.close_date, t1.doz_status, t1.doz_directive,
                            s1.state_name, s1.state_color, t1.ID_DEPARTMENT,
                            t1.ID_RESPONSIBLE, t1.ID_OPEN_WORKER, t1.ID_CLOSE_WORKER,
                            t1.ID_LEADER, t1.ID_PRODUCER, t1.ID_AGREED,
                            (w1.W_SURNAME || ' ' || SUBSTR(w1.W_NAME,1,1) || '.' || SUBSTR(w1.W_PATRONYMIC,1,1) || '.') responsible,
                            (w2.W_SURNAME || ' ' || SUBSTR(w2.W_NAME,1,1) || '.' || SUBSTR(w2.W_PATRONYMIC,1,1) || '.') leader,
                            (w3.W_SURNAME || ' ' || SUBSTR(w3.W_NAME,1,1) || '.' || SUBSTR(w3.W_PATRONYMIC,1,1) || '.') producer,
                            (w4.W_SURNAME || ' ' || SUBSTR(w4.W_NAME,1,1) || '.' || SUBSTR(w4.W_PATRONYMIC,1,1) || '.') open_worker,
                            (w5.W_SURNAME || ' ' || SUBSTR(w5.W_NAME,1,1) || '.' || SUBSTR(w5.W_PATRONYMIC,1,1) || '.') close_worker,
                            (w6.W_SURNAME || ' ' || SUBSTR(w6.W_NAME,1,1) || '.' || SUBSTR(w6.W_PATRONYMIC,1,1) || '.') agreed,
                            t1.permitted_dose, t1.permitted_time, t1.sum_dose, t1.over_dose, t1.collective_dose,
                            t1.start_of_work, t1.end_of_work, t1.special_comment,
                            (
                                SELECT LISTAGG(x1.option_name, ', ') WITHIN GROUP (ORDER BY x1.option_name)
                                FROM table_specials x1 INNER JOIN table_doznaryad_specials_con x2 ON x1.ID = x2.id_specials
                                WHERE (x2.id_doznaryad = t1.ID) and (x1.id_type=2)
                            ) as RB_OPTION_LIST,
                            (
                                SELECT LISTAGG(y1.option_name, ', ') WITHIN GROUP (ORDER BY y1.option_name) as SIZ_OPTION_LIST
                                FROM table_specials y1 INNER JOIN table_doznaryad_specials_con y2 ON y1.ID = y2.id_specials
                                WHERE (y2.id_doznaryad = t1.ID) and (y1.id_type=1)
                            ) as SIZ_OPTION_LIST
                            FROM ((((((((table_doznaryad t1
                            LEFT JOIN table_departments  d1
                            ON t1.id_department = d1.ID )
                            LEFT JOIN EXT_PERSON w1
                            ON t1.id_responsible = w1.ID_PERSON)
                            LEFT JOIN EXT_PERSON w2
                            ON t1.id_leader = w2.ID_PERSON)
                            LEFT JOIN EXT_PERSON w3
                            ON t1.id_producer = w3.ID_PERSON)
                            LEFT JOIN EXT_PERSON w4
                            ON t1.id_open_worker = w4.ID_PERSON)
                            LEFT JOIN EXT_PERSON w5
                            ON t1.id_close_worker = w5.ID_PERSON)
                            LEFT JOIN EXT_PERSON w6
                            ON t1.id_agreed = w6.ID_PERSON)
                            LEFT JOIN table_states s1
                            ON t1.doz_status = s1.ID)
                            ORDER BY t1.ID"
                } else {
                    err_label.text = message //"Ошибка: невозможно авторизоваться"
                }
            }
        }
    }

    Column {
        id: column
        spacing: 30
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Grid {
            id: grid
            spacing: 10
            rows: 2
            columns: 2

            Label {
                text: qsTr("Пользователь")
                rightPadding: 20
                bottomPadding: 16
                topPadding: 8
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 16
            }

            TextField {
                id: uname_field
                width: 300
                bottomPadding: 16
                topPadding: 8
                leftPadding: 8
                text: "DOZNARYAD"//"DOSE1"//"C##CDBUSER1"
                placeholderText: qsTr("введите имя пользователя")
                verticalAlignment: Text.AlignVCenter
                clip: false
                font.pointSize: 16
                selectByMouse: true
            }

            Label {
                text: qsTr("Пароль")
                rightPadding: 20
                bottomPadding: 16
                topPadding: 8
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 16
            }

            TextField {
                id: pass_field
                width: 300
                bottomPadding: 16
                topPadding: 8
                leftPadding: 8
                text: "alpha1"
                placeholderText: qsTr("введите пароль")
                verticalAlignment: Text.AlignVCenter
                clip: false
                font.pointSize: 16
                selectByMouse: true
                echoMode: TextInput.Password
                passwordCharacter: "\u25cf"
            }

        }


        Button {
            id: btn_login
            text: "Вход"
            width: 150
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 16
            onClicked: {
                flg_active_state = true
                managerDB.setLoginPwd(uname_field.text, pass_field.text)
                managerDB.checkAllConnectionDB()
            }
        }

        Pane {
            id: pane
            height: 70
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: err_label
                text: ""
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                font.pixelSize: 16
                //font.bold: true
                color: busy_control.running ? "dimgray":"indianred"
            }

            BusyIndicator {
                id: busy_control
                running: false
                anchors.left: err_label.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10

                contentItem: Item {
                          implicitWidth: 40//64
                          implicitHeight: 40//64

                          Item {
                              id: bcitem
                              x: parent.width / 2 - 20//32
                              y: parent.height / 2 - 20//32
                              width: 40//64
                              height: 40//64
                              opacity: busy_control.running ? 1 : 0

                              Behavior on opacity {
                                  OpacityAnimator {
                                      duration: 250
                                  }
                              }

                              RotationAnimator {
                                  target: bcitem
                                  running: busy_control.visible && busy_control.running
                                  from: 0
                                  to: 360
                                  loops: Animation.Infinite
                                  duration: 2500//1250
                              }

                              Repeater {
                                  id: bcrepeater
                                  model: 6

                                  Rectangle {
                                      x: bcitem.width / 2 - width / 2
                                      y: bcitem.height / 2 - height / 2
                                      implicitWidth: 8
                                      implicitHeight: 8
                                      radius: 4
                                      color: "dimgray"//"#21be2b"
                                      transform: [
                                          Translate {
                                              y: -Math.min(bcitem.width, bcitem.height) * 0.5 + 5
                                          },
                                          Rotation {
                                              angle: index / bcrepeater.count * 360
                                              origin.x: 4
                                              origin.y: 4
                                          }
                                      ]
                                  }
                              }
                          }
                      }
            }
        }
    }
}



/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
