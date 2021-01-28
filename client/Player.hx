import flixel.util.FlxSpriteUtil;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import openfl.display.Sprite;

/// Игрок
class Player extends FlxSprite {
	/// Конструктор
	public function new() {
		super();

		makeGraphic(20, 60, FlxColor.WHITE);
	}
}
