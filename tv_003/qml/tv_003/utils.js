
var MagicOffset = 1380000000

var UNITS_PER_HALFHOUR = 200
var HALFHOUR = 30 * 60
var ONESECOND = UNITS_PER_HALFHOUR / HALFHOUR


var ONEDAYSECONDS = 26400
//var ONEDAYSECONDS = 86400

function logThis( something){
    console.log(Qt.formatTime(new Date(), "hh:mm:ss:zzz ") + something);
}

function computeTime( time) {
    return (time - MagicOffset) * ONESECOND;
}

function computeDuration( time) {
    return time * ONESECOND;
}
