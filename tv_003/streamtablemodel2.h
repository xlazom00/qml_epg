#ifndef STREAMTABLEMODEL2_H
#define STREAMTABLEMODEL2_H


#include <QObject>
#include <QSqlDatabase>
#include <QDateTime>

#include "sqltablemodel2.h"

class StreamTableModel2 : public SqlTableModel2
{
    Q_OBJECT
public:
    explicit StreamTableModel2(QObject *parent, QSqlDatabase db, int streamId);
    StreamTableModel2(QObject *parent = 0,  QSqlDatabase db = QSqlDatabase());

    Q_INVOKABLE void setFrom(int startTime, int duration );

    Q_INVOKABLE QDateTime toDate(int time);

signals:

public slots:

private:
    int m_StreamId;

};

#endif // STREAMTABLEMODEL2_H
