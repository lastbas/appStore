import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id:aboutPage
    tools:tolBar
    ToolBar {
        id:tolBar
        tools: tolBarLayout
        platformInverted: false
    }

    ToolBarLayout {
        id:tolBarLayout
        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            onClicked: {
                    window.pageStack.pop();
            }
        }
    }
    Flickable {
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: image1.height + devs.height + tolBar.height

        flickableDirection: Flickable.VerticalFlick
        Image {
            id: image1
            anchors { top:parent.top; topMargin: 40; horizontalCenter: parent.horizontalCenter }
            source: "ui/appstore.png"
        }
        Text {
            id:devs
            text: "Developed by<br>Lucas Facchini<br>Mesut Aktaş<br>Fabian Hüllmantel<br>Maciej Janiszewski<br><br>Hosting Service provided by:<br>Magissia<br><br>PHP Scripts:<br>dankoi<br><br>Sis files provided by:<br>matthewkuhl"
            font.pointSize: 7
            color: (invertedTheme) ? "black" : "white"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: image1.bottom
            textFormat: Text.RichText;
        }
    }
}
