#ifndef TEXTHANDLER_H
#define TEXTHANDLER_H

#include <QObject>
#include <QString>
#include <QStringList>
#include <QRegularExpression>
#include <QDebug>
#include <fstream>
#include <QFile>

class TextHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList model MEMBER m_model NOTIFY modelChanged)
    Q_PROPERTY(QString source_text MEMBER sourceText NOTIFY textChanged)

public:
    TextHandler(QObject *parent = nullptr);


public slots:
    void openTextFromFile(QString filename);

signals:
    void textChanged();
    void modelChanged();

private:
    void splitText();

    QStringList m_model;
    QString sourceText;
};

#endif // TEXTHANDLER_H
