#include "uidversion.h"

AppUid::AppUid(QObject *parent) :
    QObject(parent)
{

}
QString AppUid::uidTo(const QString &uidDa) {
    Swi::RSisRegistrySession iSisRegSession;
    User::LeaveIfError(iSisRegSession.Connect());
    Swi::RSisRegistryEntry packageEntry;
    QString retu;
    QString alh = uidDa;
    qDebug()<<alh;
    bool ok;
    QString esli = alh.mid(0,4);
    qDebug()<<esli;
    int ahk = alh.toInt(&ok,16);
    TInt asbb = (reinterpret_cast<const char*>(ahk));
    TRAP(iError,
                if( KErrNone == packageEntry.Open( iSisRegSession, {asbb} ) )
                {
                    TPtrC16 islemilkl(packageEntry.PackageL()->Name().Alloc()->Des());
                    TPtrC16 uidlen(packageEntry.UidL().Name().Alloc()->Des());
                    TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                    qDebug()<<"UID::"<<QString::fromRawData(reinterpret_cast<const QChar*>(uidlen.Ptr()),uidlen.Length())<<" -- App::"<<QString::fromRawData(reinterpret_cast<const QChar*>(islemilkl.Ptr()),islemilkl.Length())<<" -- Version:"<<QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());

                    retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }

        if(retu=="")
        {
            if(alh=="0xE6193852")
            {
                if( KErrNone == packageEntry.Open( iSisRegSession, {0xE6193852} )){
                TPtrC16 islemilkl(packageEntry.PackageL()->Name().Alloc()->Des());
                TPtrC16 uidlen(packageEntry.UidL().Name().Alloc()->Des());
                TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                qDebug()<<"UID::"<<QString::fromRawData(reinterpret_cast<const QChar*>(uidlen.Ptr()),uidlen.Length())<<" -- App::"<<QString::fromRawData(reinterpret_cast<const QChar*>(islemilkl.Ptr()),islemilkl.Length())<<" -- Version:"<<QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }

            }
            if(alh=="0xE690E897")
            {
                if( KErrNone == packageEntry.Open( iSisRegSession, {0xE690E897} )){
                TPtrC16 islemilkl(packageEntry.PackageL()->Name().Alloc()->Des());
                TPtrC16 uidlen(packageEntry.UidL().Name().Alloc()->Des());
                TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                qDebug()<<"UID::"<<QString::fromRawData(reinterpret_cast<const QChar*>(uidlen.Ptr()),uidlen.Length())<<" -- App::"<<QString::fromRawData(reinterpret_cast<const QChar*>(islemilkl.Ptr()),islemilkl.Length())<<" -- Version:"<<QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }

            }
            if(alh=="0xA0016204")
            {
                if( KErrNone == packageEntry.Open( iSisRegSession, {0xA0016204} )){
                TPtrC16 islemilkl(packageEntry.PackageL()->Name().Alloc()->Des());
                TPtrC16 uidlen(packageEntry.UidL().Name().Alloc()->Des());
                TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                qDebug()<<"UID::"<<QString::fromRawData(reinterpret_cast<const QChar*>(uidlen.Ptr()),uidlen.Length())<<" -- App::"<<QString::fromRawData(reinterpret_cast<const QChar*>(islemilkl.Ptr()),islemilkl.Length())<<" -- Version:"<<QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }

            }
            if(alh=="0xef83b5a5")
            {
                if( KErrNone == packageEntry.Open( iSisRegSession, {0xef83b5a5} )){
                TPtrC16 islemilkl(packageEntry.PackageL()->Name().Alloc()->Des());
                TPtrC16 uidlen(packageEntry.UidL().Name().Alloc()->Des());
                TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                qDebug()<<"UID::"<<QString::fromRawData(reinterpret_cast<const QChar*>(uidlen.Ptr()),uidlen.Length())<<" -- App::"<<QString::fromRawData(reinterpret_cast<const QChar*>(islemilkl.Ptr()),islemilkl.Length())<<" -- Version:"<<QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }

            }
            if(alh=="0xE0D278F3")
            {
                if( KErrNone == packageEntry.Open( iSisRegSession, {0xE0D278F3} )){
                TPtrC16 islemilkl(packageEntry.PackageL()->Name().Alloc()->Des());
                TPtrC16 uidlen(packageEntry.UidL().Name().Alloc()->Des());
                TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                qDebug()<<"UID::"<<QString::fromRawData(reinterpret_cast<const QChar*>(uidlen.Ptr()),uidlen.Length())<<" -- App::"<<QString::fromRawData(reinterpret_cast<const QChar*>(islemilkl.Ptr()),islemilkl.Length())<<" -- Version:"<<QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }

            }
            if(alh=="0xE22AC278")
            {
                if( KErrNone == packageEntry.Open( iSisRegSession, {0xE22AC278} )){
                TPtrC16 islemilkl(packageEntry.PackageL()->Name().Alloc()->Des());
                TPtrC16 uidlen(packageEntry.UidL().Name().Alloc()->Des());
                TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                qDebug()<<"UID::"<<QString::fromRawData(reinterpret_cast<const QChar*>(uidlen.Ptr()),uidlen.Length())<<" -- App::"<<QString::fromRawData(reinterpret_cast<const QChar*>(islemilkl.Ptr()),islemilkl.Length())<<" -- Version:"<<QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }

            }
            if(alh=="0xEE69DAED")
            {
                if( KErrNone == packageEntry.Open( iSisRegSession, {0xEE69DAED} )){
                TPtrC16 islemilkl(packageEntry.PackageL()->Name().Alloc()->Des());
                TPtrC16 uidlen(packageEntry.UidL().Name().Alloc()->Des());
                TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                qDebug()<<"UID::"<<QString::fromRawData(reinterpret_cast<const QChar*>(uidlen.Ptr()),uidlen.Length())<<" -- App::"<<QString::fromRawData(reinterpret_cast<const QChar*>(islemilkl.Ptr()),islemilkl.Length())<<" -- Version:"<<QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }

            }
            if(alh=="0xE43B43AE")
            {
                if( KErrNone == packageEntry.Open( iSisRegSession, {0xE43B43AE} )){
                TPtrC16 islemilkl(packageEntry.PackageL()->Name().Alloc()->Des());
                TPtrC16 uidlen(packageEntry.UidL().Name().Alloc()->Des());
                TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                qDebug()<<"UID::"<<QString::fromRawData(reinterpret_cast<const QChar*>(uidlen.Ptr()),uidlen.Length())<<" -- App::"<<QString::fromRawData(reinterpret_cast<const QChar*>(islemilkl.Ptr()),islemilkl.Length())<<" -- Version:"<<QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }

            }
            if(alh=="0xE2A2FE74")
            {
                if( KErrNone == packageEntry.Open( iSisRegSession, {0xE2A2FE74} )){
                TPtrC16 islemilkl(packageEntry.PackageL()->Name().Alloc()->Des());
                TPtrC16 uidlen(packageEntry.UidL().Name().Alloc()->Des());
                TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                qDebug()<<"UID::"<<QString::fromRawData(reinterpret_cast<const QChar*>(uidlen.Ptr()),uidlen.Length())<<" -- App::"<<QString::fromRawData(reinterpret_cast<const QChar*>(islemilkl.Ptr()),islemilkl.Length())<<" -- Version:"<<QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }

            }
            if(alh=="0xE053ED98")
            {
                if( KErrNone == packageEntry.Open( iSisRegSession, {0xE053ED98} )){
                TPtrC16 islemilkl(packageEntry.PackageL()->Name().Alloc()->Des());
                TPtrC16 uidlen(packageEntry.UidL().Name().Alloc()->Des());
                TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                qDebug()<<"UID::"<<QString::fromRawData(reinterpret_cast<const QChar*>(uidlen.Ptr()),uidlen.Length())<<" -- App::"<<QString::fromRawData(reinterpret_cast<const QChar*>(islemilkl.Ptr()),islemilkl.Length())<<" -- Version:"<<QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }

            }
            if(alh=="0xE1AEB249")
            {
                if( KErrNone == packageEntry.Open( iSisRegSession, {0xE1AEB249} )){
                TPtrC16 islemilkl(packageEntry.PackageL()->Name().Alloc()->Des());
                TPtrC16 uidlen(packageEntry.UidL().Name().Alloc()->Des());
                TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                qDebug()<<"UID::"<<QString::fromRawData(reinterpret_cast<const QChar*>(uidlen.Ptr()),uidlen.Length())<<" -- App::"<<QString::fromRawData(reinterpret_cast<const QChar*>(islemilkl.Ptr()),islemilkl.Length())<<" -- Version:"<<QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }

            }
            if(alh=="0xEC338740")
            {
                if( KErrNone == packageEntry.Open( iSisRegSession, {0xEC338740} )){
                TPtrC16 islemilkl(packageEntry.PackageL()->Name().Alloc()->Des());
                TPtrC16 uidlen(packageEntry.UidL().Name().Alloc()->Des());
                TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                qDebug()<<"UID::"<<QString::fromRawData(reinterpret_cast<const QChar*>(uidlen.Ptr()),uidlen.Length())<<" -- App::"<<QString::fromRawData(reinterpret_cast<const QChar*>(islemilkl.Ptr()),islemilkl.Length())<<" -- Version:"<<QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }

            }
            if(alh=="0xE4603C80")
            {
                if( KErrNone == packageEntry.Open( iSisRegSession, {0xE4603C80} )){
                TPtrC16 islemilkl(packageEntry.PackageL()->Name().Alloc()->Des());
                TPtrC16 uidlen(packageEntry.UidL().Name().Alloc()->Des());
                TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                qDebug()<<"UID::"<<QString::fromRawData(reinterpret_cast<const QChar*>(uidlen.Ptr()),uidlen.Length())<<" -- App::"<<QString::fromRawData(reinterpret_cast<const QChar*>(islemilkl.Ptr()),islemilkl.Length())<<" -- Version:"<<QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }

            }
            if(alh=="0xE9C538AD")
            {
                if( KErrNone == packageEntry.Open( iSisRegSession, {0xE9C538AD} )){
                TPtrC16 islemilkl(packageEntry.PackageL()->Name().Alloc()->Des());
                TPtrC16 uidlen(packageEntry.UidL().Name().Alloc()->Des());
                TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                qDebug()<<"UID::"<<QString::fromRawData(reinterpret_cast<const QChar*>(uidlen.Ptr()),uidlen.Length())<<" -- App::"<<QString::fromRawData(reinterpret_cast<const QChar*>(islemilkl.Ptr()),islemilkl.Length())<<" -- Version:"<<QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }

            }
            if(alh=="0xA0000BCD")
            {
                if( KErrNone == packageEntry.Open( iSisRegSession, {0xA0000BCD} )){
                TPtrC16 islemilkl(packageEntry.PackageL()->Name().Alloc()->Des());
                TPtrC16 uidlen(packageEntry.UidL().Name().Alloc()->Des());
                TPtrC16 almabos(packageEntry.VersionL().Name().Alloc()->Des());
                qDebug()<<"UID::"<<QString::fromRawData(reinterpret_cast<const QChar*>(uidlen.Ptr()),uidlen.Length())<<" -- App::"<<QString::fromRawData(reinterpret_cast<const QChar*>(islemilkl.Ptr()),islemilkl.Length())<<" -- Version:"<<QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                retu = QString::fromRawData(reinterpret_cast<const QChar*>(almabos.Ptr()),almabos.Length());
                }

            }

        }

        );

    qDebug()<<"uidLAST:  "<<retu;
    if(retu=="")
        return "Not Installed";
    else
        return retu;
}

