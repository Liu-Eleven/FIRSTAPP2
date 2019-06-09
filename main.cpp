#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "mycommon.h"

#ifndef QtPlugins
#define QtPlugins "./QtPlugins"
#endif

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.addLibraryPath(QtPlugins);

    QQmlApplicationEngine engine;
    engine.addImportPath(QtPlugins);

    qmlRegisterType<MyCommon>("MyObject", 1, 0, "MyCommon");
    engine.load(QUrl(QString("qrc:/qml/RES/main.qml")));


    return app.exec();
}
