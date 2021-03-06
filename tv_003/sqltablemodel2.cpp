#include <QString>
#include <QVariant>
#include <QSqlTableModel>
#include <QSqlRelationalTableModel>
#include <QSqlRecord>
#include <QDebug>
#include <qqmlcontext.h>

#include <private/qqmlengine_p.h>
#include <private/qv8engine_p.h>
#include <private/qv4value_p.h>
#include <private/qv4engine_p.h>
#include <private/qv4object_p.h>

#include "sqltablemodel2.h"

using namespace QV4;
using namespace QtQml;

SqlTableModel2::SqlTableModel2(QObject *parent, QSqlDatabase db )
    : QSqlRelationalTableModel(parent, db)
{
}

int SqlTableModel2::rowCount() const
{
    return QSqlRelationalTableModel::rowCount();
}

QVariant SqlTableModel2::data ( const QModelIndex & index, int role ) const
{
//    qDebug() << index.column() << " " << index.row();
    if(index.row() >= rowCount())
    {
        return QString("");
    }

    if(role < Qt::UserRole)
    {
        QVariant data = QSqlQueryModel::data(index, role);
//        qDebug() << "role:" << role << " " << data;
        return data;
    }
    else {
        // search for relationships
        for (int i = 0; i < columnCount(); i++) {
            if (this->relation(i).isValid()) {
                return record(index.row()).value(QString(roles.value(role)));
            }
        }
        // if no valid relationship was found
        QVariant data = QSqlQueryModel::data(this->index(index.row(), role - Qt::UserRole - 1), Qt::DisplayRole);
//        qDebug() << "role:" << role << " " << data;
        return data;
    }
}

QQmlV4Handle SqlTableModel2::get(int rowIndex) const
{

    // Must be called with a context and handle scope
//    Q_D(const SqlTableModel2);
    // Must be called with a context and handle scope
//    Q_D(const QQuickXmlListModel);

    if (rowIndex < 0 || rowIndex >= rowCount()){
//        qDebug() << "rowCount:" << rowCount();
        return QQmlV4Handle(Encode::undefined());
    }



//    {
//        QObjectPrivate *priv = QObjectPrivate::get(const_cast<QObject *>(this->parent()));

//        QQmlData *data =
//            static_cast<QQmlData *>(priv->declarativeData);

//        if (!data){
//             Q_ASSERT(false);
//        }
//        else if (data->outerContext) {
//            QQmlContext * context =  data->outerContext->asQQmlContext();
//        }
//        else {
//            Q_ASSERT(false);
//        }
//    }

//    QtQml::qmlContext()
//    QQmlContext * context =  qmlContext(this);
//    Q_ASSERT(context != NULL);

    QQmlEngine *engine = qmlContext(this->parent())->engine();
//    QV8Engine *v8engine = QQmlEnginePrivate::getV8Engine(engine);
    QV4::ExecutionEngine *v4engine = QQmlEnginePrivate::getV4Engine(engine);
    QV8Engine *v8engine = QQmlEnginePrivate::getV8Engine(engine);
//    ExecutionEngine *v4engine = QV8Engine::getV4(v8engine);
    Scope scope(v4engine);
    Scoped<Object> o(scope, v4engine->newObject());
//    for (int ii = 0; ii < d->roleObjects.count(); ++ii) {
//        ScopedString name(scope, v4engine->newIdentifier(d->roleObjects[ii]->name()));
//        Property *p = o->insertMember(name, PropertyAttributes());
//        p->value = v8engine->fromVariant(d->data.value(ii).value(index));
//    }

    ScopedString name(scope);
    ScopedValue value(scope);
    QHash<int, QString>::const_iterator it = stringRoles.begin();
    while (it != stringRoles.end()) {
        name = v4engine->newIdentifier(it.value());
//        Property *p = o->insertMember(name, PropertyAttributes());

        int column(it.key() - Qt::UserRole - 1);
        QModelIndex modelIndex(this->index(rowIndex, column));
        QVariant res = data(modelIndex);
//        QVariant data = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
//        qDebug() << "val:" << it.value() << " column:" << column  << " column" << modelIndex.column() << " row:" << modelIndex.row();
//        qDebug() << res;

        value = v8engine->fromVariant(res);
        o->insertMember(name, value);
        ++it;
    }

    return QQmlV4Handle(o);
}


void SqlTableModel2::generateRoleNames()
{
    roles.clear();
    stringRoles.clear();
    int nbCols = this->columnCount();
//    qDebug() << "columns:" << nbCols;
    for (int i = 0; i < nbCols; i++) {
            roles[Qt::UserRole + i + 1] = QVariant(this->headerData(i, Qt::Horizontal).toString()).toByteArray();
            stringRoles[Qt::UserRole + i + 1] = this->headerData(i, Qt::Horizontal).toString();
    }
}
