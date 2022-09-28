import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: primaryFrame
    width: 800
    height: 400
    visible: true
    title: qsTr("Search pair")

    LoginForm {
        id: firstWindowf

        onStarted: {
            firstWindowf.state = showFormStateName
        }

        onSignalExitLogin: {
            firstWindowf.state = hideFormStateName
            twoWindowf.state = showFormStateName
        }
    }               

    SearchForm {
        id: twoWindowf
        state: hideFormStateName

        onSignalExitSearch: {
            twoWindowf.state = hideFormStateName
            threeWindowf.state = showFormStateName
        }
    }

    SearchEnd {
        id: threeWindowf
        state: hideFormStateName
    }

}
