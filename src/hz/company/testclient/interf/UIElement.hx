package hz.company.testclient.interf;
import flash.display.Sprite;
import openfl.events.*;
import openfl.filters.*;
import openfl.text.*;
import openfl.*;
import openfl.display.*;
import format.*;

/**
 * ...
 * @author 
 */
class UIElement extends Sprite
{
	static var textFormat:TextFormat;
	
	public var text(get, set):String;
	public var color(get, set):Int;
	@:isVar public var glow(get, set):Bool;
	@:isVar public var glowFilter(get, set):GlowFilter;

	public function new() 
	{
		super();
		
		if (textFormat == null) {			
			textFormat = new TextFormat(Assets.getFont("font/Jura-Medium.ttf").fontName, 42);
			textFormat.align = TextFormatAlign.CENTER;
		}
	}
	
	function get_text():String 
	{
		return "ERROR";
	}
	
	function set_text(value:String):String 
	{
		return value;
	}
	
	function get_glowFilter():GlowFilter 
	{
		return glowFilter;
	}
	
	function set_glowFilter(value:GlowFilter):GlowFilter 
	{
		return glowFilter = value;
	}
	
	function get_color():Int 
	{
		return 0;
	}
	
	function set_color(value:Int):Int 
	{
		return value;
	}
	
	function get_glow():Bool 
	{
		return glow;
	}
	
	function set_glow(value:Bool):Bool 
	{
		return glow = value;
	}
}