package hz.company.testclient.interf;
import hz.company.testclient.interf.*;

/**
 * ...
 * @author 
 */
class PanelTop extends Panel
{
	var btn:Sprite;

	public function new() 
	{
		addEventListener(Event.ADDED_TO_STAGE, Added);
		
		btn = new ButtonIcon(" ", function(e:MouseEvent) {
			var i:Null<Int> = Std.parseInt(input.text);			
			if (i != null) {
				Main.connection.sendAuth(i);
			}
		});
		
		btn.x = 880;
		btn.y = 0;
		addChild(btn);
	}
	
	function override Resize(event:Event)
	{
		var h:Float = stage.stageHeight * .05;
		btn.scaleX = btn.scaleY = h / 100;
		btn.x = stage.stageWidth - 120 * btn.scaleX;
		posShown.x = posShown.y = 0;
		posHidden.x = 0;
		posHidden.y = -h;
	}
}