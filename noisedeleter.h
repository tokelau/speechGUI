#ifndef NOISEDELETER_H
#define NOISEDELETER_H

#include <QObject>
#include <QString>
#include <QFile>
#include <QDebug>

#include "rnnoise/rnnoise.h"

#ifndef FRAME_SIZE
#define FRAME_SIZE 480
#endif // !FRAME_SIZE

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif // !M_PI

class NoiseDeleter : public QObject
{
    Q_OBJECT
public:
    NoiseDeleter(QObject* parent_ = nullptr);
    ~NoiseDeleter();

public slots:
    void openFile(QString filepath);
    void computeData();
    void saveDataToFile(QString filepath);

signals:
    void fileOpenError();
    void fileSaveError();

private:
    char header[44];
    QString inputFilepath;
    QString outputFilepath;
    std::vector<short> computedData;
    DenoiseState* st;
};

#endif // NOISEDELETER_H
