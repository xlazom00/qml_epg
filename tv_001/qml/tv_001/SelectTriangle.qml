import QtQuick 2.0

Canvas {
    property color color: "white"
    width: 8
    height: 16
    id : canvas
    onPaint:{
        var ctx = canvas.getContext('2d');
        ctx.save();
//        ctx.fillStyle = "Green"
//        ctx.fillRect(0,0,width, height);

        ctx.fillStyle = color
        ctx.moveTo(0,0);
        ctx.lineTo(width, height/2)
        ctx.lineTo(0, height)
        ctx.lineTo(0, 0)
        ctx.closePath()
        ctx.fill()

//        ctx.strokeStyle = color;
//        ctx.translate((width/2), (height/2));
//        ctx.rotate(mousearea.mouseY/width)
//        drawSpirograph(ctx,20*(2)/(1),-8*(3)/(1),mousearea.mouseX/2);
//        ctx.globalAlpha = 0.5;
//        drawSpirograph(ctx,20*(2)/(1),-8*(3)/(1),mousearea.mouseX/2 + 5);
        ctx.restore();
    }

}
