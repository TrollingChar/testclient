package hz.company.testclient.interf;

import openfl.*;
import openfl.display.*;
import openfl.events.*;
import openfl.filters.*;
import openfl.text.*;
import format.*;

/**
 * ...
 * @author 
 */
class TextBox extends Sprite
{
	var tf:TextFormat;
	var textfield:TextField;
	public var text(get, set):String;
	
	function get_text() {
		return textfield.text;
	}
	
	function set_text(s) {
		return textfield.text = s;
	}

	public function new(s:String) 
	{
		super();
		
		var svg:SVG = new SVG(Assets.getText("img/button.svg"));
		var shape:Shape = new Shape();
		svg.render(shape.graphics);
		addChild(shape);
		
		// text
		tf = new TextFormat(Assets.getFont("font/Jura-Medium.ttf").fontName, 42, 0x889999);
		tf.align = TextFormatAlign.CENTER;
		
		textfield = new TextField();
		textfield.width = 300;
		textfield.height = 100;
		textfield.defaultTextFormat = tf;
		textfield.text = s;
		textfield.embedFonts = true;
		textfield.y = 25;
		textfield.autoSize = TextFieldAutoSize.CENTER;
		textfield.type = TextFieldType.INPUT;
		textfield.cacheAsBitmap = true;
		
		addChild(textfield);
	}	
	
	function deactivate(event:Event)
	{
		textfield.textColor = 0x889999;
		
		var filt = textfield.filters;
		filt.pop();
		textfield.filters = filt;
	}
	
	function activate(event:Event)
	{		
		textfield.textColor = 0xFFFFFF;
		
		var filt = textfield.filters;
		filt.push(new GlowFilter(0xFFFF00));
		textfield.filters = filt;
	}
}