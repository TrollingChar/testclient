package hz.company.testclient.interf;
import hz.company.testclient.interf.*;
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
		for (x in 0...cols)
		{
			for (y in 0...rows)
			{
				var btn:ButtonIcon = new ButtonIcon(function(e:MouseEvent) 
				{
					//this.hidden =
					//Main.I.panInGame.hidden = true;
					//Main.I.panMain.hidden = false;
				}, "");
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
		var scX:Float = stage.stageWidth / 120 / cols;				// ширина зависит от содержимого
		var scY:Float = stage.stageHeight / 120 / rows * 0.8;
		var scale:Float = scaleX = scaleY = Math.min(scX, scY);
		posShown.x = stage.stageWidth / 2 - 60 * cols * scale;
		posShown.y = stage.stageHeight * .45 - 60 * rows * scale;
		posHidden.x = posShown.x;
		posHidden.y = stage.stageHeight;
		position = position;
	}
}