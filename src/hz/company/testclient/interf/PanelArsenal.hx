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
		
		btn1.x = 5;
		btn1.y = 5;
		addChild(btn1);
		
		btn2.x = 1000 - 125;
		btn2.y = 5;
		addChild(btn2);
	}
	
	function override Resize(event:Event)
	{
		
	}
}