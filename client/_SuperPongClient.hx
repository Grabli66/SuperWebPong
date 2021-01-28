// import openfl.events.KeyboardEvent;
// import openfl.Lib;
// import openfl.events.Event;
// import hx.ws.Types.MessageType;
// import haxe.io.Bytes;
// import hx.ws.WebSocket;
// import openfl.display.Sprite;

// class _SuperPongClient extends Sprite {
// 	/// Предыдущее время
// 	var previousTime:Int = 0;

// 	/// Шарик
// 	var ball:Ball;

// 	/// Игрок 1
// 	var playerOne:Player;

// 	/// Игрок 2
// 	var playerTwo:Player;

// 	/// Конструктор
// 	public function new() {
// 		super();

// 		// var bitmapData = Assets.getBitmapData("images/background.jpg");
// 		// var bitmap = new Bitmap(bitmapData);
// 		// addChild(bitmap);

// 		this.graphics.beginFill(0x333333);
// 		this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
// 		this.graphics.endFill();

// 		ball = new Ball();
// 		ball.x = 0;
// 		ball.y = 0;
// 		addChild(ball);

// 		playerOne = new Player();
// 		playerOne.x = 10;
// 		playerOne.y = (stage.stageHeight / 2) - (playerOne.height / 2);
// 		addChild(playerOne);

// 		var ws = new WebSocket("ws://localhost:8080/ws");
// 		ws.onopen = function() {
// 			ws.send(Bytes.ofString("alice bytes"));
// 		}

// 		ws.onmessage = (message:MessageType) -> {
// 			switch (message) {
// 				case BytesMessage(content):
// 					var radius = content.readUnsignedInt();
// 				// trace(radius);
// 				default:
// 			}
// 		}

// 		this.addEventListener(Event.ENTER_FRAME, onUpdate);		
// 	}


// 	/// Вызывается при обновлении кадра
// 	function onUpdate(event:Event):Void {
// 		var currentTime = Lib.getTimer();
// 		var deltaTime = (currentTime - previousTime) / 1000.0;
// 		previousTime = currentTime;

// 		ball.x += ball.speedX * deltaTime;
// 		ball.y += ball.speedY * deltaTime;

// 		if (ball.x < 0) {
// 			ball.x = 0;
// 			ball.speedX *= -1;
// 		} else if (ball.x + ball.width > stage.stageWidth) {
// 			ball.x = stage.stageWidth - ball.width;
// 			ball.speedX *= -1;
// 		}

// 		if (ball.y < 0) {
// 			ball.y = 0;
// 			ball.speedY *= -1;
// 		} else if (ball.y + ball.width > stage.stageHeight) {
// 			ball.y = stage.stageHeight - ball.height;
// 			ball.speedY *= -1;
// 		}
// 	}
// }
