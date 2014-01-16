#include "version.h"
#include <QCoreApplication>
#include <QUrl>
#include <QNetworkRequest>
#include <QFile>
#include <QDebug>
#include <uidversion.h>
#include <QGraphicsObject>
version::version() : QObject(0) {
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)),this, SLOT(check(QNetworkReply*)));
}

version::~version() {

}


void version::check(QNetworkReply *data) {
    const QByteArray sdata = data->readAll();
    qDebug()<<sdata;
    AppUid u;
    if(data) {
        if(u.uidTo("0xE6002CD5") == sdata) {
            qDebug()<<u.uidTo("0xE6002CD5");
            qDebug("no update");


        } else {
            qDebug()<<u.uidTo("0xE6002CD5");
            qDebug("update avaiable");
            emit upAvaiable();
        }
    }
}

void version::get() {
    target = "http://repo.symbian.odin.magissia.com/data/lastversion.txt";
    QUrl url = QUrl::fromEncoded(this->target.toLocal8Bit());
    QNetworkRequest request(url);
    QObject::connect(manager.get(request), SIGNAL(downloadProgress(qint64,qint64)), this, SLOT(downloadProgress(qint64,qint64)));

}

void version::downloadProgress(qint64 recieved, qint64 total) {
    qDebug() << recieved << total;
}
