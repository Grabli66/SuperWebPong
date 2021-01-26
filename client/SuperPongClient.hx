import openfl.Lib;
import openfl.events.Event;
import hx.ws.Types.MessageType;
import haxe.io.Bytes;
import hx.ws.WebSocket;
import openfl.display.Sprite;

class SuperPongClient extends Sprite {
	/// Предыдущее время
	var previousTime:Int = 0;

	/// Шарик
	var ball:Ball;

	public function new() {
		super();

		// var bitmapData = Assets.getBitmapData("images/background.jpg");
		// var bitmap = new Bitmap(bitmapData);
		// addChild(bitmap);

		this.graphics.beginFill(0x333333);
		this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
		this.graphics.endFill();

		ball = new Ball();
		addChild(ball);

		var ws = new WebSocket("ws://localhost:8080/ws");
		ws.onopen = function() {
			ws.send(Bytes.ofString("alice bytes"));
		}

		ws.onmessage = (message:MessageType) -> {
			switch (message) {
				case BytesMessage(content):
					var radius = content.readUnsignedInt();
					//trace(radius);
				default:
			}
		}

		this.addEventListener(Event.ENTER_FRAME, onUpdate);
	}

	/// Вызывается при обновлении кадра
	function onUpdate(event:Event):Void {
		var currentTime = Lib.getTimer();
		var deltaTime = (currentTime - previousTime) / 1000.0;
		previousTime = currentTime;

		ball.x += ball.speedX * deltaTime;
		ball.y += ball.speedY * deltaTime;

		if (ball.x < 0) {
			ball.x = 0;
			ball.speedX *= -1;
		} else if (ball.x > stage.stageWidth) {
			ball.x = stage.stageWidth;
			ball.speedX *= -1;
		}

		if ((ball.y < 0) || (ball.y > stage.stageHeight)) {
			ball.speedY *= -1;
		}
	}
}
