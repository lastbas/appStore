#include "core.h"
#include <QUuid>
#include <QRegExp>
#include <uidversion.h>
#include <fim.h>
core::core(QObject *parent) :
    QObject(parent)
{

}

/*void core::test() {
    QGraphicsObject *root;
    obj = root->findChild<QObject *>("object");
    obj->setProperty("showStatusBar",false);

}*/

void core::installUpdate() {
    QString link = "C:/private/0xE6002CD5/update.sis";
    QDesktopServices::openUrl(QUrl(link));
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

void core::killApp(const QString &uidDa) {
    TPtrC16 tdesc(reinterpret_cast<const TText*>(uidDa.constData()));
    TFindProcess processFinder(tdesc);
    TFullName result;
    RProcess processHandle;
    while ( processFinder.Next(result) == KErrNone)
    {
       User::LeaveIfError(processHandle.Open ( result, EOwnerThread));
       processHandle.Kill(KErrNone);
       processHandle.Close();
    }
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
    TUid uidt;
    uidt.iUid = uidDa.toUInt(&ok,16);
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



