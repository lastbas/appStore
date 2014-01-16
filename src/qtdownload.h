#ifndef QTDOWNLOAD_H
#define QTDOWNLOAD_H
#include <QObject>
#include <QString>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkReply>

#include <fim.h>

#include <download.h>

#include <counter.h>
class QtDownload : public QObject {
    Q_OBJECT
public:
    explicit QtDownload(QWidget *parent = 0);
    ~QtDownload();
    QString r;
    QString t;
    QString i;
    int progress;
    Q_INVOKABLE void setTarget(const QString& t);
    Q_INVOKABLE void setLink(const QString& l);
    Q_INVOKABLE void delFile(const QString& file);
    Q_INVOKABLE void installDownload(const QString &ii);
    Q_INVOKABLE void cancelDownload();
    Q_INVOKABLE void path(const QString& pa);
    Q_INVOKABLE float getProgress();
    Q_INVOKABLE void doUninstall(const QString &uidStr);
    Q_INVOKABLE TInt Uninstall(TInt aUid);
    Q_INVOKABLE void incrDownCount(int operation,const QString& yud);
    Q_INVOKABLE QString downCountl();
private:
    QString target;
    QString pan;
    QString flNa;
    Download* downll;
    QNetworkReply *repl;
    QString cotter;
    Counter* countSa;

signals:
    Q_INVOKABLE void done();
    Q_INVOKABLE void finishUninstall();
    Q_INVOKABLE void donefile();
    Q_INVOKABLE void countNumberReceived();
    Q_INVOKABLE void tam();//info banner
    Q_INVOKABLE void cancelled();//cancel download
private slots:
    void dowCountFin(const QString& cevv);
public slots:
    Q_INVOKABLE  void download();
    void ok();
    void proccc(int val);
    void statech(State st);
    void empty();
    void downComp();
    void uninstallFinished();

};

#endif //QTDOWNLOAD_H
