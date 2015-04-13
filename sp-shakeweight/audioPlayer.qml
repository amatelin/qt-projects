import QtMultimedia 5.4


SoundEffect {
    id: soundEffect

    onPlayingChanged: {
        if (playing)
            window.state = "playing";
        else
            timer.start();
    }

    onStatusChanged: {
        if (status == 3)
            window.state = "listening"
    }

}



