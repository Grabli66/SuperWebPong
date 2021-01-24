import openfl.display.Bitmap;
import openfl.Assets;
import openfl.display.Sprite;

class SuperPongClient extends Sprite {
	public function new() {
		super();
        var bitmapData = Assets.getBitmapData("images/background.jpg");
        var bitmap = new Bitmap (bitmapData);
        addChild (bitmap);
	}
}
