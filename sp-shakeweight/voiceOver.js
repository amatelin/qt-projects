var options_names = ["almost", "comment", "compliment", "cum", "encouraging", "faster",
                     "going_away", "good", "insert_finger", "keep_going",
                     "quick_workout", "random", "sleep_mode", "tell_me", "workout_finished"];
var options_length = [3, 3, 16, 1, 11, 7, 6, 3, 2, 3, 13, 5, 2, 3, 2];
// almost : 0
// comment : 1.
// compliment : 2
// cum : 3
// encouraging : 4.
// faster : 5.
// going_away : 6
// good : 7.
// insert_finger : 8
// keep_going : 9.
// quick_workout : 10.
// random : 11.
// sleep_mode : 12
// tell_me : 13.
// workout_finished : 14

var playerComponent;
var player;

initialize();


function initialize () {
    playerComponent = Qt.createComponent("audioPlayer.qml");
    player = playerComponent.createObject(window);
    console.log(player.id);
}


function playIdle() {
    var rand = pickRandomClass(4);

    if (rand == 1)
        playRandomSound(10); // quick_workout
    else if (rand == 2)
        playRandomSound(13) // tell_me
    else if (rand == 3)
        playRandomSound(1) // comment
}

function playSlow() {
    var rand = pickRandomClass(3);

    if (rand == 1)
        playRandomSound(5); // faster
    else
        playRandomSound(9); // keep_going
}

function playMedium() {
    var rand = pickRandomClass(3);

    if (rand == 1)
        playRandomSound(4); // encouraging
    else if (rand == 2)
        playRandomSound(7); // good
    else
        playRandomSound(11); // random

}

function playFast() {
    var rand = pickRandomClass(2);
    if (rand == 1)
         playRandomSound(2); // compliment

    else
        playRandomSound(4); // encouraging


}

function playVeryFast() {
    var rand = pickRandomClass(2);
        if (rand == 1)
            playRandomSound(8); // fingers
        else {
            playRandomSound(0); // almost
            rand = pickRandomClass(1);
            if (rand == 1) {
                playCumSequence();
            }
        }
}

function playCumSequence() {
        player.stop();
        console.log("A")
        var rand1 = pickRandomClass(options_length[3]);
        var rand2 = pickRandomClass(options_length[14]);
        var rand3 = pickRandomClass(options_length[6]);

        player.source1 = "content/audio/" + options_names[3] + "/" + pad(rand1, 3) + ".wav"
        player.source2 = "content/audio/" + options_names[14] + "/" + pad(rand2, 3) + ".wav"
        player.source3 = "content/audio/" + options_names[6] + "/" + pad(rand3, 3) + ".wav"
        player.goodBye();

}


function playSound(name, ref) {

    if (!player.playing) {
        var source = "content/audio/" + name + "/" + pad(ref, 3) + ".wav"
        player.source = source;
        player.play();
    }
}

function pickRandomClass(classNbr) {
    var rand = Math.random();
    var dist = [];

    for (var i=0; i<classNbr; i++) {
        dist[i] = Math.abs(1/(i+1)-rand) ;
    }

    var min_dist = Math.min.apply(null, dist);
    var chosenClass = dist.indexOf(min_dist) + 1;

    return chosenClass
}

function playRandomSound(ref) {
    var rand = pickRandomClass(options_length[ref]);
    playSound(options_names[ref], rand);
    }


function pad(n, width, z) {
  z = z || '0';
  n = n + '';
  return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
}

