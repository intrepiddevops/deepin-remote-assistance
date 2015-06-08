
import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

import Deepin.Widgets 1.0

Menu {
    title: "Preferences"
    property alias fullscreenItem: fullscreenItem

    style: Component {
        MenuStyle {
            frame: Component {
                Item {
                    Rectangle {
                        anchors.fill: parent
                        color: "#151515"
                        antialiasing: true
                        //border.width: 2
                        //border.color: 'red'
                        //radius: 4
			            smooth: true
                    }
                }
            }
//                itemDelegate: Component {
//                }
            itemDelegate.background: Component {
                Rectangle {
                    color: styleData.selected ? "#252525" : "#151515"
                }
            }

            itemDelegate.label: Component {
                Text {
                    text: styleData.text
                    font.pixelSize: DConstants.fontSize
                    color: styleData.selected ? DConstants.textHoverColor : DConstants.textNormalColor
                }
            }

            // Replace image indicator with text
            itemDelegate.checkmarkIndicator: Component {
                //Image {
                //    source: (styleData.checkable &&
                //             styleData.checked) ?  "checked.png" : ""
                //    }
                //}
                Text {
                    color: styleData.selected ? "#fafafa" : "#9a9a9a"
                    // check mark
                    //text: styleData.checked ? "\u2713" : ""
                    text: styleData.checked ? (styleData.exclusive ? "\u2022" : "\u2713") : ""
                    font.pixelSize: DConstants.fontSize
                    y: -4
                }
            }
            //scrollIndicator:
            separator: Component {
                Item {
                    Rectangle {
                        anchors.centerIn: parent
                        color: "#212121"
                        height: 1
                        width: parent.width - 10
                        x: 1
                    }
                }
            }
            //submenuOverlap:
            //submenuPopupDelay:
        }
    }

    MenuItem { action: preferSpeed }
    MenuItem { action: preferQuality }
    MenuItem { action: balanced }

    MenuSeparator {}

    MenuItem {
        id: fullscreenItem
        text: "Fullscreen"
        checkable: true
        onToggled: {
            print("Toggle fullscreen")
        }
    }

    ExclusiveGroup {
        id: videoQualityGroup

        Action {
            id: preferSpeed
            text: "Perform Speed"
            checkable: true
            onTriggered: {
                print('speed')
            }
        }

        Action {
            id: balanced
            text: "Balanced"
            checkable: true
            onTriggered: {
                print('balanced')
            }
        }

        Action {
            id: preferQuality
            text: "Perform Quality"
            checkable: true
            onTriggered: {
                print('quality')
            }
        }
    }
}