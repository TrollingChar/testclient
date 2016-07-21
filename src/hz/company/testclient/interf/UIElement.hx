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
	var shape:Shape;
	var tf:TextFormat;
	var coff:Int;
	var goff:Int;
	var con:Int;
	var gon:Int;
	public var textfield:TextField;

	public function new(colorOff:Int, glowOff:Int, colorOn:Int, glowOn:Int) 
	{
		super();
		coff = colorOff;
		goff = glowOff;
		con = colorOn;
		gon = glowOn;
		var svg:SVG;
		svg = new SVG(Assets.getText("img/button.svg"));
		shape = new Shape();
		svg.render(shape.graphics);
		
		addChild(shape);
		
		// text
		tf = new TextFormat(Assets.getFont("font/Jura-Medium.ttf").fontName, 42, coff);
		tf.align = TextFormatAlign.CENTER;
		
		textfield = new TextField();
		textfield.width = 300;
		textfield.height = 100;
		textfield.defaultTextFormat = tf;
		textfield.selectable = false;
		textfield.text = s;
		textfield.embedFonts = true;
		textfield.y = 25;
		textfield.autoSize = TextFieldAutoSize.CENTER;
		textfield.cacheAsBitmap = true;
		
		addChild(textfield);		
		addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
		addEventListener(MouseEvent.CLICK, func);
	}
	
	function get_textfield(){ return textfield.text; } 
	
	function set_textfield(s:String){ 
		return s; 
	} 
	
	function MouseOut(event:MouseEvent)
	{
		textfield.textColor = coff;
		
		var filt = textfield.filters;
		filt.pop();
		textfield.filters = filt;
		/*
		addChildAt(shape, 0);
		removeChild(shapePressed);
		*/
	}
	
	function MouseOver(event:MouseEvent)
	{		
		textfield.textColor = con;
		
		var filt = textfield.filters;
		filt.push(new GlowFilter(gon));
		textfield.filters = filt;
		/*
		addChildAt(shapePressed, 0);
		removeChild(shape);
		*/
	}
}