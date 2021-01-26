import openfl.display.Sprite;

/// Шарик для игры
class Ball extends Sprite {
    /// Скорость поумолчанию
    public static final DEFAULT_SPEED = 100;

    /// Скорость по x
    public var speedX:Float = DEFAULT_SPEED;

    /// Скорость по y
    public var speedY:Float = DEFAULT_SPEED;

	/// Конструктор
	public function new() {
		super();

		this.graphics.beginFill(0xffffff);
		this.graphics.drawCircle(0, 0, 20);
		this.graphics.endFill();
    }    
}
