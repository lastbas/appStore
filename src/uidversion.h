#ifndef UIDVERSION_H
#define UIDVERSION_H

#include <QObject>
#include <QtCore>
#include <QApplication>
#include "apgicnfl.h"
#include <apmrec.h>
#include <swi/sisregistrypackage.h>
#include <swi/sisregistrysession.h>
#include <swi/sisregistryentry.h>
#include <apgwgnam.h>
#include <apparc.h>
#include <apgcli.h>

class AppUid : public QObject
{
    Q_OBJECT
public:
    explicit AppUid(QObject *parent = 0);
    Q_INVOKABLE QString uidTo(const QString& uidDa);
    QString uidPl(const QString& nh);
private:
    mutable int iError;
};

#endif // UIDVERSION_H
