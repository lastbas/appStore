import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id:detailPage
    tools: sharedToolBar
    property string installedDrive: ""
    function updateVerify() {
      if(versionInstalled=="NI") {
          updateAv=false;
       } else if(versionInstalled==version) {
          updateAv=false;
          } else {
          updateAv=true;
       }
    }
    Timer {
        running: (downloading) ? true : false
        repeat: true
        interval: 1000
        onTriggered: {
            busyind.value = dlhelper.getProgress();
        }
        onRunningChanged: {
            busyind.value = 0
        }
    }
    Flickable {
        id:detailFlick
        contentHeight: details.height + dtlColumn.height + 69 //EE
        flickableDirection: Flickable.VerticalFlick
        anchors { right:parent.right; left:parent.left; top:parent.top; bottom:parent.bottom; topMargin: 5;  rightMargin: 10; leftMargin: 10; }
        Item {
            id:details
            height:192
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
                id:co
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
                    text:(installedDrive=="NI") ? "  " : "Installed on " + installedDrive + ":"
                    color:"#737373"
                    font.pointSize: 6.1; font.bold: true
                }
              }
            }
            Rectangle {
                id:divider
                anchors {
                    top:iconName.bottom;
                    topMargin: 15;
                    right:parent.right
                    left:parent.left
                }
                color: "grey"
                visible:invertedTheme
                height:1
                //width:340;
            }
            Connections {
                id:connector
                target: dlhelper
                onTam: {
                    finished=true;
                    if(updateAv) {
                        updateCount--;
                    }

                    versionInstalled = uidApp.uidTo(uid);
                    installedDrive = uidApp.checkInsDrive(uid);
                    updateVerify();
                    check.text="INSTALLED"
                    check.color = "#737373"
                }
                onFinishUninstall: {
                    versionInstalled = uidApp.uidTo(uid);
                    installedDrive = uidApp.checkInsDrive(uid);
                    updateVerify();
                    check.text=""
                    finished=false;
                    downloading=false;
                    uninstalling=false;
                    infobanner.iconSource= "ui/done.png"
                    infobanner.text = "Application Uninstalled"
                }
                onDone: {
                    downloading = false
                    if(!insMethod==1){
                        dlhelper.installDownload(sis);
                        installing=true
                        finished=false
                    } else {
                        finished = true
                    }
                }

            }
            Button {
                id:downloadButton
                anchors { top: iconName.bottom; right:parent.right; topMargin: 20 }
                visible:(installing) ? false : (versionInstalled=="NI") ? true : (updateAv) ? true: false;
                text:(!finished) ? (!downloading) ? "Download" : "Cancel" : "Install"
                platformInverted: invertedTheme
                onClicked:{
                    if(downloading) {
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


            }
            Text {
                text:(installing) ? "Installing..." : (uninstalling) ? "Uninstalling..." :  ""
                color:"#737373"
                font.pointSize: 7; font.bold: true
                height: downloadButton.height
                anchors { top: divider.top; topMargin: 15; horizontalCenter: parent.horizontalCenter }
            }
            ProgressBar {
                id:busyind
                //anchors {right: parent.left; rightMargin: 10; verticalCenter: parent.verticalCenter }
                anchors {  verticalCenter: downloadButton.verticalCenter; left:parent.left; right:downloadButton.left; rightMargin: 10 }
                minimumValue: 0
                maximumValue: 100
                platformInverted: invertedTheme
                value:(!downloading) ? 0 : dlhelper.getProgress();
                visible: (downloading) ? true : false
            }
            Row {
                anchors { top: iconName.bottom; right:parent.right; topMargin: 20 }
                spacing: 3
            Button {
                id:runButton
                width:110
                checked: true
                visible:(uninstalling) ? false : (versionInstalled==="NI") ? false : (updateAv) ? false : true
                //anchors { top: iconName.bottom; right:parent.right; topMargin: 20 }
                platformInverted: invertedTheme
                text: "Run"
                onClicked: {
                    core.doRunApp(uid);
                }
            }
            Button {
                id:unButton
                width:120
                visible:(uninstalling) ? false : (runButton.visible) ? true : false
                //anchors { top: runButton.top; topMargin: 47; right:runButton.right; }
                platformInverted: invertedTheme
                text: "Uninstall"
                onClicked: {
                    uninstalling=true
                    dlhelper.doUninstall(uid);
                }
            }
            }
        }
        Rectangle {
            id:divider2
            anchors {
                bottom: detail2.top
                bottomMargin: 10
                right:parent.right
                left:parent.left
            }
            color: "grey"
            visible:invertedTheme
            height:1
            //width:340;
        }
        Item {
            id:detail2
            anchors {top: details.bottom; topMargin: 20; right:parent.right; left:parent.left }
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
    Component.onCompleted:  {
        versionInstalled = uidApp.uidTo(uid);
        installedDrive = uidApp.checkInsDrive(uid);
        dlhelper.delFile(sis);
        updateVerify();
    }
}
