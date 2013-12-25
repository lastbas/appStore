#include "HttpReq.h"
#include <QCoreApplication>
#include <QUrl>
#include <QNetworkRequest>
#include <QFile>
#include <QDebug>

HttpReq::HttpReq() : QObject(0) {
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)),this, SLOT(downloadFinished(QNetworkReply*)));
}

HttpReq::~HttpReq() {

}


void HttpReq::setTarget(const QString &t) {
    this->target = t;
    qDebug("Set");
}

void HttpReq::downloadFinished(QNetworkReply *data) {
    qDebug("finished data");
    qDebug()<<data;
    emit done();
}

void HttpReq::download() {
    QUrl url = QUrl::fromEncoded(this->target.toLocal8Bit());
    QNetworkRequest request(url);
    QObject::connect(manager.get(request), SIGNAL(downloadProgress(qint64,qint64)), this, SLOT(downloadProgress(qint64,qint64)));

}

void HttpReq::downloadProgress(qint64 recieved, qint64 total) {
    qDebug() << recieved << total;
}
