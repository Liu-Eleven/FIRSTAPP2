TEMPLATE = app

QT += qml quick
QT += xml

RC_ICONS = $$PWD/RES/icon.ico

DESTDIR = $$OUT_PWD/bin

CONFIG(release,debug|release){
TARGET = FIRSTAPP2
CONFIG +=warn_off
}else{
TARGET = FIRSTAPP2_d
CONFIG +=warn_on
}

SOURCES += main.cpp \
    mycommon.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    mycommon.h

DISTFILES += \ \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml


ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
