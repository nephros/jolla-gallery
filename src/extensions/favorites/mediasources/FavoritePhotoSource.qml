// SPDX-FileCopyrightText: 2013-2018 Jolla Ltd.
// SPDX-FileCopyrightText: 2025 Jolla Mobile Ltd
// SPDX-FILECopyrightText: 2025 Peter G. <sailfish@nephros.org>
//
// SPDX-License-Identifier: BSD-3-Clause

import QtQuick 2.6
import Sailfish.Silica 1.0
import Sailfish.Gallery 1.0
import com.jolla.gallery 1.0
import Nemo.Configuration 1.0
import Nemo.FileManager 1.0

MediaSource {
    id: root

    //% "Favorites"
    title: qsTrId("gallery-bt-favorites")
    icon: StandardPaths.resolveImport("com.jolla.gallery.favorites.FavoriteGalleryIcon")
    model: sourceModel
    count: sourceModel.count
    ready: sourceModel.count > 0
    page: StandardPaths.resolveImport("com.jolla.gallery.favorites.FavoriteAlbumsPage")

    /*! \internal */
    property bool applicationActive: Qt.application.active

    // FIXME: add Videos
    type: MediaSource.Photos
    /*! ListModel propulated from parising the photoSources key */
    property ListModel sourceModel: ListModel{}

    /* DConf location holding the user-specified media source path.
        Format is a JSON string representing an array of objects.
    */
    property ConfigurationValue photoSources: ConfigurationValue {
        key: "/apps/jolla-gallery/favoritepaths/pictures"
        defaultValue: JSON.stringify([
                {
                    "displayName": "EMail",
                    "path": "Downloads/mail_attachments"
                },
                {
                    "displayName": "Album Art",
                    "path": "Music"
                },
                {
                    "displayName": "Downloaded",
                    "path": "Downloads"
                },
        ])
    }
    Component.onCompleted: {
        var sources
        try {
            sources = JSON.parse(photoSources.value)
        } catch (e) {
            console.warn("Could not parse favorite values:", photoSources.value )
            return
        }
        if (sources.length > 0) {
            sources.forEach(function(e) {
                if (FileEngine.exists(StandardPaths.home + "/" + e.path)) {
                    console.info("Appending to source model:",  e.path)
                    sourceModel.append(e)
                } else if (/^\/run\/media\/[^\/]+/.test(e.path) && (FileEngine.exists(e.path))) {
                    console.info("Media path detected:",  e.path)
                    sourceModel.append(e)
                } else {
                    console.warn("Specified path does not exist or is not a media path, not appending.")
                }
            })
        } else {
            console.info("No paths in favorite key")
        }
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
