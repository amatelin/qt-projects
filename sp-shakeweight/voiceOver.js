var options_names = ["almost", "compliment", "end", "fingers", "good", "keep",
                     "more", "motivation", "pill", "quicky", "yes"];
var options_length = [4, 14, 5, 2, 4, 3, 4, 7, 2, 3, 4];
var playerComponent;
var player;

initialize();


function initialize () {
    playerComponent = Qt.createComponent("audioPlayer.qml");
    player = playerComponent.createObject(window);
}


function playIdle() {
    playRandomSound(9); // quicky
}

function playSlow() {
    console.log("C")
    var rand = pickRandomClass(2);
    if (rand == 1)
        playRandomSound(5); // keep
    else
        playRandomSound(6); // more
}

function playMedium() {
    var rand = pickRandomClass(3);
    if (rand == 1)
        playRandomSound(7); // motivation
    else if (rand == 2)
        playRandomSound(4); // good
    else
        playRandomSound(10); // yes

}

function playFast() {
    var rand = pickRandomClass(3);
    if (rand == 1)
         playRandomSound(1); // compliment

    else if (rand == 2)
        playRandomSound(0); // almost
    else
        playRandomSound(3); // fingers
}

function playVeryFast() {
    var rand = pickRandomClass(2);
    if (rand == 1)
        playRandomSound(2); // end
    else
        playRandomSound(8); // pill

}


function playSound(name, ref) {

    var source = "content/audio/" + name + "/" + pad(ref, 3) + ".wav"
    player.source = source;
    player.play();

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
    console.log(window.state);

    if (window.state == "listening") {
        console.log("a");
        var rand = pickRandomClass(options_length[ref]);
//        window.state = "playing";
        playSound(options_names[ref], rand);
        }

    }


function pad(n, width, z) {
  z = z || '0';
  n = n + '';
  return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
}

