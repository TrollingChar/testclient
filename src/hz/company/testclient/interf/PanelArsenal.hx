package hz.company.testclient.interf;
import hz.company.testclient.interf.*;
import hz.company.testclient.bf.weapons.Weapons;
import openfl.Assets;
import openfl.display.*;
import openfl.events.*;

/**
 * ...
 * @author 
 */
class PanelArsenal extends Panel
{
	static inline var cols:Int = 10;
	static inline var rows:Int = 5;
	public var btns:Array<ButtonIcon>;
	
	public function new() 
	{
		btns = new Array<ButtonIcon>();
		
		super();
		
		//var bmd:BitmapData = Assets.getBitmapData("img/icon_grenade.png");
		//var bmp:Bitmap = new Bitmap(bmd, PixelSnapping.AUTO, true);
		
		for (x in 0...Weapons.COLS)
		{
			for (y in 0...Weapons.ROWS)
			{
				var btn:ButtonIcon = new ButtonIcon(function(e:MouseEvent) 
				{
					Weapons.createWeaponById(x + y * 10);
				}, "", Weapons.getIconById(x + y * 10));
				btn.x = x * 120;
				btn.y = 10 + y * 120;
				btns[x + y * 10] = btn;
				addChild(btn);
			}
		}
		hidden = true;
	}
	
	override function resize(event:Event)
	{
		var scX:Float = stage.stageWidth / 120 / Weapons.COLS;				// ширина зависит от содержимого
		var scY:Float = stage.stageHeight / 120 / Weapons.ROWS * 0.8;
		var scale:Float = scaleX = scaleY = Math.min(scX, scY);
		posShown.x = stage.stageWidth / 2 - 60 * Weapons.COLS * scale;
		posShown.y = stage.stageHeight * .45 - 60 * Weapons.ROWS * scale;
		posHidden.x = posShown.x;
		posHidden.y = stage.stageHeight;
		position = position;
	}
}