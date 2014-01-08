import QtQuick 1.1
import com.nokia.symbian 1.1
import QtWebKit 1.0

Item {
    height:webView.height
    anchors { right:parent.right; left: parent.left; top:parent.top }
        BusyIndicator {
            anchors { horizontalCenter: parent.horizontalCenter; top: parent.top; topMargin: 30 }
            running: (webView.progress<1) ? true : false
            visible: (running) ? true : false
            width:40
            height:40
        }
        WebView {
            id:webView
            width:parent.width
            anchors { right: parent.right; left: parent.left; top: parent.top }
            contentsScale: 1
            visible: (progress==1) ? true : false
            html: "<body bgcolor='#f1f1f1'></body>"
            settings.pluginsEnabled: true
            settings.javascriptEnabled: true
            settings.javaEnabled: true
            pressGrabTime: 800;


            settings.javascriptCanAccessClipboard: true
            settings.offlineStorageDatabaseEnabled: true
            settings.offlineWebApplicationCacheEnabled: true
            settings.localStorageDatabaseEnabled: true
            property bool userLoggedonDisqus: false
            property string loginUrl: "http://disqus.com/next/login/?forum=storecom"
            property string loginSuccessUrl:  "http://disqus.com/next/login-success/"
            property string commentsUrl: "http://repo.symbian.odin.magissia.com/data/staticpage.html?shortname='storecom'&title=" + coid
            onHeightChanged: {
                Loader.height = height
            }

            onUrlChanged: {

                if(url==loginSuccessUrl) {
                    url=""
                    userLoggedonDisqus=true
                    url = commentsUrl
                }
                if(userLoggedonDisqus) if(url != commentsUrl) {
                        url=""
                        url = commentsUrl
                    }
                console.log(url)
            }
            Component.onCompleted: {
                url = loginUrl
            }
        }
}
