import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Biblioteka")

    Item {
         height: 450
         width: 350
         ListModel {
            id: users
            ListElement {
                group: "Фантастика"
                path: "qrc:/icon/book/1.png"   // путь к иконке-обложке книги
                name: "Темная Башня"           // название
                autor: "С.Кинг"                // автор
            }
            ListElement {
                group: "Фантастика"
                path: "qrc:/icon/book/3.png"
                name: "Хроники Амбера"
                autor: "Р.Желязны"
            }
            ListElement {
                group: "Детективы"
                path: "qrc:/icon/book/2.png"
                name: "Темная Башня"
                autor: "С.Кинг"
            }
            ListElement {
                group: "Детективы"
                path: "qrc:/icon/book/4.png"
                name: "Эркюль Пуаро. Коробка конфет"
                autor: "А.Кристи"
            }
         }

         ListView {
            id: list
            anchors.fill: parent
            model: users
            spacing: 1

             // Хэдер
            header: Rectangle {
                 width: parent.width
                 height: 30
                 color: "yellow"
                 Text {
                    anchors.centerIn: parent
                    text: "Библиотека имени Ю.Л. Пупкина г.Сопливар"
                    color: "green"
                 }
            }
             // Футер
            footer: Rectangle {
                width: parent.width
                height: 30
                color: "red"
                Text {
                    anchors.centerIn: parent
                    text: "(c) ArhiceSoft"
                    color: "blue"
                }
            }

            // Секции по группам пользователей
            section.delegate: Rectangle {
                width: parent.width
                height: 25
                color: "lightblue"
                Text {
                    anchors.centerIn: parent
                    text: section
                    color: "darkblue"
                    font.weight: Font.Bold
                }
            }

            section.property: "group"
            // Сами элементы
            delegate: Rectangle {
                width: list.width
                height: 50
                radius: 3
                border.width: 1
                border.color: "darkgray"
                color: "lightgray"
                MouseArea {
                    anchors.fill: parent
                    onDoubleClicked: {
                        list.model.remove(index)
                    }
                }
                Column {
                anchors.fill: parent
                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text { text: "Название:"; font.weight: Font.Bold}
                        Text { text: name }
                        spacing: 20
                    }
                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text { text: "Автор:"; font.weight: Font.Bold}
                        Text { text: autor }
                        spacing: 20
                    }
                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text { text: "Место:"; font.weight: Font.Bold}
                        Text { text: path }
                        spacing: 20
                    }
                } //Column
            } // Rectangle

            focus: true
            // Анимация появления элементов модели
            populate: Transition {
                NumberAnimation { properties: "x,y"; duration: 1500; easing.type: Easing.OutExpo}
            }
            // Анимация добавления элементов
            add: Transition {
                  NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
                NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 100 }
             }
              // Удаление элемента
             remove: Transition {
                PropertyAnimation{ property: "opacity"; to: 0; duration: 1000}
             }
            // Вставка дефолтного пользователя при нажатии на пробел
            Keys.onSpacePressed: model.insert(1, { group: "Жанр",
                                            name: "Название", autor: "Автор",
                                            path: "qrc:/icon/book/icon.png"})
            } // ListView
    } // Item

}
