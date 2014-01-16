// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id:updatePage
    tools:tolBarLayout
    ToolBarLayout {
        id:tolBarLayout
        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            onClicked: {
                Qt.quit();
            }
        }
    }
    BorderImage {
        id: logo
        anchors { top: parent.top; topMargin: 20; horizontalCenter: parent.horizontalCenter }
        source: "ui/appstore.png"
    }
    Text {
        anchors { horizontalCenter: parent.horizontalCenter; top:logo.bottom; }
        text: "There is an update avaiable.<br>You can't use the store without updating."
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 6
    }

    Button {
        id:retryButton
        platformInverted: invertedTheme
        text:"Update"
        width:200
        height:(downloading) ? 0 : 50
        anchors { horizontalCenter: parent.horizontalCenter; top:logo.bottom; topMargin:50 }
        onClicked: {
            dlhelper.setTarget("update.sis")
            dlhelper.download();
            downloading=true
        }
        Connections {
            id:connector
            target: dlhelper
            onDone: {
                core.installUpdate();
                Qt.quit();
            }
        }
    }
    ProgressBar {
        id:busyind
        minimumValue: 0
        maximumValue: 100
        height:(visible) ? 25 : 0
        width:200
        platformInverted: invertedTheme
        value: 0
        anchors { horizontalCenter: parent.horizontalCenter; top:logo.bottom; topMargin:50 }
        visible: (downloading) ? true : false
    }
    Text {
        anchors { horizontalCenter: parent.horizontalCenter; top:retryButton.bottom; topMargin: 20 }
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 6
        color: "red"
        wrapMode: Text.Wrap
        width:updatePage.width - 20
        text: "Instructions: When you hit the Update button the download will start and when finished a installer window will appear. After that press OK and continue the instalation."
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
    Component.onCompleted: {
        dlhelper.delFile("update.sis")
    }
}

/*QueryDialog {
    id:updateDialog
    titleText: "Warning"
    message: "There is a update for the store, do you want to install it?"
    acceptButtonText: "Install"
    rejectButtonText: "Continue"
    platformInverted: invertedTheme
    onAccepted: {

    }
    onRejected: {
        close();
    }
}*/
