package src.hz.company.testclient.interf;
import hz.company.testclient.interf.ButtonIcon;
import hz.company.testclient.interf.Panel;

/**
 * ...
 * @author 
 */
class PanelArsenal extends Panel
{
	
	public function new() 
	{
		for (x in 0...9)
		{
			for (y in 0...6)
			{
				btn = new ButtonIcon(" ", function(e:MouseEvent) 
				{
					
				});
				btn.x = x * 120;
				btn.y = y * 120;
				addChild(btn);
			}
		}
	}
	
	function override Resize(event:Event)
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