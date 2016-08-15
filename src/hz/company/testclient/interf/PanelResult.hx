package hz.company.testclient.interf;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import openfl.Assets;
import openfl.text.*;

/**
 * ...
 * @author 
 */
class PanelResult extends Panel
{
	var txt:TextField;
	var tf:TextFormat;
	public var text(get, set):String;

	public function new() 
	{
		super();
		
		
		var btn:Sprite;
		
		tf = new TextFormat(Assets.getFont("font/Jura-Medium.ttf").fontName, 42, 0x889999);
		tf.align = TextFormatAlign.CENTER;
		txt = new TextField();
		txt.x = 100;
		txt.y = 200;
		txt.width = 800;
		txt.height = 300;
		txt.defaultTextFormat = tf;
		txt.text = "";
		txt.selectable = false;
		txt.embedFonts = true;
		txt.wordWrap = true;
		txt.cacheAsBitmap = true;
		addChild(txt);
		
		btn = new Button(function(e:MouseEvent) {
			hidden = true;
			Main.I.panMain.hidden = false;
		}, "OK");
		btn.x = 350;
		btn.y = 350;
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
	
	function get_text():String 
	{
		return txt.text;
	}
	
	function set_text(value:String):String 
	{
		return txt.text = value;
	}
}