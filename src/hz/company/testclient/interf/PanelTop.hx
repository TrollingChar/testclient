package hz.company.testclient.interf;
import hz.company.testclient.interf.*;
import openfl.display.*;
import openfl.events.*;

/**
 * ...
 * @author 
 */
class PanelTop extends Panel
{
	var btn:Sprite;

	public function new() 
	{
		super();
		
		btn = new ButtonIcon(function(e:MouseEvent) {
			if (stage.displayState == StageDisplayState.NORMAL) {
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			} else {
				stage.displayState = StageDisplayState.NORMAL;
			}
		}, "");
		
		btn.x = 880;
		btn.y = 0;
		addChild(btn);
		
		hidden = false;
	}
	
	override function resize(event:Event)
	{
		var h:Float = stage.stageHeight * .05;
		btn.scaleX = btn.scaleY = h / 100;
		btn.x = stage.stageWidth - 120 * btn.scaleX;
		posShown.x = posShown.y = 0;
		posHidden.x = 0;
		posHidden.y = -h;
	}
}