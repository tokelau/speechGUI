#include "noisedeleter.h"

NoiseDeleter::NoiseDeleter(QObject* parent) : QObject(parent)
{
    st = rnnoise_create();
}

void NoiseDeleter::openFile(QString filepath)
{
    inputFilepath = filepath;
}

void NoiseDeleter::computeData()
{
    QFile f(inputFilepath);

    if (!f.open(QFile::ReadOnly)) {
        qDebug() << "Невозможно открыть файл " << inputFilepath << " что бы считать его";
        return;
    }


    QFile of(outputFilepath);
    if (!of.open(QFile::WriteOnly)) {
        qDebug() << "Невозможно записать файл " << outputFilepath;
    }

    of.close();

    /*qDebug("start compute");
    if (inputFile.is_open()) {
        inputFile.read( (char*)&header , sizeof(char) * 44);
        while (inputFile.good()) {
            short tmp[FRAME_SIZE];
            float x[FRAME_SIZE];
            inputFile.read( (char*)&tmp , sizeof(short) * FRAME_SIZE);

            for (size_t i = 0; i<FRAME_SIZE; ++i) {
                x[i] = tmp[i];
            }
            rnnoise_process_frame(st, x, x);

            for (size_t i = 0; i<FRAME_SIZE; ++i) {
                rawDataComp.push_back(x[i]);
            }
        }
    }*/
}

void NoiseDeleter::saveDataToFile(QString filepath)
{
    outputFilepath = filepath;
    /*std::ofstream fo;
    fo.open(filepath.toStdString().c_str(), std::ios::binary);
    if (fo.is_open()) {
        fo.write(header, 44);
        fo.write( (char*)&rawDataComp[0], rawDataComp.size() * sizeof (short));
        fo.close();
    } else {
        emit fileSaveError();
        qDebug("error save file");
    }*/
}

NoiseDeleter::~NoiseDeleter()
{
    rnnoise_destroy(st);
}
