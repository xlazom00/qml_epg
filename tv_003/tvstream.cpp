#include "tvstream.h"

#include "qlsqltablemodel.h"

TvStream::TvStream(QObject *parent)
    : QObject(parent)
{
}

TvStream::TvStream(const QString & name, QLSqlTableModel * streamModel, QObject *parent) :
    QObject(parent), m_StreamModel(streamModel), m_Name(name)
{
}

TvStream::~TvStream()
{
    delete m_StreamModel;
}

QLSqlTableModel * TvStream::streammodel() const
{
    return m_StreamModel;
//    return QVariant::fromValue(m_StreamModel);
}

QString TvStream::name() const
{
    return m_Name;
}

void TvStream::setName(const QString &name)
{
    if (name != m_Name) {
        m_Name = name;
        emit nameChanged();
    }
}


//void TvStream::setStreammodel(QLSqlTableModel * model)
//{
////    if (model != m_StreamModel) {
////        m_StreamModel = (QLSqlTableModel * )model;
////        emit streammodelChanged();
////    }
//}
