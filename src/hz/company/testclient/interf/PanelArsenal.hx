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
	
	public function new() 
	{
		super();
		for (x in 0...10)
		{
			for (y in 0...7)
			{
				var btn:Sprite = new ButtonIcon(Std.string(Std.int(Math.random()*10)), function(e:MouseEvent) 
				{
					this.hidden = true;
					Main.I.panMain.hidden = false;
				});
				btn.x = x * 120;
				btn.y = 10 + y * 120;
				addChild(btn);
			}
		}
	}
	
	override function Resize(event:Event)
	{
		var scX:Float = stage.stageWidth / 1200;				// ширина зависит от содержимого
		var scY:Float = stage.stageHeight / 840 * 0.8;
		var scale:Float = scaleX = scaleY = Math.min(scX, scY);
		posShown.x = stage.stageWidth / 2 - 600 * scale;
		posShown.y = stage.stageHeight * .45 - 420 * scale;
		posHidden.x = posShown.x;
		posHidden.y = stage.stageHeight;
		position = position;
	}
}