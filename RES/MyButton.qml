import QtQuick 2.4
import QtMultimedia 5.0

Image {
    id: myButton
    width: 250*myMainScale
    height: 80*myMainScale
    smooth: true
    property string myText: ""
    property string mySourceNormal: "qrc:/image/RES/buttonrect.png"
    property string mySourceHover: "qrc:/image/RES/buttonrecthover.png"
    property string mySourcePress: "qrc:/image/RES/buttonrectpress.png"
    signal buttonClicked()
    source: mySourceNormal
    scale: 0.9
    opacity: 0.9
    Text {
        id: dialogText
        anchors.fill: parent
        text: myText
        color: "white"
        font.family: "微软雅黑"
        font.pixelSize: 24*(myButton.width/250)
        font.bold: true
        horizontalAlignment : Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
    }
    MouseArea{
        id:mouseArea
        anchors.fill: myButton
        hoverEnabled: false
        onPressed: {
            if(pressedButtons!=Qt.LeftButton){
                return
            }
            clickScaleAction.to=1
            clickOpacityAction.to=1
            clickAction.restart()
            myButton.source=mySourcePress
        }
        onReleased: {
            clickScaleAction.to=0.9
            clickOpacityAction.to=0.8
            clickAction.restart()
            myButton.source=mySourceNormal
            if(containsMouse==false){
                return
            }
            clickSound.play()
            buttonClicked()
        }
    }
    ParallelAnimation{
        id:clickAction
        SpringAnimation{
            id:clickScaleAction
            target: myButton
            property: "scale"
            spring: 10
            damping: 1
        }
        SpringAnimation{
            id:clickOpacityAction
            target: myButton
            property: "opacity"
            spring: 10
            damping: 1
        }
    }
    SoundEffect{
        id:hoverSound
        source: "qrc:/sound/RES/hover.wav"
    }
    SoundEffect{
        id:clickSound
        source: "qrc:/sound/RES/click.wav"
    }
}
