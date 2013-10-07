#ifndef EPGLOADER_H
#define EPGLOADER_H

#include <QObject>
#include <QTime>

class Channel;
class Event;

class EpgLoader : public QObject
{
    Q_OBJECT
public:
    explicit EpgLoader(QObject *parent = 0);

signals:


public slots:
    void loadEpgFile();

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
    Channel * currentChannel;
    Event * currentEvent;
};


class Channel : public QObject
{
    Q_OBJECT
public:
    explicit Channel(const QString & id, const QString & name, QObject *parent = 0);

private:
    QString mId;
    QString mName;
};


class Event : public QObject
{
    Q_OBJECT
public:
    explicit Event(const quint32 id, const QTime & name, QObject *parent = 0);

private:
    quint32 mId;
    QTime mStartTime;
    QTime mDuration;

    QString mTitle;
    QString mShortText;
    QString mDescription;
};



#endif // EPGLOADER_H
