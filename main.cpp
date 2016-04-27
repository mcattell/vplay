#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "timeconvert.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    TimeConvert startTime(&app), currentTime(&app);

    TimeConvert::declareQML();

    engine.rootContext()->setContextProperty("startTimeObject", &startTime);
    engine.rootContext()->setContextProperty("currentTimeObject", &currentTime);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));



    return app.exec();
}
