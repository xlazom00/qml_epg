#ifndef EPGLOADER_H
#define EPGLOADER_H

#include <QObject>
#include <QTime>
#include <QSharedPointer>
#include <QSqlDatabase>


class Event
{
public:
    explicit Event(const quint32 id, long startTime, long durationTime);

public:
    void Title(const QStringRef & text);
    void ShortText(const QStringRef & text);
    void Description(const QStringRef & text);

private:
    quint32 m_Id;
    long m_startTime; // as time_t
    int m_Duration; //in sec

    QString m_Title;
    QString m_ShortText;
    QString m_Description;
};

typedef QSharedPointer<Event> SEvent;

class Channel
{
public:
    explicit Channel(const QString & id, const QString & name);

public:
    void AddEvent(SEvent & event);

private:
    QString mId;
    QString mName;

    QList<SEvent> m_EventList;

};

typedef QSharedPointer<Channel> SChannel;


class EpgLoader : public QObject
{
    Q_OBJECT
public:
    explicit EpgLoader(QObject *parent = 0);

signals:


public slots:
    void loadEpgFile();

private:
    // DB
    void createTables();
    bool openDB(QSqlDatabase & db);
    void closeDB(QSqlDatabase & db);

private:
    void process_line(const QString & line);
    void process_channel(const QString & line);
    void process_channel_end();

    void process_event(const QString & line);
    void procces_event_end();

    void process_title(const QString & line);
    void process_short_text(const QString & line);
    void process_description(const QString & line);
    void process_genre(const QString & line);
    void process_rating(const QString & line);
    void process_stream_type(const QString & line);
    void process_vps(const QString & line);

private:
    SChannel currentChannel;
    SEvent currentEvent;

    QList<SChannel> m_ChannelList;

    QSqlDatabase db;
};






#endif // EPGLOADER_H
