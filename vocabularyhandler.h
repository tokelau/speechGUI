#ifndef VOCABULARYHANDLER_H
#define VOCABULARYHANDLER_H

#include <QObject>
#include <QFile>
#include <QDebug>
#include <QRegularExpression>

class VocabularyHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList model MEMBER m_words NOTIFY modelChanged)
public:
    explicit VocabularyHandler(QObject *parent = nullptr);

signals:
    void modelChanged();

public slots:
    void deleteWords(const QList<QString>& indexes);
    void search(const QString& word);
    void saveWord(const QString& word);
    void editWord(const QString& oldWord, const QString& word);

private:
    QStringList m_words;
    QStringList tmp_words;
    int searchStrLengtOld;
    //QFile vocabulary;
};

#endif // VOCABULARYHANDLER_H
