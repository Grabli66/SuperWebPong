import flixel.util.FlxAxes;
import lime.ui.KeyCode;
import flixel.FlxG;
import flixel.FlxState;

/// Состояние игры
class GameState extends FlxState {
	/// Ширина экрана
	var width = 0;

	/// Высота экрана
	var height = 0;

	/// Шарик
	var ball:Ball;

	/// Игрок 1
	var player:Player;

	/// Игрок 2
	var enemy:Player;

	/// Двигает шарик
	function moveBall(elapsed:Float) {
		ball.x += ball.speedX * elapsed;
		ball.y += ball.speedY * elapsed;

		// Столокновения со стеной
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

		if ((ball.x < player.x + player.width) && (ball.y >= player.y) && (ball.y <= player.y + player.height)) {
			ball.x = player.x + player.width;
			ball.speedX *= -1;
		}
	}

	/// Двигает игрока
	function movePlayer(elapsed:Float) {
		if (FlxG.keys.pressed.W) {
			player.y -= 200 * elapsed;
		} else if (FlxG.keys.pressed.S) {
			player.y += 200 * elapsed;
		}

		if (player.y < 0) {
			player.y = 0;
		} else if (player.y + player.height > height) {
			player.y = height - player.height;
		}
	}

	/// Создаёт состояние
	override public function create() {
		super.create();
		bgColor = 0x333333;
		width = FlxG.width;
		height = FlxG.height;

		var text = new flixel.text.FlxText(0, 0, 0, "0 : 0", 16);
		text.screenCenter(FlxAxes.X);
		add(text);

		ball = new Ball();
		ball.x = (width / 2) - ball.width / 2;
		ball.y = (height / 2) - ball.height / 2;
		ball.speedX *= Math.random() >= 0.5 ? 1 : -1;
		ball.speedY *= Math.random() >= 0.5 ? 1 : -1;
		add(ball);

		player = new Player();
		player.x = 10;
		player.y = (height / 2) - (player.height / 2);
		add(player);
	}

	/// Обновляет логику
	override public function update(elapsed:Float) {
		super.update(elapsed);
		moveBall(elapsed);
		movePlayer(elapsed);
	}

	override function onResize(width:Int, height:Int) {
		this.width = width;
		this.height = height;
		super.onResize(width, height);
	}
}
