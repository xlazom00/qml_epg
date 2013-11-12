#include "epgdatabase.h"

#include <QSqlRelationalTableModel>

#include "streamtablemodel2.h"



#include <qqmlcontext.h>

#include <private/qqmlengine_p.h>
#include <private/qv8engine_p.h>
#include <private/qv4value_p.h>
#include <private/qv4engine_p.h>
#include <private/qv4object_p.h>


EPGDatabase::EPGDatabase(QObject *parent) :
    QObject(parent), m_StreamModel(NULL)
{
    m_Db = QSqlDatabase::addDatabase("QSQLITE");
}

int EPGDatabase::streamCount()
{
    if(!OpenDB())
    {
        return 0;
    }

    if(!CreateStreamModel())
    {
        return 0;
    }

    return m_StreamModel->rowCount();
}

bool EPGDatabase::OpenDB()
{
    bool ok = true;
    if(!m_Db.isOpen())
    {
        ok = m_Db.open();
    }

    if(m_Db.isOpenError())
    {
        return false;
    }
    return ok;
}

bool EPGDatabase::CreateStreamModel()
{
    bool ret = true;
    if(m_StreamModel == NULL)
    {
        m_StreamModel = new QSqlRelationalTableModel(this, m_Db);
        m_StreamModel->setTable("stream");
        ret = m_StreamModel->select();
    }
    return ret;
}

StreamTableModel2 * EPGDatabase::createStream(int id)
{
    if(!OpenDB())
    {
        return NULL;
    }

    if(!CreateStreamModel())
    {
        return NULL;
    }

    if(m_StreamModel->rowCount() < id)
    {
        return NULL;
    }

    QVariant data = m_StreamModel->data(m_StreamModel->index(id,0));
    QVariant name = m_StreamModel->data(m_StreamModel->index(id,1));

    StreamTableModel2 *  streamModel = new StreamTableModel2(this, m_Db, data.toInt());
    return streamModel;
}


EPGDatabase::~EPGDatabase()
{
    m_Db.close();
}

void EPGDatabase::setFile(const QString & file)
{
    if (file != m_FileName) {
        m_FileName = file;

        setDatabasName();
        emit fileChanged();
    }
}

QString EPGDatabase::file() const
{
    return m_FileName;
}

void EPGDatabase::setDatabasName()
{
    if(m_Db.isOpen()){
        m_Db.close();
    }
    m_Db.setDatabaseName(m_FileName);
}
