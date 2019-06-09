import QtQuick 2.4

Image {
   id:myContent
   anchors.fill: parent
   smooth: true
   source: "qrc:/image/RES/myrect.png"
   MouseArea{
       id:mouseArea
       enabled: false
       anchors.fill: myContent
       property bool myDrag: false
       property int myPressX: 0
       property int myPressY: 0
       onPressed: {
           if(pressedButtons!=Qt.LeftButton){
               return
           }
           cursorShape=Qt.SizeAllCursor
           myPressX=mouseX
           myPressY=mouseY
           myDrag=true
       }
       onReleased: {
           cursorShape=Qt.ArrowCursor
           myPressX=0
           myPressY=0
           myDrag=false
           myWindow.checkBorder()
       }
       onPositionChanged: {
           if(myDrag==false){
               return
           }
           myWindow.x+=mouseX-myPressX
           myWindow.y+=mouseY-myPressY
       }
   }
}
