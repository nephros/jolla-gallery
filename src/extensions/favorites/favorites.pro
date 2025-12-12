# SPDX-FileCopyrightText: 2019 - 2023 Jolla Ltd.
# SPDX-FileCopyrightText: 2024 - 2025 Jolla Mobile Ltd
#
# SPDX-License-Identifier: BSD-3-Clause

TEMPLATE = lib
TARGET = jollagalleryfavoritesplugin
TARGET = $$qtLibraryTarget($$TARGET)

MODULENAME = com/jolla/gallery/favorites
TARGETPATH = $$[QT_INSTALL_QML]/$$MODULENAME

QT += qml
CONFIG += plugin link_pkgconfig

include($$PWD/../../../common.pri)

TS_FILE = $$OUT_PWD/gallery-extension-favorites.ts
EE_QM = $$OUT_PWD/gallery-extension-favorites.qm

ts.commands += lupdate $$PWD -ts $$TS_FILE
ts.CONFIG += no_check_exist no_link
ts.output = $$TS_FILE
ts.input = .

ts_install.files = $$TS_FILE
ts_install.path = /usr/share/translations/source
ts_install.CONFIG += no_check_exist

# should add -markuntranslated "-" when proper translations are in place (or for testing)
engineering_english.commands += lrelease -idbased $$TS_FILE -qm $$EE_QM
engineering_english.CONFIG += no_check_exist no_link
engineering_english.depends = ts
engineering_english.input = $$TS_FILE
engineering_english.output = $$EE_QM

engineering_english_install.path = /usr/share/translations
engineering_english_install.files = $$EE_QM
engineering_english_install.CONFIG += no_check_exist

QMAKE_EXTRA_TARGETS += ts engineering_english

PRE_TARGETDEPS += ts engineering_english

INSTALLS += ts_install engineering_english_install


import.files = \
    favorites/FavoriteAlbumDelegate.qml \
    favorites/FavoriteAlbumsPage.qml \
    favorites/FavoriteGalleryIcon.qml \
    favorites/FavoriteSlideshowIcon.qml \
    favorites/FavoriteSourcePage.qml \
    favorites/qmldir

import.path = $$TARGETPATH
target.path = $$TARGETPATH

qml.files = mediasources/FavoritePhotoSource.qml
qml.path = /usr/share/jolla-gallery/mediasources/

SOURCES += \
    plugin/plugin.cpp

OTHER_FILES += $$import.files $$qml.files

INSTALLS += target import qml
