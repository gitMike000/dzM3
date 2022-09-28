import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: loginForm
    width: 800
    height: 400
    //visible: false
    signal signalExitLogin
    signal started
    color: "#e5ecef"

    property string showFormStateName: "showForm"
    property string hideFormStateName: "hideForm"
    property string notLoginStateName: "notLogin"

    property string login: "login"
    property string password: "password"

   // Javascript-функция для проверки данных
    function checkCredentials() {
        if (login === loginTextField.text
         && password === passwordTextField.text)
        {
            console.log("Удачный вход");
            loginForm.state = hideFormStateName
        }
        else {
            console.log("Неудачный вход");
            //failAnimation.start();
            loginForm.state = notLoginStateName;
        }
    }

    Component.onCompleted: loginForm.started()

    states: [
        State {
            name: showFormStateName
            PropertyChanges { target: secondaryFrame; opacity:1;}
            PropertyChanges { target: submitButton; opacity:1;}
            PropertyChanges { target: passwordTextField; opacity:1;}
            PropertyChanges { target: loginTextField; opacity:1;}
        },
        State {
            name: hideFormStateName
            PropertyChanges { target: loginTextField; opacity:0;}
            PropertyChanges { target: passwordTextField; opacity:0;}
            PropertyChanges { target: submitButton; opacity:0;}
            PropertyChanges { target: secondaryFrame; opacity:0;}
            PropertyChanges { target: loginForm; opacity: 0 }
            onCompleted: loginForm.signalExitLogin()
        },
        State {
            name: notLoginStateName
            PropertyChanges {target: secondaryFrame;}
            PropertyChanges {target: loginTextField;}
            PropertyChanges {target: passwordTextField;}
            onCompleted: loginForm.state = showFormStateName;
        }

    ]

    transitions: [
        Transition {
          to: showFormStateName
           SequentialAnimation {
               PropertyAnimation {
                   target: secondaryFrame
                   property: "opacity"
                   from: 0
                   to: 1
                   duration: 600
               }
               PropertyAnimation {
                  targets: [loginTextField, passwordTextField, submitButton]
                  property: "opacity"
                  from: 0
                  to: 1
                  duration: 400
               }
           }
        },

        Transition {
            to: hideFormStateName
            SequentialAnimation {
          // id: successAnimation
               PropertyAnimation {
                   targets: [loginTextField, passwordTextField, submitButton]
                   property: "opacity"
                   to: 0
                   duration: 400
                }
                PropertyAnimation {
                    target: secondaryFrame
                    property: "opacity"
                    to: 0
                    duration: 600
                }
                PropertyAnimation {
                    target: loginForm
                    property: "opacity"
                    to: 0
                    duration: 100
                }
            }
        },

        Transition {
            to: notLoginStateName
            ParallelAnimation {
                SequentialAnimation {
                // Группа анимаций внутри SequentialAnimation будет выполнена
                //последовательно
                    PropertyAnimation {
                        // Текст внутри полей логина и пароля моментально изменит цвет на
                        //темно-красный
                        targets: [loginTextField, passwordTextField]
                        property: "color"
                        to: "dark red"
                        duration: 0
                    }
                    PropertyAnimation {
                    // После этого за 400 миллисекунд вернется к обычному цвету
                        targets: [loginTextField, passwordTextField]
                        property: "color"
                        to: secondaryFrame.textColor
                        duration: 400
                    }
                }
                SequentialAnimation {
                    // Подложка secondaryFrame сместится на -5 пикселей относительно
                    //центра, затем передвинется на позицию +5, а потом вернётся в исходное положение.
                    //Произойдет “потрясывание” формы.
                    NumberAnimation { target: secondaryFrame; property:
                    "anchors.horizontalCenterOffset"; to: -5; duration: 50 }
                    NumberAnimation { target: secondaryFrame; property:
                    "anchors.horizontalCenterOffset"; to: 5; duration: 100 }
                    NumberAnimation { target: secondaryFrame; property:
                    "anchors.horizontalCenterOffset"; to: 0; duration: 50 }
                }
            }
        }
    ]

    Rectangle {
        id: secondaryFrame
        color: "white"
        anchors.centerIn: parent    // Размещение компонента внутри родительского
        radius: 5   // Закругление углов с выбранным радиусом
        width: 300
        height: 250
        property string textColor: "#535353" // Вынесение общих данных для дочерних элементов в переменную        

         Column { // аналог QVBoxLayout
             anchors.fill: parent // объект занимает все пространство родителя
             padding: 32 // отступы по 4 сторонам от родительского элемента
             spacing: 32 // отступы между элементами
             TextField {
                 id: loginTextField
                 opacity: 0
                 anchors.horizontalCenter: parent.horizontalCenter // размещение по центру оси OX колонки
                 placeholderText: qsTr("Логин")
                 color: secondaryFrame.textColor // цвет текста (переменная объявлена выше)
                 // onEnterPressed и onReturnPressed – две кнопки Enter на стандартной клавиатуре
                 Keys.onEnterPressed: checkCredentials()
                 Keys.onReturnPressed: checkCredentials()
             }
             TextField {
                 id: passwordTextField
                 opacity: 0
                 echoMode: TextInput.Password // звездочки вместо пароля
                 anchors.horizontalCenter: parent.horizontalCenter
                 placeholderText: qsTr("Пароль")
                 color: secondaryFrame.textColor

                 Keys.onEnterPressed: checkCredentials()
                 Keys.onReturnPressed: checkCredentials()
             }

             Button {
                 id: submitButton
                 width: 200
                 height: 40
                 opacity: 0
                 background: Rectangle {
                         color: parent.down ? "#bbbbbb" :
                                 (parent.hovered ? "#d6d6d6" : "#f6f6f6")
                 } // разный цвет кнопки при нажатии, наведении курсора и в обычном состоянии
                 text: qsTr("Вход")
                 anchors.horizontalCenter: parent.horizontalCenter

                 onClicked: checkCredentials()
             }
         }
     }
}
