#ifndef QLSQLTABLEMODEL_H
#define QLSQLTABLEMODEL_H

#include <QSqlRelationalTableModel>
#include <QHash>
#include <QModelIndex>

class QLSqlTableModel : public QSqlRelationalTableModel
{
    Q_OBJECT
  private:
      QHash<int, QByteArray> roles;

  public:
      QLSqlTableModel(QObject *parent = 0, QSqlDatabase db = QSqlDatabase());
      Q_INVOKABLE QVariant data(const QModelIndex &index, int role=Qt::DisplayRole ) const;
      Q_INVOKABLE int rowCount() const;
      void generateRoleNames();
      Q_INVOKABLE void setFilter(const QString &filter);
//  #ifdef HAVE_QT5
     virtual QHash<int, QByteArray> roleNames() const{return roles;}
//  #endif
};

#endif // QLSQLTABLEMODEL_H
