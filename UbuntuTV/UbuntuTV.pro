# Add more folders to ship with the application, here
folder_01.source = qml/UbuntuTV
folder_01.target = qml

folder_02.source = qml/common
folder_02.target = qml

folder_03.source = qml/UbuntuTV/epgdata
folder_03.target = epgdata

DEPLOYMENTFOLDERS = folder_01 folder_02

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=
QT += declarative

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    directorymodel.cpp \
    person.cpp \
    birthdayparty.cpp

HEADERS += \
    directorymodel.h \
    person.h \
    birthdayparty.h

#LIBS += -l$$quote("C:/Program Files (x86)/Microsoft SDKs/Windows/v7.1A/Lib/Gdi32")
#LIBS += -l"C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Lib\Gdi32"
# Installation path
# target.path =

#INSTALLS += target

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qml/common/fontUtils.js \
    qml/common/jsonpath.js \
    qml/common/units.js \
    qml/common/utils.js \
    qml/common/AbstractButton.qml \
    qml/common/AbstractExpandingDropDown.qml \
    qml/common/AbstractScrollbar.qml \
    qml/common/AlwaysVisibleBehavior.qml \
    qml/common/Background.qml \
    qml/common/BaseBehavior.qml \
    qml/common/ColorizeEffect.qml \
    qml/common/DropShadowEffect.qml \
    qml/common/GlowButton.qml \
    qml/common/GlowEffect.qml \
    qml/common/GridSwitcher.qml \
    qml/common/IconTile.qml \
    qml/common/ImmediateHideBehavior.qml \
    qml/common/JSONListModel.qml \
    qml/common/Marquee.qml \
    qml/common/Panel.qml \
    qml/common/PictureGlowButton.qml \
    qml/common/PlayGlowButton.qml \
    qml/common/SearchEntry.qml \
    qml/common/TextCustom.qml \
    qml/common/TextMultiLine.qml \
    qml/common/TimeoutBehavior.qml \
    qml/common/VideoInfo.qml \
    qml/common/VideoPreviewExtraText.qml \
    qml/common/VisibilityController.qml


