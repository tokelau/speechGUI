QT += quick
QT += core
QT += quickcontrols2

CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    rnnoise/celt_lpc.c \
    rnnoise/denoise.c \
    rnnoise/kiss_fft.c \
    rnnoise/pitch.c \
    rnnoise/rnn.c \
    rnnoise/rnn_data.c \
    noisedeleter.cpp \
    texthandler.cpp \
    vocabularyhandler.cpp \
    main.cpp \
    media.cpp

RESOURCES += \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = ./fluid

qtConfig(static) {

    QTPLUGIN += \
        qsvg \
        fluidcoreplugin \
        fluidcontrolsplugin \
        fluidcontrolsprivateplugin \
        fluidtemplatesplugin
}

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = ./fluid

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    rnnoise/_kiss_fft_guts.h \
    rnnoise/arch.h \
    rnnoise/celt_lpc.h \
    rnnoise/common.h \
    rnnoise/kiss_fft.h \
    rnnoise/opus_types.h \
    rnnoise/pitch.h \
    rnnoise/rnn.h \
    rnnoise/rnn_data.h \
    rnnoise/rnnoise.h \
    rnnoise/tansig_table.h \
    noisedeleter.h \
    texthandler.h \
    vocabularyhandler.h \
    media.h
