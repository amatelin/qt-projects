import QtMultimedia 5.0

Audio {
    id: player
    autoLoad: false

    function playAudio(name, ref) {
        console.debug(source);
        console.log(status.toString());
        play();
    }

    onPlaying: {
        if (!error)
             window.state = "playing";
        }

    onStopped: {
        if (!error)
            timer.start()
            console.log("ok");
    }

}
