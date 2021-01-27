import flixel.FlxState;

class GameState extends FlxState {
	override public function create() {
		super.create();
		bgColor = 0x333333;

		var text = new flixel.text.FlxText(0, 0, 0, "Hello World", 64);
		text.screenCenter();
		add(text);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
