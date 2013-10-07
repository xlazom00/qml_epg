#include <QtDebug>
#include <QFile>

#include "epgloader.h"

EpgLoader::EpgLoader(QObject *parent) :
    QObject(parent)
{
}


void EpgLoader::loadEpgFile()
{
    qDebug(Q_FUNC_INFO);

    QFile file("../data/epg.data");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return;

    QTextStream in(&file);

    while (!in.atEnd()) {
        QString line = in.readLine();
        process_line(line);
    }
}


void EpgLoader::process_line(const QString & line)
{

    QChar a = line[0];
    switch(a.toLatin1())
    {
    case 'C':
        process_channel(line);
        break;
    case 'E':
        process_event(line);
        break;
    case 'T':
        process_title(line);
        break;
    case 'S':
        process_short_text(line);
        break;
    case 'D':
        process_description(line);
        break;
    case 'G':
        process_genre(line);
        break;
    case 'R':
        process_rating(line);
        break;
    case 'X':
        process_stream_type(line);
        break;
    case 'V':
        process_vps(line);
        break;
    case 'e':
        procces_event_end();
        break;
    case 'c':
        process_channel_end();
        break;
    default:
        Q_ASSERT(false);
    }
}

void EpgLoader::process_title(const QString & line)
{

}

void EpgLoader::process_short_text(const QString & line)
{

}

void EpgLoader::process_description(const QString & line)
{

}

void EpgLoader::process_genre(const QString & line)
{

}

void EpgLoader::process_rating(const QString & line)
{

}

void EpgLoader::process_stream_type(const QString & line)
{

}

void EpgLoader::process_vps(const QString & line)
{

}

void EpgLoader::process_channel(const QString & line)
{
    QStringRef a = line.rightRef(line.length()-2);
    int nextSeparatorIndex = a.indexOf(' ');
    QString channelId(line.mid(2, nextSeparatorIndex-2));
    QString channelName(line.mid( nextSeparatorIndex+1+2, line.length()-(nextSeparatorIndex+2)));

    currentChannel = new Channel(channelId, channelName, this);
}

void EpgLoader::process_channel_end()
{
    currentChannel = NULL;
}

void EpgLoader::process_event(const QString & line)
{
    int startSeparatorIndex = 2;
    int nextSeparatorIndex = line.indexOf(' ', startSeparatorIndex);
    QStringRef id = line.midRef(startSeparatorIndex, nextSeparatorIndex-startSeparatorIndex);
    startSeparatorIndex = nextSeparatorIndex + 1;
    nextSeparatorIndex = line.indexOf(' ', startSeparatorIndex);

    QStringRef startTime = line.midRef( startSeparatorIndex, nextSeparatorIndex - startSeparatorIndex);

    startSeparatorIndex = nextSeparatorIndex + 1;
    nextSeparatorIndex = line.indexOf(' ', startSeparatorIndex);
    QStringRef durationTime = line.midRef( startSeparatorIndex, nextSeparatorIndex - startSeparatorIndex);


    int idAsInt = id.toInt();
    long startTimeAsLong = startTime.toLong();
    int durationAsInt = durationTime.toInt();



}

void EpgLoader::procces_event_end()
{

}



Channel::Channel(const QString & id, const QString & name, QObject *parent) :
    QObject(parent), mId(id), mName(name)
{
}






