import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    id:myWindow
    x:0
    y:0
    width: Screen.width
    height: Screen.height
    flags: Qt.Window
    color: "black"
    Behavior on x{
        id:xBehavior
        enabled: false
        PropertyAnimation{
            duration: 300
            easing.type: Easing.OutCubic
        }
    }
    Behavior on y{
        id:yBehavior
        enabled: false
        PropertyAnimation{
            duration: 300
            easing.type: Easing.OutCubic
        }
    }
    function checkBorder(){
        xBehavior.enabled=true
        yBehavior.enabled=true
        if(x<0){
            x=0
        }
        if(x>Screen.width-width){
            x=Screen.width-width
        }
        if(y<0){
            y=0
        }
        if(y>Screen.height-height){
            y=Screen.height-height
        }
        xBehavior.enabled=false
        yBehavior.enabled=false
    }
}
