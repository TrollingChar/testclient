package src.hz.company.testclient.interf;
import hz.company.testclient.interf.Panel;

/**
 * ...
 * @author 
 */
class PanelArsenal extends Panel
{
	
	public function new() 
	{
		
	}
	
	function override Resize(event:Event)
	{
		var scX:Float = stage.stageWidth / 1000;
		var scY:Float = stage.stageHeight / 600 * 0.8;
		var scale:Float = scaleX = scaleY = Math.min(scX, scY);
		posShown.x = stage.stageWidth / 2 - 500 * scale;
		posShown.y = stage.stageHeight * .45 - 300 * scale;
		posHidden.x = posShown.x;
		posHidden.y = stage.stageHeight;
		position = position;
	}
}