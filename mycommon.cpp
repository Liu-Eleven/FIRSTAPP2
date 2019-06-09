#include "mycommon.h"
#include <QProcess>
#include <QFileInfo>
#include <QDir>
#include <QDomDocument>
#include <QDebug>

MyCommon::MyCommon(QObject *object):
    QObject(object)
  ,m_process(NULL)
  ,m_parentItemIndex(-1)
  ,m_itemIndex(-1)
  ,m_enable(true)
{
    readSettings();
    checkMyProcessPath();
}

MyCommon::~MyCommon()
{
    if(m_process!=nullptr)
    {
        m_process->close();
        m_process->deleteLater();
    }
}

void MyCommon::checkMyProcess()
{
    emit closeMyProcess();
}

QString MyCommon::getCurrentPath() const
{
    return QDir::currentPath();
}

//启动另外一个程序
void MyCommon::setMyProcess(const QString &path)
{
    if(m_enable == false)
    {
        //return;
    }

    QFileInfo fileInfo(path);
    if(!fileInfo.exists())
    {
        myProcessPathError(path);
        return;
    }
    m_process=new QProcess(this);
    connect(m_process,SIGNAL(finished(int)),this,SLOT(checkMyProcess()));
    connect(m_process,SIGNAL(error(QProcess::ProcessError)),this,SLOT(checkMyProcess()));
    //
    QStringList arguments;
    m_process->setWorkingDirectory(fileInfo.dir().path());
    m_process->start(fileInfo.filePath(),arguments);
}

void MyCommon::readSettings()
{
    QDomDocument doc;
    QFile file(QString(":/xml/RES/setting.xml"));
    if(!file.open(QFile::ReadOnly | QFile::Text)){
        qDebug() << "Error: Cannot read file: ";
        return;
    }
    if (!doc.setContent(&file))
    {
        file.close();
        qDebug() << "Error: Cannot read dom: ";
        return;
    }
    QDomElement docElem=doc.documentElement();

    QString testName = docElem.tagName();
    //qDebug()<<testName;
    if( testName == QString("programSet") )
    {
        m_titleName=docElem.attribute(QString("bigTitle"));
        //qDebug()<<"m_titleName="<<m_titleName<<docElem.attribute(QString("bigTitle"));
    }



    for(int i=0;i<docElem.childNodes().count();i++)
    {
        QDomElement select=docElem.childNodes().at(i).toElement();
        if(select.tagName()==QString("clausesAndSubclauses"))
        {
            QMap <QString,QVariant>map1;
            map1.insert(QString("title"),QVariant(select.attribute(QString("title"))));
            QVariantList listItemList;
            for(int i=0;i<select.childNodes().count();i++)
            {
                QDomElement select2=select.childNodes().at(i).toElement();
                if(select2.tagName()==QString("subclauses"))
                {
                    QMap <QString,QVariant>map2;
                    map2.insert(QString("title"),QVariant(select2.attribute(QString("title"))));
                    for(int i=0;i<select2.childNodes().count();i++)
                    {
                        QDomElement select3=select2.childNodes().at(i).toElement();
                        if(select3.tagName()==QString("path"))
                        {
                            map2.insert(QString("path"),QVariant(select2.text()));
                        }
                    }
                    listItemList.append(QVariant(map2));
                }
            }
            map1.insert(QString("items"),QVariant(listItemList));
            m_itemList.append(QVariant(map1));
        }
    }

    //qDebug()<<m_itemList;
}

void MyCommon::checkMyProcessPath()
{
    QFileInfo fileinfo;
    for(int i=0;i<m_itemList.count();i++)
    {
        QVariantList myItemList=m_itemList[i].toMap().value("items").toList();
        for(int x=0;x<myItemList.length();x++)
        {
            QString path=myItemList[x].toMap().value("path").toString();
            if(fileinfo.exists(path))
            {
               // qDebug()<<"load Ini Text Success!";
            }
            else
            {
                m_enable=false;
                //qDebug()<<"load Ini Text Error!";
                emit myProcessPathError(path);
            }
        }
    }
}
