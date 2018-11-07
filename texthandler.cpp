#include "texthandler.h"

TextHandler::TextHandler(QObject *parent) : QObject(parent)
{

}

void TextHandler::splitText()
{
    QRegularExpression re("([a-zA-Zа-яА-ЯёЁ]+[0-9]{0,}?[^\\s\\,\\=\\*\\/][a-zA-Zа-яА-ЯёЁ]+[0-9]{0,}|[a-zA-Zа-яА-ЯёЁ]+[0-9]{0,})");
    QRegularExpressionMatchIterator words = re.globalMatch(sourceText);
    m_model.clear();
    while (words.hasNext())
    {
        QRegularExpressionMatch match = words.next();//"['jhhjh']"
        m_model.append(match.captured(1));
    }
    modelChanged();
}

void TextHandler::openTextFromFile(QString filename)
{
    QFile f(filename);
    //qDebug() << "open file txt" << filename;
    if (!f.open(QFile::ReadOnly | QFile::Text))
        return;
    QTextStream in(&f);
    sourceText = in.readAll();
    textChanged();
    f.close();
    splitText();
}
