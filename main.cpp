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
Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    /*QSplashScreen *splash = new QSplashScreen(QPixmap("qml/ui/screen.png"));
    splash->show();*/
    QApplication::setGraphicsSystem("raster");
    QmlApplicationViewer viewer;

    viewer.setAttribute(Qt::WA_OpaquePaintEvent);
    viewer.setAttribute(Qt::WA_NoSystemBackground);
    viewer.setProperty("orientationMethod", 1);
    //viewer.setAttribute(Qt::WA_LockPortraitOrientation);
    QtDownload dl;
    viewer.rootContext()->setContextProperty("dlhelper",&dl);
    Download pHas;
    viewer.rootContext()->setContextProperty("dll",&pHas);
    core f;
    viewer.rootContext()->setContextProperty("core",&f);
    AppUid appISN;
    viewer.rootContext()->setContextProperty("uidApp",&appISN);
    //internet connection opening
    QNetworkConfigurationManager ppp;
    QNetworkSession *nnn = new QNetworkSession(ppp.defaultConfiguration());
    nnn->open();

    viewer.setMainQmlFile(QLatin1String("qml/appstore/main.qml"));
    viewer.showExpanded();
    /*splash->finish(&viewer);
    splash->deleteLater();*/
    return app->exec();
}
