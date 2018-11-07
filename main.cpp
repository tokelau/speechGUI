#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include <QFileInfo>

#include "rnnoise/denoise.c"
#include "rnnoise/kiss_fft.c"
#include "rnnoise/pitch.c"
#include "rnnoise/rnn.c"
#include "rnnoise/rnn_data.c"

#include "noisedeleter.h"
#include "texthandler.h"
#include "vocabularyhandler.h"

int main(int argc, char *argv[])
{
    TextHandler th;
    VocabularyHandler vh;
//    NoiseDeleter nd;
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QQuickStyle::setStyle(QLatin1String("Material"));

    QGuiApplication app(argc, argv);

    qmlRegisterType<NoiseDeleter>("RNnoise", 1, 0, "NoiseDeleter");

    QQmlApplicationEngine engine;

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    engine.rootContext()->setContextProperty("TextHandler", &th);
    engine.rootContext()->setContextProperty("VocabularyHandler", &vh);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
