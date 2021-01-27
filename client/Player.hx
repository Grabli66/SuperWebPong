import openfl.display.Sprite;

/// Игрок
class Player extends Sprite {
	/// Конструктор
	public function new() {
		super();

		this.graphics.beginFill(0xffffff);
		this.graphics.drawRect(0, 0, 20, 60);
		this.graphics.endFill();
	}
}
