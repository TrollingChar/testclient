package hz.company.testclient.interf;
import openfl.display.*;
import openfl.events.*;
import openfl.text.*;

/**
 * ...
 * @author 
 */
class PanelMain extends Panel
{
	public function new() 
	{
		super();		
		
		var btn:Sprite;
		
		//input = new TextBox("введите id");
		//input.x = 500;
		//input.y = 250;
		//addChild(input);
		
		//btn = new Button("Вход", function(e:MouseEvent) {
			//var i:Null<Int> = Std.parseInt(input.text);			
			//if (i != null) {
				//Main.connection.sendAuth(i);
			//}
		//});
		//btn.x = 200;
		//btn.y = 250;
		//addChild(btn);
		btn = new Button("Играть", function(e:MouseEvent) {
			hidden = true;
			Main.I.panArs.hidden =
			Main.I.panInGame.hidden = false;
		});
		btn.x = 350;
		btn.y = 150;
		addChild(btn);
		//btn = new Button("Экран", function(e:MouseEvent) {
			//if (stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE)			
				//stage.displayState = StageDisplayState.NORMAL;
			//else
				//stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;				
		//});
		//btn.x = 350;
		//btn.y = 350;
		//addChild(btn);
		//
		//text = new TextField();
		//var tf:TextFormat = new TextFormat(Assets.getFont("font/Jura-Medium.ttf").fontName, 72, 0x889999);
		//tf.align = TextFormatAlign.CENTER;
		//
		//text = new TextField();
		//text.width = 1000;
		//text.height = 100;
		//text.defaultTextFormat = tf;
		//text.selectable = false;
		//text.text = "";
		//text.embedFonts = true;
		//text.y = 500;
		//text.autoSize = TextFieldAutoSize.CENTER;
		//
		//addChild(text);
		//Main.I.showPanel(this);
		hidden = false;
	}
	
	override function Resize(event:Event)
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