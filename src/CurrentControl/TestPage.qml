import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Material 2.3

Page {
//    Label {
//        anchors.centerIn: parent
//        text:"testPage_"
//    }


    Connections {
        target: Query1
        onSignalSendResult: {
            if (owner_name === "insertPhotoTest") {
                 if (res === true) {
                     rect_BD.color = Material.color(Material.Green)
                 }
            }
        }
    }
    Connections {
        target: Query1
        onSignalSendResult: {
            if (owner_name === "pullOutPhotoTest") {
                 console.log(" pullOutPhotoTest: ", res, var_res );
                item_Photo2.emptyPhoto = false;
                //item_Photo2.source = "image://images/photo_person";
            }
        }
    }



    Connections {
        target: Query1
        onSignalSendResult: {
            if (owner_name === "testQueryFile") {
                 console.log(" testQueryFile: ", res, var_res, " type: ", typeof var_res, var_res.length );
                FileManager.sendToCpp(var_res);
                FileManager.safeFile(var_res, "", "img_file", "jpg" )

            }
        }
    }


    Rectangle {
        id: main_1
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top
        anchors.topMargin: 40
        width: 700
        height: 300
        color: "transparent" // "#EEEEEE"
        border.color: "LightGray"


        Rectangle {
            id: photo_frame1
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            width: 135
            height: 155


            border.color: "LightGray"
            radius: 2

            Image {
                id: item_Photo1
                property bool emptyPhoto: true
                fillMode: Image.PreserveAspectFit
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                anchors.topMargin:    (emptyPhoto) ? 18 : 2
                anchors.leftMargin:   (emptyPhoto) ? 0  : 2
                anchors.rightMargin:  (emptyPhoto) ? 0  : 2
                anchors.bottomMargin: (emptyPhoto) ? 0  : 2
                opacity: (emptyPhoto) ? 0.2 : 1
                sourceSize.height: 120
                sourceSize.width:  120
                source: "icons/face.svg" //"file:///C:/Users/test/Desktop/photo_2.jpg"

            }

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: 50

                border.color: "LightGray"
                color: "transparent"
                Rectangle {
                    id: chosePhoto_rect
                    anchors.fill: parent
                    anchors.margins: 1
                    opacity: 0.3
                }

                Label {
                    id: chosePhoto_label
                    anchors.centerIn: parent
                    text: "Выбрать фото"
                    font.pixelSize: 15
                    opacity: 0.5
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered:  { chosePhoto_rect.opacity = 0.8; chosePhoto_label.opacity = 0.9 }
                    onExited:   { chosePhoto_rect.opacity = 0.3; chosePhoto_label.opacity = 0.5 }
                    onPressed:  {  }
                    onReleased: {  }
                    onClicked:  { openFileDialog.open(); }

                }
            }

            FileDialog {
                id: openFileDialog
                title: "Выбирите фото"
                folder: shortcuts.desktop //shortcuts.home
                selectExisting: true
                nameFilters: [ "Image files (*.jpg *.png *.txt *.docm *.docx)", "All files (*)" ]
                onAccepted: {
                    console.log("You chose: " + openFileDialog.fileUrls)
                    var str = openFileDialog.fileUrl;
                    console.log("str: " + str)
                    item_Photo1.emptyPhoto = false;
                    item_Photo1.source = openFileDialog.fileUrl;
                    console.log(item_Photo1.sourceSize.height + " " + item_Photo1.sourceSize.width)
                    //Qt.quit()
                }
                onRejected: {
                    console.log("Canceled")
                    //Qt.quit()
                }
            }


        }


        Button {
            id: button_IN
            anchors.left: photo_frame1.right
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            text: "Отправить в БД ->"

            onClicked: {
                //var querySQL = "insert into eduimage(image) values (:image)"
                var data_arr = {}
                data_arr["FILENAME"] = "черешня.jpg";
                data_arr["IMAGEDATA"] = item_Photo1.source;
                data_arr["DESCRIPTION"] = "Тест загрузки фото";

//                data_arr["IMAGEDATA3"] = item_Photo1.source;
//                data_arr["IMAGEDATA2"] = item_Photo1.source;
//                data_arr["IMAGEDATA4"] = item_Photo1.source;

                Query1.insertRecordIntoTable("insertPhotoTest","FILESTABLE_TEST", data_arr)
                //item_Photo2.source = "image://images/green"
                rect_BD.color = "transparent"

            }

        }

        Rectangle {
            id: rect_BD
            anchors.left: button_IN.right
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            width: 50
            height: 50
            color: "transparent" // "#EEEEEE"
            border.color: "LightGray"


        }

        Button {
            id: button_FROM
            anchors.left: rect_BD.right
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            text: "Выгрузить из БД ->"

            onClicked: {
                rect_BD.color = "transparent"
                Query1.setQueryAndName(" SELECT IMAGEDATA from FILESTABLE_TEST where ID = 93", "pullOutPhotoTest");
                //item_Photo2.source = "image://images/red"
            }
        }


        Rectangle {
            id: photo_frame2
            anchors.left: button_FROM.right
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            width: 135
            height: 155


            border.color: "LightGray"
            radius: 2

            Image {
                id: item_Photo2
                property bool emptyPhoto: true
                fillMode: Image.PreserveAspectFit
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                anchors.topMargin:    (emptyPhoto) ? 18 : 2
                anchors.leftMargin:   (emptyPhoto) ? 0  : 2
                anchors.rightMargin:  (emptyPhoto) ? 0  : 2
                anchors.bottomMargin: (emptyPhoto) ? 0  : 2
                opacity: (emptyPhoto) ? 0.2 : 1
                sourceSize.height: 120
                sourceSize.width:  120
                //source: "image://images/yellow"  // "image://images/photo_person"  //"icons/face.svg"

            }

        }


    }


//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////



    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: main_1.bottom
        anchors.topMargin: 20
        width: 700
        height: 300
        color: "transparent" // "#EEEEEE"
        border.color: "LightGray"

        Rectangle {
            anchors.left: parent.left
            anchors.top:parent.top
            anchors.bottom: parent.bottom
            anchors.margins: 20
            width: 400
            color: "transparent"
            border.color: "LightGray"
            Column {
                anchors.fill:parent
                spacing: 20

                Row {
                    anchors.left: parent.left
                    spacing: 10

                    Button {
                        text: "Load File"
                        onClicked: {
                            openFileDialog2.open();
                        }
                    }

                    TextEdit {
                        id: txt_fileName
                        anchors.verticalCenter: parent.verticalCenter
                        selectionColor: Material.color(Material.Red)
                        selectByMouse: true
                    }
                }


                Row {
                    anchors.left: parent.left
                    spacing: 10

                    Button {
                        text: "out DB"
                        onClicked: {
                            var query = " SELECT PHOTO from EXT_PERSON where ID_PERSON = 39 "
                            //Query1.setQueryAndName(query, "testQueryFile")
                            //FileManager.test = " макрос Q_PROPERTY работает! или нет, сейчас увидим ";
                            FileManager.pathFile = openFileDialog2.fileUrl;
                            var fileBA = FileManager.qByteArray_file;
                            console.log(" typeof (fileBA): ", typeof (FileManager.qByteArray_file)," ", FileManager.qByteArray_file);


                            var data_arr = {}
                            data_arr["FILE_"] = FileManager.qByteArray_file;
                            data_arr["DESCRIPTION"] = (txt_fileNameInDB.text.length > 0) ? txt_fileNameInDB.text : txt_fileName.text;

                            Query1.insertRecordIntoTable("insertFileTest","FILES_TEST", data_arr);
                        }
                    }
                    TextField {
                        id: txt_fileNameInDB
                        anchors.verticalCenter: parent.verticalCenter
                        selectByMouse: true
                        //text: qsTr(FileManager.test) //qsTr(FileManager.qByteArray_file)
                    }
                }


            }
        }


        Pane {
            id: test_elevation
            property double elevation_: 1.0
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 10
            width: 120
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
                onEntered:  { test_elevation.animationStart(1.0, 6.0,"elevation_" ) }
                onExited:   { test_elevation.animationStart(6.0, 1.0,"elevation_" ) }
                onPressed:  {  }
                onReleased: {  }
                onClicked:  {
                    console.log(" (!) CLICK! ")
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
                target: test_elevation
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
                text: qsTr("I'm a card!")
                anchors.centerIn: parent
            }
        }



        FileDialog {
            id: openFileDialog2
            //property var fileUrl
            title: "Выбирите фото"
            folder: shortcuts.desktop //shortcuts.home
            selectExisting: true
            nameFilters: [ "Image files (*.jpg *.png)", "Report files (*.txt *.docm *.docx *.bat)", "All files (*)" ]
            onAccepted: {
                console.log("You chose: " + openFileDialog2.fileUrls)
                var str = openFileDialog2.fileUrl;
                console.log("str: " + str)
                txt_fileName.text = fileUrl.toString().replace('file:///','')
            }
            onRejected: {
                console.log("Canceled")
                //Qt.quit()
            }
        }







    }



}

