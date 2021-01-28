import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.FlxSprite;

/// Шарик для игры
class Ball extends FlxSprite {
	/// Скорость по умолчанию
	public static final DEFAULT_SPEED = 100;

	/// Радиус по умолчанию
	public static final DEFAULT_RADIUS = 10;

	/// Радиус
	public var radius:Int = DEFAULT_RADIUS;

	/// Скорость по x
	public var speedX:Float = DEFAULT_SPEED;

	/// Скорость по y
	public var speedY:Float = DEFAULT_SPEED;

	/// Конструктор
	public function new() {
		super();
		
		makeGraphic(radius * 2, radius * 2, FlxColor.TRANSPARENT);
		FlxSpriteUtil.drawCircle(this, radius, radius, radius);
	}
}
