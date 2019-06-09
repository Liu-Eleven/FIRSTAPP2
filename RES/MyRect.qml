import QtQuick 2.4
import QtMultimedia 5.0

Flipable {
    id: myRect
    x:0
    y:0
    width: myWindow.width
    height: myWindow.height
    enabled:false
    smooth: true
    property bool myOpen: false
    property string myCurrentPath: ""
    property string mySourceStart: "qrc:/image/RES/start.png"
    property string mySourceEnd: "qrc:/image/RES/end.png"
    property string mySourceWait: "qrc:/image/RES/wait.png"
    function setStart(){
        myWindow.showFullScreen()
        myWindow.requestActivate()
        myWindow.raise()
        startTimer.restart()
    }
    function setEnd(){
        musicPlayer.stop()
        backContent.source=myRect.mySourceEnd
        //
        myRect.myOpen=false
        endTimer.restart()
    }
    function startMyProcess(path){
        myCurrentPath=path
        backContent.source=myRect.mySourceWait
        //
        myRect.myOpen=false
        waitTimer.restart()
    }
    function endMyProcess(){
        myWindow.requestActivate()
        myWindow.raise()
        myRect.myOpen=true
    }
    function closeAllItemRect(){
        myRectTitle1.closeRect()
        myRectTitle2.closeRect()
        myRectTitle3.closeRect()
        myRectTitle4.closeRect()
        myRectTitle5.closeRect()
        myRectTitle6.closeRect()
    }
    onMyOpenChanged:{
        rotationSound.play()
        if(myRect.myOpen==true){
            rotation.angle=180
        }else{
            rotation.angle=0
        }
    }
    front: Image{
        id:backContent
        anchors.fill: parent
        smooth: true
        source: myRect.mySourceStart
    }
    transform:Rotation{
        id:rotation
        origin.x: myRect.width/2
        origin.y: myRect.height/2
        axis.x: 0
        axis.y: 1
        axis.z: 0
        angle: 0
        Behavior on angle {
            PropertyAnimation{
                duration: 800
                easing.type: Easing.OutBack
            }
        }
        onAngleChanged: {
            if(rotation.angle==180){
                myRect.enabled=true
            }else{
                myRect.enabled=false
            }
        }
    }
    Timer{
        id:startTimer
        interval: 1000
        onTriggered: {
            myRect.myOpen=true
            musicPlayer.play()
            myRectTitle1.setShowAnimation()
            myRectTitle2.setShowAnimation()
            myRectTitle3.setShowAnimation()
            myRectTitle4.setShowAnimation()
            myRectTitle5.setShowAnimation()
            myRectTitle6.setShowAnimation()
        }
    }
    Timer{
        id:endTimer
        interval: 1000
        onTriggered: {
            myWindow.close()
        }
    }
    Timer{
        id:waitTimer
        interval: 1000
        onTriggered: {
            //myCommon.setMyProcess(myCurrentPath)
            endMyProcess()
        }
    }
    SoundEffect{
        id:rotationSound
        source: "qrc:/sound/RES/rotation.wav"
    }
    MediaPlayer{
        id:musicPlayer
        property string myMusic: "qrc:/sound/RES/backgroundmusic.mp3"
        source: myMusic
    }
}
