import flixel.util.FlxAxes;
import flixel.FlxG;
import flixel.FlxState;

/// Состояние игры
class GameState extends FlxState {
	/// Ширина экрана
	var width = 0;

	/// Высота экрана
	var height = 0;

	/// Текст со счётом
	var scoreText : flixel.text.FlxText;

	/// Шарик
	var ball:Ball;

	/// Игрок 1
	var player:Player;

	/// Игрок 2
	var enemy:Enemy;

	/// Счёт игрока
	var playerScore(default, set) = 0;

	/// Счёт противника
	var enemyScore(default, set) = 0;

	function set_playerScore(v:Int):Int {
		this.playerScore = v;
		updateScoreText();
		return playerScore;
	}

	function set_enemyScore(v:Int):Int {
		this.enemyScore = v;
		updateScoreText();
		return enemyScore;
	}

	/// Обновляет отображение
	function updateScoreText() {
		scoreText.text = '${playerScore} : ${enemyScore}';
	}

	/// Двигает шарик
	function moveBall(elapsed:Float) {
		ball.x += ball.speedX * elapsed;
		ball.y += ball.speedY * elapsed;

		// Столокновения со стенами справа и слева
		if (ball.x < 0) {
			ball.x = 0;
			ball.speedX *= -1;
			enemyScore += 1;
		} else if (ball.x + ball.width > width) {
			ball.x = width - ball.width;
			ball.speedX *= -1;
			playerScore += 1;
		}
		
		// Столкновение со стенами снизу и сверху
		if (ball.y < 0) {
			ball.y = 0;
			ball.speedY *= -1;
		} else if (ball.y + ball.width > height) {
			ball.y = height - ball.height;
			ball.speedY *= -1;
		}

		// Столкновение с игроком
		if ((ball.x < player.x + player.width) && (ball.y >= player.y) && (ball.y <= player.y + player.height)) {
			ball.x = player.x + player.width;
			ball.speedX *= -1;
		}

		// Столкновение с соперником
		if ((ball.x + ball.width > enemy.x) && (ball.y >= enemy.y) && (ball.y <= enemy.y + enemy.height)) {
			ball.x = enemy.x - ball.width;
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

	/// Двигает соперника
	function moveEnemy(elapsed:Float) {
		if (FlxG.keys.pressed.UP) {
			enemy.y -= 200 * elapsed;
		} else if (FlxG.keys.pressed.DOWN) {
			enemy.y += 200 * elapsed;
		}

		if (enemy.y < 0) {
			enemy.y = 0;
		} else if (enemy.y + enemy.height > height) {
			enemy.y = height - enemy.height;
		}
	}

	/// Создаёт состояние
	override public function create() {
		super.create();
		bgColor = 0x333333;
		width = FlxG.width;
		height = FlxG.height;

		scoreText = new flixel.text.FlxText(0, 0, 0, "", 16);
		scoreText.screenCenter(FlxAxes.X);		
		add(scoreText);
		updateScoreText();

		ball = new Ball();
		ball.x = (width / 2) - ball.width / 2;
		ball.y = (height / 2) - ball.height / 2;
		ball.speedX *= Math.random() >= 0.5 ? 1 : -1;
		ball.speedY *= Math.random() >= 0.5 ? 1 : -1;
		add(ball);

		final PADDING_X = 10;

		player = new Player();
		player.x = PADDING_X;
		player.y = (height / 2) - (player.height / 2);
		add(player);

		enemy = new Enemy();
		enemy.x = (width - enemy.width) - PADDING_X;
		enemy.y = (height / 2) - (enemy.height / 2);
		add(enemy);
	}

	/// Обновляет логику
	override public function update(elapsed:Float) {
		super.update(elapsed);
		moveBall(elapsed);
		movePlayer(elapsed);
		moveEnemy(elapsed);
	}

	override function onResize(width:Int, height:Int) {
		this.width = width;
		this.height = height;
		super.onResize(width, height);
	}
}
