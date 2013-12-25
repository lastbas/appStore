#include <QObject>
#include <QString>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkReply>


class HttpReq : public QObject {
    Q_OBJECT
public:
    explicit HttpReq();
    ~HttpReq();

   Q_INVOKABLE void setTarget(const QString& t);

private:
    QNetworkAccessManager manager;
    QString target;

signals:
    void done();

public slots:
  Q_INVOKABLE  void download();
    void downloadFinished(QNetworkReply* data);
    void downloadProgress(qint64 recieved, qint64 total);
};
