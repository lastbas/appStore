// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id:detailPage
    tools:
        ToolBarLayout {
        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.pop();
        }
    }
    Flickable {
        id:detailFlick
        contentHeight: details.height + dtlColumn.height + 69
        flickableDirection: Flickable.VerticalFlick
        anchors { right:parent.right; left:parent.left; top:parent.top; bottom:parent.bottom; topMargin: 5;  rightMargin: 10; leftMargin: 10; }
        Item {
            id:details
            height: 90
            //anchors { right:parent.right; left:parent.left; top:parent.top; topMargin: 5;  rightMargin: 10; leftMargin: 10; }
            Row {
                id:iconName
                anchors { top: parent.top; topMargin: 20; }
                spacing: 19
                Item {
                    id:pic
                    height:90
                    width:50
                    Image {
                        source:picture
                        anchors.verticalCenter: parent.verticalCenter
                        width:50
                        height:50
                    }
                }
            Column {
                Text {
                    text: title
                    color: (invertedTheme) ? "black" : "white"
                    font.pointSize: 7.5;
                }
                Text {
                    text:"By " + dev
                    color:"#737373"
                    font.pointSize: 6; font.bold: true
                }
                Text {
                    text:cat
                    color:"#737373"
                    font.pointSize: 6; font.bold: true
                }
                Text {
                    text:"Version: " + version
                    color:"#737373"
                    font.pointSize: 6; font.bold: true
                }
              }
            }
        }
        Item {
            id:detail2
            anchors {top: details.bottom; topMargin: 25; }
            Column {
                id:dtlColumn
                spacing: 2
                Text {
                    text: dtltext
                    color: (invertedTheme) ? "black" : "white"
                    font.pointSize: 6; font.bold: true
                    wrapMode: Text.Wrap
                    textFormat: Text.RichText;
                    width: 340
                }
                Image {
                    id:sShot
                    source: (screenshot) ? screenshot : ""
                    height:(screenshot) ? 600 : 0
                    width: 340
                    fillMode: Image.PreserveAspectFit
                    BusyIndicator {
                        platformInverted: invertedTheme
                        anchors.centerIn: parent
                        visible:sShot.progress<1.0 && (screenshot)
                        running:sShot.progress<1.0
                        width:60
                        height:60
                    }
                }
            }
        }
    }
}
