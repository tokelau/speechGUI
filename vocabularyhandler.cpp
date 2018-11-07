#include "vocabularyhandler.h"

VocabularyHandler::VocabularyHandler(QObject *parent) : QObject(parent),
    searchStrLengtOld(0)
{

    //Тут нужно вставить полный путь до словаря, можно его формировать с помощью инструментов в QT я просто еще не сделал это(
    QFile vocabulary("C:/Users/Pavel/Documents/build-text_analyser_-Desktop_Qt_5_11_1_MSVC2017_64bit-Release/release/assets/dicts/vocabulary.dict");
    if (!vocabulary.open(QFile::ReadOnly | QFile::Text)) {
        qDebug() << "Не удается открыть словарь";
        return;
    }

    QRegularExpression re("([a-zA-Zа-яА-Я0-9ё]+-[a-zA-Zа-яА-Я0-9ё]+|[a-zA-Zа-яА-Я0-9ё]+)");
    QRegularExpressionMatchIterator words = re.globalMatch(vocabulary.readAll());
    m_words.clear();

    while (words.hasNext())
    {
        QRegularExpressionMatch match = words.next();
        m_words.append(match.captured(1));
    }
    modelChanged();
}

void VocabularyHandler::saveWord(const QString& word) {
    m_words.append(word);
    modelChanged();
}

void VocabularyHandler::deleteWords(const QList<QString>& indexes) {
    qDebug() << "deleteWords called" << indexes;
    for (auto it = indexes.begin(); it != indexes.end(); it++) {
        m_words.removeAt(m_words.indexOf(*it));
    }
    modelChanged();
}

void VocabularyHandler::search(const QString& search_str) {
    if (search_str.length()) {
        if (tmp_words.empty()) {
            tmp_words = m_words;
        }
        m_words = QStringList();
        for(auto it = tmp_words.begin(); it != tmp_words.end(); ++it) {
            if (*it == search_str) {
                m_words.append(*it);
            }
        }
        modelChanged();
    } else {
        m_words = tmp_words;
        tmp_words.clear();
        modelChanged();
    }
}

void VocabularyHandler::editWord(const QString& oldWord, const QString& word){
    m_words.removeAt(m_words.indexOf(oldWord));
    m_words.append(word);
    modelChanged();
}
