# Add more folders to ship with the application, here
folder_01.source = qml/tv_003
folder_01.target = qml

folder_02.source = data
folder_02.target =

DEPLOYMENTFOLDERS = folder_01 folder_02

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

QT += sql qml-private  core-private

CONFIG+=qml_debug

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    qlsqltablemodel.cpp \
    tvstream.cpp \
    streamtablemodel.cpp \
    epgdatabase.cpp \
    sqltablemodel2.cpp \
    streamtablemodel2.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qml/tv_003/Channel.qml \
    TODO.txt

HEADERS += \
    qlsqltablemodel.h \
    tvstream.h \
    streamtablemodel.h \
    epgdatabase.h \
    sqltablemodel2.h \
    streamtablemodel2.h
