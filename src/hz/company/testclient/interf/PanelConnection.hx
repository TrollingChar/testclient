package hz.company.testclient.interf;
import flash.events.*;
import openfl.display.*;
import openfl.system.Security;

/**
 * ...
 * @author 
 */
class PanelConnection extends Panel
{		
	var btn:Sprite;
	var txt1:TextBox;
	var txt2:TextBox;

	public function new() 
	{
		super();
		
		btn = new Button(function(e:MouseEvent) {
			var i:Null<Int> = Std.parseInt(txt2.text);
			if (i == null) {
				return;
			}
			Main.I.connection = new Connection(txt1.text, 8080);
			//Security.allowDomain("*");
			//Security.allowInsecureDomain("*");
			//Security.loadPolicyFile("xmlsocket://" + txt1.text + ":843");
			Main.I.connection.connect(i);
		}, "Вход");
		btn.x = 350;
		btn.y = 300;
		addChild(btn);
		hidden = false;
		
		txt1 = new TextBox("127.0.0.1");
		txt1.x = 200;
		txt1.y = 150;
		addChild(txt1);
		
		txt2 = new TextBox("72");
		txt2.x = 500;
		txt2.y = 150;
		addChild(txt2);
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