#include "sqlquerymodel.h"

#include <QHash>
#include <QByteArray>
#include <QSqlRecord>
#include <QString>
#include <QDebug>


//SqlQueryModel::SqlQueryModel(QObject *parent)
//    :QSqlQueryModel(parent)
//{
//}

//void SqlQueryModel::setQuery(const QString &query, const QSqlDatabase &db)
//{
//    QSqlQueryModel::setQuery(query,db);
//    generateRoleNames();
//}

//void SqlQueryModel::setQuery(const QSqlQuery & query)
//{
//    QSqlQueryModel::setQuery(query);
//    generateRoleNames();
//}

//void SqlQueryModel::generateRoleNames()
//{
//    QHash<int, QByteArray> roleNames;
//    for( int i = 0; i < record().count(); i++) {
//        roleNames[Qt::UserRole + i + 1] = record().fieldName(i).toUtf8();
//    }
////    setRoleNames(roleNames);
//}

//QVariant SqlQueryModel::data(const QModelIndex &index, int role) const
//{
//    QVariant value = QSqlQueryModel::data(index, role);
//    qDebug() << value;
//    if(role < Qt::UserRole)
//    {
//        value = QSqlQueryModel::data(index, role);
//        qDebug() << value;
//    }
//    else
//    {
//        int columnIdx = role - Qt::UserRole - 1;
//        QModelIndex modelIndex = this->index(index.row(), columnIdx);
//        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
//        qDebug() << "columnIdx" << columnIdx << value;
//    }
//    return value;
//}

