import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

Item {
    id: login_item

    signal login_OK

    property bool flg_active_state: true

    Component.onCompleted: console.log("Login           completed")

    function authorization() {
        infoText_text.text = "начата авторизация"
        //managerDB.setLoginPwd(uname_field.text, pass_field.text)
        if (uname_field.text == "user" && pass_field.text == "alpha1"){
            flg_active_state = true;
            infoText_text.text = "проверка соединения..."
            managerDB.checkAllConnectionDB();
        }

        //                if (database.connectToDataBase() === true) {
        //                    //myModel.updateModel()
        //                    login_item.login_OK()
        //                } else {
        //                    err_label.text = "Ошибка: невозможно авторизоваться"
        //                }

        //                uname_field.enabled = true
        //                pass_field.enabled = true
        //                busy_control.running = false
        //                enabled = true

        //login_item.login_OK()
    }


    focus: true
    Keys.onReleased: {
        if ( event.key == Qt.Key_Return ) {
            authorization();
        }
    }





    Text {
        id: infoText_text
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -300
        font.pixelSize: 20
        opacity: 0.7
        text: qsTr("Информация")
    }

//    Popup {
//        id: popup_wait
//        modal: true
//        //focus: true
//        closePolicy: Popup.NoAutoClose
//        parent: Overlay.overlay
//        x: Math.round((parent.width - width) / 2)
//        y: Math.round((parent.height - height) / 2)
//        padding: 0

//        Overlay.modal: Rectangle {
//            color: "transparent"
//        }
//        background:
//            Rectangle {
//            anchors.fill: parent
//            color: "Transparent"//"White" Material.color(Material.Grey, Material.Shade200)
//        }
//        MyBusyIndicator {
//            biwidth: 40
//            biheight: 40
//            biradius: 4
//            running: true
//        }
//    }

    Connections {
        target: managerDB
        onSignalBlockingGUI:{
        //onSignalSendGUI_status:{
            if (login_item.flg_active_state === true) {
                btn_login.enabled = false
                busy_control.running = true
                uname_field.enabled = false
                pass_field.enabled = false
                err_label.text = "подключение к базе данных.."
                //listModel_message.append( { message: "подключение к базе данных.." } )
                //infoText_tumbler.currentIndex++;
            }
//            else {
//                popup_wait.open()
//            }

            //console.log("signal LOCK")
        }

        onSignalUnlockingGUI: {
        //onSignalSendGUI_status:{
            if (login_item.flg_active_state === true) {
                btn_login.enabled = true
                busy_control.running = false
                uname_field.enabled = true
                pass_field.enabled = true

                //if (res === true) {
//                    err_label.text = ""
//                    flg_active_state = false
//                    login_item.login_OK()
                //} else {
                //    err_label.text = "Ошибка: невозможно авторизоваться"
                //}
            }
//            else {
//                popup_wait.close()
//            }
            //console.log("signal UNLOCK: " + res)
        }
        onSignalSendGUI_status: {
            infoText_text.text = "SignalSendGUI_status 1..."
            if (login_item.flg_active_state === true) {
                if(!status) {
                    infoText_text.text = " SignalSendGUI_status 2 " + message
                    err_label.text = message; //"Ошибка: невозможно авторизоваться"
                    //listModel_message.append({ message: message });
                    //infoText_tumbler.currentIndex++;
                }
                else {
                    infoText_text.text = " SignalSendGUI_status 3  OK!"
                    err_label.text = ""
                    //listModel_message.append( { message: ""} );
                    //infoText_tumbler.currentIndex++;
                    flg_active_state = false
                    login_item.login_OK()
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
                text: "user" // "ARM_AKID_TEST_1" //"user_replicat_0"  //"ARM_AKID_TEST_1"
                     //"ARM_AKID_TEST_1" //"ARM_AKID_1"
                    //"ARM_AKID_C"
                    //"ARM_AKID_A" //"ARM_AKID_J" // "ARM_AKID_I" // "ARM_CONTROL" //"DOZ1" //C##CDBUSER1
                placeholderText: qsTr("введите имя пользователя")
                verticalAlignment: Text.AlignVCenter
                clip: false
                font.pointSize: 16
                selectByMouse: true

                Keys.onReleased: {
                    if ( event.key == Qt.Key_Return ) {
                        authorization();
                    }
                }
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

                Keys.onReleased: {
                    if ( event.key == Qt.Key_Return ) {
                        authorization();
                    }
                }
            }

        }

//        Connections {
//            target: dbwrapper
//            onSignal_qml_conn: {
//                if (msg === "Login") {
//                    btn_login.enabled = true
//                    busy_control.running = false
//                    uname_field.enabled = true
//                    pass_field.enabled = true

//                    if (conn_state === true) {
//                        err_label.text = ""
//                        login_item.login_OK()
//                    } else {
//                        err_label.text = "Ошибка: невозможно авторизоваться"
//                    }
//                }
//            }
//        }


        Button {
            id: btn_login
            text: "Вход"
            width: 150
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 16
            onClicked: {
                authorization();

            }
        }

        Pane {
            id: pane
            height: 70
            anchors.horizontalCenter: parent.horizontalCenter

//            background: Rectangle {
//                anchors.fill: parent
//                color: "green"
//            }


//            Tumbler {
//                id: infoText_tumbler
//                //visible: false
//                width: 400
//                height: 70
//                anchors.verticalCenter: parent.verticalCenter
//                anchors.horizontalCenter: parent.horizontalCenter
//                visibleItemCount: 4
//                model: ListModel { id: listModel_message
//                    ListElement { message: "" }
//                }
//                delegate: ItemDelegate {
//                    height: 20
//                    Text {
//                        anchors.centerIn: parent
//                        text: message //modelData
//                        //horizontalAlignment: Text.AlignHCenter
//                        //verticalAlignment: Text.AlignVCenter
//                        font.pixelSize: 16
//                        color: busy_control.running ? "dimgray":"indianred"
//                    }
//                }
//            }
//            FontMetrics {
//                id: fontMetrics
//                font.family: "Arial"
//            }


            Text {
                id: err_label
               // visible: false
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
//                //anchors.horizontalCenter: parent.horizontalCenter
                anchors.leftMargin: 10
//                width: 40
//                height: 40

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
