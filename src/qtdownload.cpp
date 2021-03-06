#include "qtdownload.h"
#include <QCoreApplication>
#include <apgcli.h>  //RApaLsSession
#include <apgtask.h> //TApaTaskList
#include <w32std.h>  //RWsSession
#include <QUrl>
#include <QNetworkRequest>
#include <QFile>
#include <QDebug>
#include <QDesktopServices>
#include <QDir>
#include <core.h>
#include <QtNetwork>

QtDownload::QtDownload(QWidget *parent) : QObject(parent) {
    i = "C:\\private\\e6002cd5\\";
    downll = new Download(this);
    connect(downll,SIGNAL(progress(int)),this,SLOT(proccc(int)));
    connect(downll,SIGNAL(satatechan(State)),this,SLOT(statech(State)));
    connect(downll,SIGNAL(downComp()),this,SLOT(downComp()));
    connect(downll,SIGNAL(cda()),this,SLOT(empty()));

    countSa = new Counter(this);
    connect(countSa,SIGNAL(downComp(QString)),this,SLOT(dowCountFin(QString)));

}
QtDownload::~QtDownload() {
    QString path = tr("C:\\private\\e6002cd5") + "/" + flNa;
    QFile ii(path);
    ii.remove();
}

void QtDownload::setTarget(const QString &t) {
    flNa = t;
    QString lB = t.section("/", -1, -1);
    QFile localFile(lB);
    if (localFile.exists(lB)) {
        emit done();
    } else {
    this->target = QString("http://repo.symbian.odin.magissia.com/data/sis/"+t);
    }
}
void QtDownload::setLink(const QString &l) {
    flNa = l;
    QString lB = l.section("/", -1, -1);
    QFile localFile(lB);
    if (localFile.exists(lB)) {
        emit done();
    } else {
    this->target = l;
    }
}

void QtDownload::incrDownCount(int operation,const QString &yud) {
    countSa->down(operation, yud);
}

void QtDownload::installDownload(const QString &ii) {
    QThread* thread = new QThread;
    Installer* iiHf = new Installer();

    iiHf->drive(pan);
    QString sol = i + ii;
    iiHf->filInst(sol,ii);
    iiHf->moveToThread(thread);

    QObject::connect(iiHf,SIGNAL(ok()),this,SLOT(ok()),Qt::QueuedConnection);
    QObject::connect(thread, SIGNAL(started()), iiHf, SLOT(process()));
    QObject::connect(iiHf, SIGNAL(finished()), thread, SLOT(quit()));
    QObject::connect(iiHf, SIGNAL(finished()), iiHf, SLOT(deleteLater()));
    QObject::connect(thread, SIGNAL(finished()), thread, SLOT(deleteLater()));
    thread->start();
    return;
}


void QtDownload::doUninstall(const QString &uidStr) {

    QThread* thread = new QThread;
    Installer* worker = new Installer();

    bool ok;
    uint uids = uidStr.toUInt(&ok,16);

    worker->Uninstall(uids);
    worker->moveToThread(thread);
    QObject::connect(worker, SIGNAL(uninstallFinished()),this,SLOT(uninstallFinished()),Qt::QueuedConnection);
    QObject::connect(thread, SIGNAL(started()), worker, SLOT(test()));
    QObject::connect(worker, SIGNAL(uninstallFinished()), thread, SLOT(quit()));
    QObject::connect(worker, SIGNAL(uninstallFinished()), worker, SLOT(deleteLater()));
    QObject::connect(thread, SIGNAL(finished()), thread, SLOT(deleteLater()));
    thread->start();

}

TInt QtDownload::Uninstall(TInt aUid) //this is from MiniCMD sources
{
    TUid uid;
    uid.iUid = aUid;

    SwiUI::RSWInstSilentLauncher iLauncher;

    User::LeaveIfError(iLauncher.Connect());

    SwiUI::TUninstallOptions options;
    options.iBreakDependency = SwiUI::EPolicyAllowed;
    options.iKillApp = SwiUI::EPolicyAllowed;
    SwiUI::TUninstallOptionsPckg optPckg(options);

    TInt ret = iLauncher.SilentUninstall(uid, optPckg, SwiUI::KSisxMimeType());

    iLauncher.Close();
    qDebug("Application Uninstalled");
    finishUninstall();
    return ret;

}
void QtDownload::delFile(const QString &file){
    QString path = tr("C:\\private\\e6002cd5") + "/" + file;
    QFile ii(path);
    ii.remove();
}
void QtDownload::download() {
    QUrl url = QUrl::fromEncoded(target.toLocal8Bit());
    QString lastBit = target.section("/", -1, -1);
    qDebug()<<lastBit;
    downll->down(url.toString(),lastBit);
}
void QtDownload::cancelDownload() {
    QTimer::singleShot(50,downll,SLOT(cancelDownload()));
}
void QtDownload::ok(){
    emit tam();
}
void QtDownload::proccc(int val)
{
    qDebug()<<val;
    double dd = val;
    int pr = static_cast<int>(dd);
    progress=pr;
}
float QtDownload::getProgress()
{
    return progress;
}
void QtDownload::statech(State st)
{
    qDebug()<<"xxx : "<<st;
}
void QtDownload::downComp(){
    emit done();
}
void QtDownload::empty()
{
    emit cancelled();
}
void QtDownload::path(const QString &pa)
{
    pan.clear();
    pan = pa;
}
void QtDownload::uninstallFinished()
{
    emit finishUninstall();
}
void QtDownload::dowCountFin(const QString &cevv)
{
    cotter = cevv;
    emit countNumberReceived();
}
QString QtDownload::downCountl()
{
    return cotter;
}
