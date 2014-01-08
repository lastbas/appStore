// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id:updatePage
    BorderImage {
        id: logo
        anchors { verticalCenterOffset: -50; verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter }
        source: "ui/appstore.png"
    }
    Button {
        id:retryButton
        platformInverted: invertedTheme
        text:"Download"
        width:120
        height:50
        anchors { horizontalCenter: parent.horizontalCenter; top:logo.bottom; topMargin:100 }
        onClicked: {
            dlhelper.setTarget("update.sis")
            dlhelper.download();
        }
        Connections {
            id:connector
            target: dlhelper
            onDone: {
                core.installUpdate();

            }
            onTam: {

            }
        }
        QueryDialog {
            id:updateDialog
            titleText: "Update"
            message: "The App Store is updated now."
            acceptButtonText: "Go to the Store"

            platformInverted: invertedTheme
            onAccepted: {
                updatePage.pageStack.pop()
            }
        }
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
