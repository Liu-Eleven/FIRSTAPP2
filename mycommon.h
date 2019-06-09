#ifndef MYCOMMON_H
#define MYCOMMON_H

#include <QObject>
#include <QVariant>

class QProcess;

class MyCommon : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString titleName READ titleName )
    Q_PROPERTY(QVariantList itemList READ itemLists )
public:
    explicit MyCommon(QObject *object = nullptr);
    ~MyCommon();


public slots:
    QString getCurrentPath()const;

    void setMyProcess(const QString &path);
    Q_INVOKABLE QString titleName()const{return m_titleName;}
    Q_INVOKABLE QVariantList itemLists()const {return m_itemList;}

private :
    void readSettings();
    void checkMyProcessPath();

private :
    QProcess *m_process;
    QString m_titleName;
    QVariantList m_itemList;
    int m_parentItemIndex;
    int m_itemIndex;
    bool m_enable;

private slots:
    void checkMyProcess();

signals:
    void closeMyProcess();
    void myProcessPathError(const QString &path);
};

#endif // MYCOMMON_H
