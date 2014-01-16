#include <QtGui>
#include <QtCore>
#include <QtNetwork>
#include <counter.h>
Counter::Counter(QObject *parent) : QObject(parent)
{
    man = new QNetworkAccessManager(this);
}
Counter::~Counter(){
    delete reply;
}
int Counter::down(int operation, const QString &uids){
    //QString fin = uids.mid(2,-1);

    if(man->networkAccessible() != QNetworkAccessManager::Accessible)
    {
        delete man;
        man = new QNetworkAccessManager(this);
    }

    qDebug()<<"Count basladi";
    if(operation==0) {
        QString url = "here goes the php script url"+uids+"something else";
        QNetworkRequest req(url);
        reply = man->get(req);
        if(reply)
        {
            connect(reply,SIGNAL(finished()),this,SLOT(com()));

        }
    } else {
    QString url = "here goes the php script url"+uids+"something else"; 
    QNetworkRequest req(url);
    reply = man->get(req);
    if(reply)
    {
        connect(reply,SIGNAL(finished()),this,SLOT(com()));

    }
    }


    return 0;
}
void Counter::com(){

    if(reply->error()){
        qDebug()<<"ERROR ; "<<reply->error();

    }
    else
    {
        QByteArray satir = (reply->readAll());
        QString counter = QString::fromUtf8(satir.data());
        emit downComp(counter);

    }

}
