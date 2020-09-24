import './main.css';
import { Elm } from './Main.elm';
import * as serviceWorker from './serviceWorker';

const elm = Elm.Main.init({
    node: document.getElementById("root"),
    flags: {
        width : window.innerWidth, 
        height: window.innerHeight 
    }
});

window.onresize = () => {
    elm.ports.windowData.send({
        width : window.innerWidth,
        height : window.innerHeight,
    });
};

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
