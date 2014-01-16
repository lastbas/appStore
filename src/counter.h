#ifndef COUNTER_H
#define COUNTER_H
#include <QtGui>
#include <QtCore>
#include <QtNetwork>

class Counter : public QObject
{
    Q_OBJECT

public:
    explicit Counter(QObject *parent = 0);
    ~Counter();

//    int down(const QString& url, const QString& name);
    int down(int operation, const QString& uids);

signals:
    void downComp(QString ap);
private slots:
    void com();

public slots:

private:
    QNetworkAccessManager* man;
    QNetworkReply *reply;

};
#endif // COUNTER_H
