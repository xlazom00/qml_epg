#ifndef EPGDATABASE_H
#define EPGDATABASE_H

#include <QSqlDatabase>
#include <QObject>

class QSqlRelationalTableModel;
class StreamTableModel2;

class EPGDatabase : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString file READ file WRITE setFile NOTIFY fileChanged)
public:
    explicit EPGDatabase(QObject *parent = 0);
    ~EPGDatabase();

    Q_INVOKABLE int streamCount();
    Q_INVOKABLE StreamTableModel2 * createStream(int id);

public:
    void setFile(const QString & file);
    QString file() const;

signals:
    void fileChanged();

public slots:

private:
    bool CreateStreamModel();
    bool OpenDB();
    void setDatabasName();

private:
    QString m_FileName;
    QSqlDatabase m_Db;
    QSqlRelationalTableModel * m_StreamModel;
};

#endif // EPGDATABASE_H
