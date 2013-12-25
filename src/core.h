#ifndef CORE_H
#define CORE_H

#include <QObject>
#include <QString>
#include <apgcli.h>
#include <QDebug>
#include <QUrl>
#include <QDebug>
class core : public QObject
{
    Q_OBJECT
public:
    explicit core(QObject *parent = 0);
    Q_INVOKABLE void sisInstallGUI(const QString &sisname);
    Q_INVOKABLE void compareString(const QString &str, const QString &str2);
signals:
    Q_INVOKABLE void categorieChanged();
public slots:

};

#endif // CORE_H
