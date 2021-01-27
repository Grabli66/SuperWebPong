import openfl.display.Sprite;

/// Шарик для игры
class Ball extends Sprite {
    /// Скорость по умолчанию
    public static final DEFAULT_SPEED = 100;

    /// Радиус по умолчанию
    public static final DEFAULT_RADIUS = 10;

    /// Радиус
    public var radius:Float = DEFAULT_RADIUS;

    /// Скорость по x
    public var speedX:Float = DEFAULT_SPEED;

    /// Скорость по y
    public var speedY:Float = DEFAULT_SPEED;

	/// Конструктор
	public function new() {
        super();
                
		this.graphics.beginFill(0xffffff);
		this.graphics.drawCircle(radius, radius, radius);
        this.graphics.endFill();

        width = radius * 2;
        height = radius * 2;
    }    
}
