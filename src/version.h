#include <QObject>
#include <QString>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkReply>


class version : public QObject {
    Q_OBJECT
public:
    explicit version();
    ~version();
    void test();

private:
    QNetworkAccessManager manager;
    QString target;

signals:
    Q_INVOKABLE void upAvaiable();
public slots:
    Q_INVOKABLE  void get();
    void check(QNetworkReply* data);
    void downloadProgress(qint64 recieved, qint64 total);
};
