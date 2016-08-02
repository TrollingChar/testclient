package hz.company.testclient.interf;

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
class ButtonIcon extends Label
{
	var shape:Shape;
	
	public function new(callback:MouseEvent->Void, text:String) 
	{
		var svg:SVG;
		svg = new SVG(Assets.getText("img/button-icon.svg"));
		shape = new Shape();
		svg.render(shape.graphics);
		
		addChild(shape);
		
		super(text, 0x889999, new GlowFilter(0xFFFF00), false);
		textField.x = 0;
		textField.width = 120;
		
		addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		addEventListener(MouseEvent.CLICK, callback);		
	}
	
	function mouseOut(event:MouseEvent)
	{
		color = 0x889999;
		glow = false;
	}
	
	function mouseOver(event:MouseEvent)
	{		
		color = 0xFFFFFF;
		glow = true;
	}
}