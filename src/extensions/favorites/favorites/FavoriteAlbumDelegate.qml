// SPDX-FileCopyrightText: 2013-2018 Jolla Ltd.
// SPDX-FileCopyrightText: 2025 Jolla Mobile Ltd
// SPDX-FILECopyrightText: 2025 Peter G. <sailfish@nephros.org>
//
// SPDX-License-Identifier: BSD-3-Clause

import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.gallery 1.0

BackgroundItem { id: root

    property string albumName
    property alias imagesModel: image.model
    property alias serviceIcon: image.serviceIcon

    enabled: imagesModel.count > 0
    opacity: enabled ? 1.0 : 0.6

    FavoriteSlideshowIcon {
        id: image
        model: root.imagesModel
        highlighted: root.highlighted
    }

    Column {
        anchors {
            left: image.right
            leftMargin: Theme.paddingLarge
            right: parent.right
            rightMargin: Theme.paddingMedium
            verticalCenter: image.verticalCenter
        }

        Label {
            width: parent.width
            text: albumName
            font.family: Theme.fontFamilyHeading
            font.pixelSize: Theme.fontSizeMedium
            color: highlighted ? Theme.highlightColor : Theme.primaryColor
            truncationMode: TruncationMode.Fade
        }

        Label {
            width: parent.width

            //% "%Ln Pictures"
            text: qsTrId("gallery-extension-favorites_piccount", imagesModel.count)
            font.family: Theme.fontFamilyHeading
            font.pixelSize: Theme.fontSizeSmall
            color: highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
            truncationMode: TruncationMode.Fade
        }
    }
}

// vim: ft=javascript ts=4 st=4 sw=4 expandtab
