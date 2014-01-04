#ifndef FIM_H
#define FIM_H
#include <QObject>
#include <QtGui>
#include <QtCore>
#include <SWInstApi.h>
#include <SWInstDefs.h>

#include <e32math.h>
#include <APACMDLN.H>
#include <W32STD.H>

#include <BAFINDF.H>
#include <BADESCA.H>
#include <APGTASK.H>
#include <e32base.h>
#include <e32des8.h>
class Installer : public QObject {
    Q_OBJECT
public:
    explicit Installer();
    ~Installer();
    int filInst(const QString& uril,const QString &in);
    Q_INVOKABLE void drive(const QString& aa);
    void Uninstall(TInt aUid);
public slots:
    void process();
    void ex();
    void test();

signals:
    void finished();
    void ok();
    void uninstallFinished();
private:
    QString hh;
    QString del;
    TChar * eFla; //select drive
    TFileName iDoFe; //file name convert C++
    SwiUI::RSWInstSilentLauncher iBasla; //dont touch
    SwiUI::TInstallOptions iSeck; //dont touch
    SwiUI::TInstallOptionsPckg iSeckPckg; //dont touch
    int acma;
    QString ppp;

    TUid uid;
};
#endif // FIM_H
