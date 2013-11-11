

#include "streamtablemodel.h"

StreamTableModel::StreamTableModel(QObject *parent, QQmlEngine * qmlEngine, QSqlDatabase db, int streamId) :
    QLSqlTableModel(parent, qmlEngine, db), m_StreamId(streamId)
{
    setTable("event");
    generateRoleNames();
    setFrom(1381270500, 175400);
//    setFilter(QString("streamid=%1").arg(m_StreamId));
//    select();
}


void StreamTableModel::setFrom(int startTime, int duration )
{
//    setFilter(QString("(streamid=%1) AND (startime > %2)").arg(m_StreamId).arg(startTime) );
    setTable("event");
    generateRoleNames();
    setFilter(QString("(streamid=%1) AND (startime BETWEEN %2 AND %3)").arg(m_StreamId).arg(startTime).arg(startTime + duration) );
    bool ret = select();
    if(!ret){
        qDebug() << "select failed";
    }
}

QDateTime StreamTableModel::toDate(int time)
{
    qint64 timeMs = ((qint64)time * 1000ll);
    return QDateTime::fromMSecsSinceEpoch(timeMs);
}
