package hz.company.testclient.interf;
import flash.filters.GlowFilter;
import flash.text.TextField;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author 
 */
class Label extends UIElement
{
	var textField:TextField;

	public function new(text:String, color:Int, glowFilter:GlowFilter = null, glow = false) 
	{
		super();
		
		textField = new TextField();
		textField.width = 300;
		textField.height = 100;
		textField.defaultTextFormat = UIElement.textFormat;
		textField.selectable = false;
		textField.cacheAsBitmap = 
		textField.embedFonts = true;
		textField.autoSize = TextFieldAutoSize.CENTER;
		
		this.text = text;
		this.color = color;
		this.glowFilter = glowFilter;
		this.glow = glow;
		
		addChild(textField);
	}
	
	//@:getter(text)
	override function get_text():String 
	{
		return textField.text;
	}
	
	//@:setter(text)
	override function set_text(value:String):String 
	{
		return textField.text = value;
	}
	
	//@:getter(glow)
	override function get_glow():Bool 
	{
		return super.get_glow();
	}
	
	//@:setter(glow)
	override function set_glow(value:Bool):Bool 
	{
		if (glow) {
			if (!value) {
				// убрать свечение
				var filt = textField.filters;
				filt.pop();
				textField.filters = filt;
			}
		} else {
			if (value) {
				// сделать свечение				
				var filt = textField.filters;
				filt.push(glowFilter);
				textField.filters = filt;		
			}
		}
		return super.set_glow(value);	
	}
	
	//@:getter(color)
	override function get_color():Int 
	{
		return textField.textColor;
	}
	
	//@:setter(color)
	override function set_color(value:Int):Int 
	{
		return textField.textColor = value;
	}
	
	//@:getter(glowFilter)
	override function get_glowFilter():GlowFilter 
	{
		return super.get_glowFilter();
	}
	
	//@:setter(glowFilter)
	override function set_glowFilter(value:GlowFilter):GlowFilter 
	{
		if (glow) 
		{
			var filt = textField.filters;
			filt.pop();
			filt.push(value);
			textField.filters = filt;
			
		}
		return super.set_glowFilter(value);
	}
}