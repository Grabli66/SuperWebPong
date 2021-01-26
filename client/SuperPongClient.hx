import haxe.io.Bytes;
import hx.ws.WebSocket;
import openfl.display.Bitmap;
import openfl.Assets;
import openfl.display.Sprite;

class SuperPongClient extends Sprite {
	public function new() {
		super();
        var bitmapData = Assets.getBitmapData("images/background.jpg");
        var bitmap = new Bitmap (bitmapData);
        addChild (bitmap);

        var ws = new WebSocket("ws://localhost:8080/ws");
        ws.onopen = function() {           
            ws.send(Bytes.ofString("alice bytes"));
        }

        ws.onmessage = (x) -> {
            trace(x);
        }
	}
}
