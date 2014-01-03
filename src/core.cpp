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

TInt core::RunApp(TInt aUid)
{
    RApaLsSession apaLsSession;
    TInt ret = apaLsSession.Connect();
    if (ret != KErrNone)
        return ret;

    CleanupClosePushL(apaLsSession);

    TApaAppInfo appInfo;
    TUid uid;
    uid.iUid = aUid;
    ret = apaLsSession.GetAppInfo(appInfo, uid);
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

void core::doRunApp(const QString uidStr) {
   TPtrC16 tdesc(reinterpret_cast<const TText*>(uidStr.constData()));
   RunApp(HexStr2Int32(tdesc));
}

TInt core::GetHex(char hex)
{
    if (hex >= '0' && hex <= '9')
        return hex - '0';

    if (hex >= 'a' && hex <= 'f')
        return hex - 'a' + 10;

    if (hex >= 'A' && hex <= 'F')
        return hex - 'A' + 10;

    return 0;
}

TInt32 core::HexStr2Int32(const TDesC &aHexStr)
{
    TInt len = aHexStr.Length();
    if(len > 10) return 0;

    TInt32 res = 0;
    TInt32 tmp = 0;
    const TUint16 * hexString = aHexStr.Ptr();

    TInt i = 0;

    if (aHexStr.Length() > 1 && aHexStr[0] == '0' &&
        (aHexStr[1] == 'x' || aHexStr[1] == 'X'))
        i = 2;

    for (; i < len; i++)
    {
        tmp = GetHex(hexString[i]);

        tmp <<= ((len-i-1)<<2);
        res |= tmp;
    }

    return res;
}


