import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

import QtGraphicalEffects 1.0

import QtQuick.Controls.Material 2.0
//import "ColorSettings.js" as ColorSettings

Rectangle {
    id: lightIndicator
    property bool style: true

    property string colorOFF:            "#9E9E9E"
    property string colorTRUE:   style ? "#4CAF50" : "#00BCD4"
    property string colorFALSE:          "#F44336"
    property string shadowOFF:           "transparent"
    property string shadowTRUE:  style ? "#4CAF50" : "#00BCD4" //"#607D8B" //"#FF9800"
    property string shadowFALSE:         "#F44336"
    property int durationAnim: 20

    property string shadowTemp: "transparent"
    property real shadowRadius: 0.0 //16.0
    height: 30; width: 30
    radius: 100

    color: colorOFF
    //border {width: 1; color: "#9C27B0"}

    layer.enabled: true
    layer.effect: DropShadow {
        id: liShadow
        radius: shadowRadius
        transparentBorder: true
        samples: 17
        color: lightIndicator.shadowTemp //"lightslategray" //"#80000000" //"lightgray"
        //source: button1
        //ColorAnimation on color { to: "yellow"; duration: 500 }
    }


    SequentialAnimation {
        id: animationTRUE
        PropertyAnimation {
            target: lightIndicator
            property: "color"
            to: lightIndicator.colorTRUE
            duration: lightIndicator.durationAnim
        }
        PropertyAnimation {
            target: lightIndicator
            property: "shadowRadius"
            to: 16.0
            duration: lightIndicator.durationAnim
        }
    }
    SequentialAnimation {
        id: animationFALSE
        PropertyAnimation {
            target: lightIndicator
            property: "color"
            to: lightIndicator.colorFALSE
            duration: lightIndicator.durationAnim
        }
        PropertyAnimation {
            target: lightIndicator
            property: "shadowRadius"
            to: 16.0
            duration: lightIndicator.durationAnim
        }
    }
    SequentialAnimation {
        id: animationOFF
        PropertyAnimation {
            target: lightIndicator
            property: "color"
            to: lightIndicator.colorOFF
            duration: lightIndicator.durationAnim
        }
        PropertyAnimation {
            target: lightIndicator
            property: "shadowRadius"
            to: 0.0
            duration: lightIndicator.durationAnim
        }

    }



    function lightTrue() {
        //lightIndicator.color = lightIndicator.colorTRUE;
        lightIndicator.shadowTemp = lightIndicator.shadowTRUE
        animationTRUE.running = true;
        //animationShTRUE.running = true;
    }

    function lightFalse() {
        //lightIndicator.color = lightIndicator.colorFALSE;
        lightIndicator.shadowTemp = lightIndicator.shadowFALSE
        animationFALSE.running = true;
    }

    function lightOff() {
        lightIndicator.color = lightIndicator.colorOFF;
        lightIndicator.shadowTemp = lightIndicator.shadowOFF
        //lightIndicator.shadowRadius = 0.0
        animationOFF.running = true;
    }


}
