#include "uidversion.h"
#include "core.h"
#include <QUuid>

AppUid::AppUid(QObject *parent) :
    QObject(parent)
{

}
AppUid::~AppUid() {
    // free resources
}
QString AppUid::uidTo(const QString &uidDa) {
    Swi::RSisRegistrySession iSisRegSession;
    User::LeaveIfError(iSisRegSession.Connect());
    Swi::RSisRegistryEntry packageEntry;
    QString retu;
    bool ok;
    uint uids = uidDa.toUInt(&ok,16);
    TUid uidt;
    uidt.iUid = uids;
                if( KErrNone == packageEntry.Open(iSisRegSession, uidt))
                {
                    TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                    retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }
    if(retu=="")
        return "NI";
    else
        return retu;
}
QString AppUid::checkInsDrive(const QString &uidDa) {
    Swi::RSisRegistrySession iSisRegSession;
    User::LeaveIfError(iSisRegSession.Connect());
    Swi::RSisRegistryEntry packageEntry;
    QString drive;
    bool ok;
    uint uids = uidDa.toUInt(&ok,16);
    TUid uidt;
    uidt.iUid = uids;
                if( KErrNone == packageEntry.Open(iSisRegSession, uidt))
                {
                    drive = packageEntry.SelectedDriveL();
                }
    if(drive=="")
        return "NI";
    else
        return drive;
}


