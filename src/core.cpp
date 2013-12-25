#include "core.h"

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

void core::compareString(const QString &str, const QString &str2) {
    qDebug()<<str;
    if(QString::compare(str, str2, Qt::CaseInsensitive)== 0) {
        return false;
        qDebug("false");
    } else {
        return true;
        qDebug("true");
    }
}
