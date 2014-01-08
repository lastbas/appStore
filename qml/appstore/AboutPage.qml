import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id:aboutPage
    Image {
        id: image1
        anchors { verticalCenterOffset: -120; horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
        source: "ui/appstore.png"
    }
    Text {
        text: "Developed by<b>Lucas Facchini<br>Mesut Aktaş<br>Fabian Hüllmantel<br>Maciej Janiszewski<br>"
        font.pixelSize: 15
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: image1.bottom
        textFormat: Text.RichText;
    }
}
//dev list not finished yet!
