package hz.company.testclient.interf;
import hz.company.testclient.interf.Panel;

/**
 * ...
 * @author 
 */
class PanelInGame extends Panel
{
	var btn1:Sprite;
	var btn2:Sprite;

	public function new() 
	{
		addEventListener(Event.ADDED_TO_STAGE, Added);
		
		btn1 = new ButtonIcon(" ", function(e:MouseEvent) {
			var i:Null<Int> = Std.parseInt(input.text);			
			if (i != null) {
				Main.connection.sendAuth(i);
			}
		});
		
		addEventListener(Event.ADDED_TO_STAGE, Added);
		
		btn2 = new ButtonIcon(" ", function(e:MouseEvent) {
			var i:Null<Int> = Std.parseInt(input.text);			
			if (i != null) {
				Main.connection.sendAuth(i);
			}
		});
		
		btn1.x = 0;
		btn1.y = 500;
		addChild(btn1);
		
		btn2.x = 880;
		btn2.y = 500;
		addChild(btn2);
	}
	
	function override Resize(event:Event)
	{
		var h:Float = stage.stageHeight * .1;
		btn1.scaleX = btn1.scaleY = btn2.scaleX = btn2.scaleY = h / 100;
		btn1.x = 0;
		btn1.y = btn2.y = h;
		btn2.x = stage.stageWidth - 120 * btn.scaleX;
		posShown.x = 0;
		posShown.y = stage.stageHeight - h;
		posHidden.x = 0;
		posHidden.y = stage.stageHeight;
	}
}