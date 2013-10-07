#include <QtDebug>
#include <QFile>
#include <QSqlQuery>
#include <QSqlError>


#include "epgloader.h"

EpgLoader::EpgLoader(QObject *parent) :
    QObject(parent)
{
}

void EpgLoader::createTables()
{
    QSqlQuery query(m_Db);
    bool ok;
    ok = query.exec("create table stream (id INTEGER primary key, "
               "name TEXT)");
    qDebug() << ok;
    ok = query.exec("create table event (id INTEGER primary key, "
               "startime int, "
               "duration int, "
               "title TEXT, "
               "shorttext TEXT, "
               "description TEXT, "
               "streamid INTEGER, "
               "FOREIGN KEY(streamid) REFERENCES stream(id))"
               );
    qDebug() << ok;
    if(!ok)
    {
        qDebug() << query.lastError().text();
    }

}

bool EpgLoader::openDB(QSqlDatabase & db)
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("app.sqlite");
    // Open databasee
    return db.open();
}

void EpgLoader::closeDB(QSqlDatabase & db)
{
    db.close();
}

void EpgLoader::loadEpgFile()
{
    qDebug(Q_FUNC_INFO);

    if(!openDB(m_Db))
    {
        return;
    }
//    createTables();
//    closeDB(db);
//    return;

    QFile file("../data/epg.data");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        closeDB(m_Db);
        return;
    }

    QTextStream in(&file);
    in.setCodec("UTF-8");

    while (!in.atEnd()) {
        QString line = in.readLine();
        process_line(line);
    }

    file.close();

    closeDB(m_Db);
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
    QStringRef title = line.rightRef(line.length()-2);
    currentEvent->Title(title);
}

void EpgLoader::process_short_text(const QString & line)
{
    QStringRef shortText = line.rightRef(line.length()-2);
    currentEvent->ShortText(shortText);
}

void EpgLoader::process_description(const QString & line)
{
    QStringRef processDescription = line.rightRef(line.length()-2);
    currentEvent->Description(processDescription);
}

void EpgLoader::process_genre(const QString & /*line*/)
{

}

void EpgLoader::process_rating(const QString & /*line*/)
{

}

void EpgLoader::process_stream_type(const QString & /*line*/)
{

}

void EpgLoader::process_vps(const QString & /*line*/)
{

}

void EpgLoader::process_channel(const QString & line)
{
    QStringRef a = line.rightRef(line.length()-2);
    int nextSeparatorIndex = a.indexOf(' ');
    QString channelId(line.mid(2, nextSeparatorIndex-2));
    QString channelName(line.mid( nextSeparatorIndex+1+2, line.length()-(nextSeparatorIndex+2)));

    currentChannel = SChannel(new Channel(channelId, channelName));
    m_ChannelList.append(currentChannel);
    currentChannel->InsertToDB(m_Db);
}

void EpgLoader::process_channel_end()
{
    currentChannel.clear();
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

    currentEvent = SEvent(new Event(idAsInt, startTimeAsLong, durationAsInt));

    currentChannel->AddEvent(currentEvent);
}

void EpgLoader::procces_event_end()
{
    currentEvent->InsertToDB(m_Db, currentChannel->GetSqlId());
}


Channel::Channel(const QString & id, const QString & name) :
    m_Id(id), m_Name(name)
{
}

void Channel::AddEvent(SEvent & event)
{
    m_EventList.append(event);
}

void Channel::InsertToDB(QSqlDatabase & db)
{
    QSqlQuery query(db);
    bool ok;
    // INSERT INTO stream(name) VALUES("PRIMA")
    query.prepare("INSERT INTO stream(name) VALUES(:name)");
    query.bindValue(":name", m_Name);
    ok = query.exec();
//    qDebug() << ok;
    if(!ok)
    {
        qDebug() << query.lastError().text();
    }
    else
    {
        m_SQLid = query.lastInsertId().Int;
    }
}



Event::Event(const quint32 id, long startTime, long durationTime) :
    m_Id(id), m_startTime(startTime), m_Duration(durationTime)
{

}

void Event::Title(const QStringRef & text)
{
    m_Title = text.toString();
}

void Event::ShortText(const QStringRef & text)
{
    m_ShortText = text.toString();
}

void Event::Description(const QStringRef & text)
{
    m_Description = text.toString();
}

void Event::InsertToDB(QSqlDatabase & db, int streamId)
{
//    ok = query.exec("create table event (id INTEGER primary key, "
//               "startime int, "
//               "duration int, "
//               "title TEXT, "
//               "shorttext TEXT, "
//               "description TEXT, "
//               "streamid INTEGER, "
//               "FOREIGN KEY(streamid) REFERENCES stream(id))"
//               );

    QSqlQuery query(db);
    bool ok;
    query.prepare("INSERT INTO event(startime, duration, title, shorttext, description, streamid) VALUES(:startime, :duration, :title, :shorttext, :description, :streamid)");
    query.bindValue(":startime", m_startTime);
    query.bindValue(":duration", m_Duration);
    query.bindValue(":title", m_Title);
    query.bindValue(":shorttext", m_ShortText);
    query.bindValue(":description", m_Description);
    query.bindValue(":streamid", streamId);
    ok = query.exec();
//    qDebug() << ok;
    if(!ok)
    {
        qDebug() << query.lastError().text();
    }
    else
    {
//        m_SQLid = query.lastInsertId().Int;
    }
}






