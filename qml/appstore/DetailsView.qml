import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id:detailPage
    tools: sharedToolBar
    Flickable {
        id:detailFlick
        contentHeight: details.height + dtlColumn.height + 69 //EE
        flickableDirection: Flickable.VerticalFlick
        anchors { right:parent.right; left:parent.left; top:parent.top; bottom:parent.bottom; topMargin: 5;  rightMargin: 10; leftMargin: 10; }
        Item {
            id:details
            height: 145
            width: parent.width
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
                Text {
                    text:"Installed Version: " + uidGet
                    color:"#737373"
                    font.pointSize: 6; font.bold: true
                }
              }
            }
            Button {
                id:downloadButton
                anchors { top: iconName.bottom; right:parent.right }
                height: (installing) ? 0 : 40
                width:(finished) ? 120 : (downloading) ? 44 : 120
                text:(!finished) ? (!downloading) ? "Download" : "" : "Install"
                iconSource: (downloading) ? "ui/x-marked.svg" : ""
                platformInverted: invertedTheme
                onClicked:{
                    if(text=="") {
                        dlhelper.cancelDownload();
                        busyind.value=0
                    }
                    if(!downloading) {
                        if(!finished) {

                        downloading=true
                            if(!link){
                                dlhelper.setTarget(sis);
                                dlhelper.download();
                            }else{
                                dlhelper.setLink(link);
                                dlhelper.download();
                            }
                        } else {
                            if(insMethod==1){
                                core.sisInstallGUI(sis);
                            }
                            else {
                                dlhelper.installDownload(sis);
                                installing=true
                            }

                            finished=false
                        }
                    }
                }
                Text {
                    text:(installing) ? "Installing..." : ""
                    color:"#737373"
                    anchors { horizontalCenter: downloadButton.horizontalCenter; verticalCenter: downloadButton.verticalCenter; verticalCenterOffset: 20 }
                }
                ProgressBar {
                    id:busyind
                    anchors {right: parent.left; rightMargin: 10; verticalCenter: parent.verticalCenter }
                    minimumValue: 0
                    maximumValue: 100
                    platformInverted: invertedTheme
                    width:250
                    value:(!downloading) ? 0 : dlhelper.getProgress();
                    visible: (downloading) ? true : false
                }
                Timer {
                    running: (downloading) ? true : false
                    repeat: true
                    interval: 1200
                    onTriggered: {
                        busyind.value = dlhelper.getProgress();
                    }
                    onRunningChanged: {
                        busyind.value = 0
                    }
                }
            }
        }
        Item {
            id:detail2
            anchors {top: details.bottom; topMargin: 25; right:parent.right; left:parent.left }
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
                    onWidthChanged: console.log(width)
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
    Component.onCompleted:  {
        dlhelper.delFile(sis)
        finished=false
        downloading=false
    }

}
