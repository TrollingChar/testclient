package hz.company.testclient.bf.weapons;
import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;
import openfl.display.PixelSnapping;
import openfl.display.Sprite;

/**
 * ...
 * @author 
 */
class Weapons
{
	public static inline var COLS:Int = 10;
	public static inline var ROWS:Int = 7;
		
	public static inline var NONE:Int = -1;
	public static inline var BAZOOKA:Int = 0;
	public static inline var GRENADE:Int = 1;
	
	public static function createWeaponById(id:Int) {
		switch (id) 
		{
			case BAZOOKA:
				
			case GRENADE:
				
			default:
				
		}
	}
	
	public static function getIconById(id:Int):Sprite {
		var bmd:BitmapData;
		switch (id) 
		{
			case BAZOOKA:
				bmd = Assets.getBitmapData("img/icon-rpg.png");
			case GRENADE:
				bmd = Assets.getBitmapData("img/icon-grenade.png");				
			default:
				return null;
		}
		
		var sprite:Sprite = new Sprite();
		var bmp:Bitmap = new Bitmap(bmd, PixelSnapping.AUTO, true);
		bmp.x = -bmp.width / 2;
		bmp.y = -bmp.height / 2;
		sprite.addChild(bmp);
		//sprite.x = shape.width / 2;
		//sprite.y = shape.height / 2;
		sprite.scaleX =
		sprite.scaleY = .3;
		return sprite;
	}
}