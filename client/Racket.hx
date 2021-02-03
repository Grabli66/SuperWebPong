import flixel.util.FlxColor;
import flixel.FlxSprite;

/// Ракетка
class Racket extends FlxSprite {
	/// Конструктор
	public function new() {
		super();

		makeGraphic(20, 60, FlxColor.WHITE);
	}
}