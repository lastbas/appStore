#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "src/qtdownload.h"
#include <QtGui/QSplashScreen>
#include <QtGui/QPixmap>
#include <QtDeclarative/QDeclarativeContext>
#include <QtDeclarative/QDeclarativeNetworkAccessManagerFactory>
#include <QtDeclarative/QDeclarativeEngine>
#include <QDebug>
#include <QtDeclarative>
#include <QCoreApplication>
#include <core.h>
#include <download.h>
#include <uidversion.h>
#include <eventFilter.h>
#include <version.h>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QApplication::setGraphicsSystem("raster");
    QmlApplicationViewer viewer;
    viewer.setAttribute(Qt::WA_OpaquePaintEvent);
    viewer.setAttribute(Qt::WA_NoSystemBackground);
    viewer.setProperty("orientationMethod", 1);
    QtDownload dl;
    viewer.rootContext()->setContextProperty("dlhelper",&dl);
    Download pHas;
    viewer.rootContext()->setContextProperty("dll",&pHas);
    core f;
    viewer.rootContext()->setContextProperty("core",&f);
    version hr;
    viewer.rootContext()->setContextProperty("version",&hr);
    AppUid appISN;
    viewer.rootContext()->setContextProperty("uidApp",&appISN);
    EventFilter ef;
    viewer.installEventFilter(&ef);

    //app.setApplicationName("Opera/9.80 (iPhone; Opera Mini/7.1.32694/27.1407; U; en) Presto/2.8.119 Version/11.10");
    viewer.setMainQmlFile(QLatin1String("qml/appstore/main.qml"));
    viewer.showExpanded();
    //internet connection opening
    QNetworkConfigurationManager ppp;
    QNetworkSession *nnn = new QNetworkSession(ppp.defaultConfiguration());
    nnn->open();
    return app.exec();
}
