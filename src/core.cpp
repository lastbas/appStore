#include "core.h"
#include <QUuid>
#include <QRegExp>
#include <uidversion.h>
#include <fim.h>
core::core(QObject *parent) :
    QObject(parent)
{

}


void core::sisInstallGUI(const QString &sisname) {
    RApaLsSession apaLsSession;
    CleanupClosePushL(apaLsSession );
    User::LeaveIfError(apaLsSession.Connect());
    TThreadId threadId;
    QString path;
    path = "C:\\private\\e6002cd5\\" + sisname;
    TPtrC16 symbianpath(reinterpret_cast<const TUint16*>(path.utf16()));
    apaLsSession.StartDocument(symbianpath, threadId);
    CleanupStack::PopAndDestroy(&apaLsSession );
}

void core::doRunApp(const QString &uidDa)
{
    RApaLsSession apaLsSession;
    TInt ret = apaLsSession.Connect();
    if (ret != KErrNone)
        return ret;

    CleanupClosePushL(apaLsSession);

    TApaAppInfo appInfo;
    bool ok;
    uint uids = uidDa.toUInt(&ok,16);
    TUid uidt;
    uidt.iUid = uids;
    ret = apaLsSession.GetAppInfo(appInfo, uidt);
    if(ret == KErrNone)
    {
        CApaCommandLine* cmdLine = CApaCommandLine::NewLC();
        cmdLine->SetExecutableNameL(appInfo.iFullName);
        cmdLine->SetCommandL(EApaCommandRun);
        ret = apaLsSession.StartApp(*cmdLine);
        CleanupStack::PopAndDestroy(cmdLine);
    }
    CleanupStack::PopAndDestroy(&apaLsSession);
    return ret;
}



