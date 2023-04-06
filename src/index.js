import "./main.css";
import { Elm } from "./Main.elm";
import * as serviceWorker from "./serviceWorker";

const app = Elm.Main.init({
  node: document.getElementById("root"),
});

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.register();

app.ports.requestGeolocation.subscribe(() => {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        const { latitude, longitude } = position.coords;
        app.ports.updateCoordinates.send({ latitude, longitude });
      },
      (error) => {
        console.log("geoiolcoi", error);

        // app.ports.sendError.send(error.message);
      }
    );
  } else {
    app.ports.sendError.send("Geolocation is not supported by this browser.");
  }
});
