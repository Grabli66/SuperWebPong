import flixel.FlxState;

/// Состояние игры
class GameState extends FlxState {
	var width = 0;
	var height = 0;

	/// Шарик
	var ball:Ball;

	/// Игрок 1
	var playerOne:Player;

	/// Игрок 2
	var playerTwo:Player;

	override public function create() {
		super.create();
		bgColor = 0x333333;

		// var text = new flixel.text.FlxText(0, 0, 0, "Hello World", 64);
		// text.screenCenter();
		// add(text);

		ball = new Ball();
		add(ball);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		ball.x += ball.speedX * elapsed;
		ball.y += ball.speedY * elapsed;

		if (ball.x < 0) {
			ball.x = 0;
			ball.speedX *= -1;
		} else if (ball.x + ball.width > width) {
			ball.x = width - ball.width;
			ball.speedX *= -1;
		}

		if (ball.y < 0) {
			ball.y = 0;
			ball.speedY *= -1;
		} else if (ball.y + ball.width > height) {
			ball.y = height - ball.height;
			ball.speedY *= -1;
		}
	}

	override function onResize(width:Int, height:Int) {
		this.width = width;
		this.height = height;
		super.onResize(width, height);
	}
}
