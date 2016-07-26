package hz.company.testclient.interf;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * ...
 * @author 
 */
class PanelCancel extends Panel
{

	public function new() 
	{
		super();		
		
		var btn:Sprite;
		
		btn = new Button("Отмена", function(e:MouseEvent) {
			Main.I.connection.sendCancelBattle();
		});
		btn.x = 350;
		btn.y = 250;
		addChild(btn);
		
		hidden = true;
	}
	
	override function resize(event:Event)
	{
		var scX:Float = stage.stageWidth / 1000;
		var scY:Float = stage.stageHeight / 600;
		var scale:Float = scaleX = scaleY = Math.min(scX, scY);
		posShown.x = stage.stageWidth / 2 - 500 * scale;
		posShown.y = stage.stageHeight / 2 - 300 * scale;
		posHidden.x = posShown.x;
		posHidden.y = stage.stageHeight;
	}
}