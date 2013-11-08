
var MagicOffset = 1380000000

var UNITS_PER_SECOND = 20

function logThis( something){
    console.log(Qt.formatTime(new Date(), "hh:mm:ss:zzz ") + something);
}

function computeTime( time) {
    return (time - MagicOffset) / UNITS_PER_SECOND;
}

function computeDuration( time) {
    return time / UNITS_PER_SECOND;
}
