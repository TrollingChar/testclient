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
	var icon:Sprite;
	var iconVisible(get, set):Bool;
	
	public function new(callback:MouseEvent->Void, text:String, icon:Sprite = null) 
	{
		var svg:SVG;
		svg = new SVG(Assets.getText("img/button-icon.svg"));
		shape = new Shape();
		svg.render(shape.graphics);		
		addChild(shape);
		
		this.icon = new Sprite();
		this.icon.x = shape.width / 2;
		this.icon.y = shape.height / 2;
		if (icon != null) {
			this.icon.addChild(icon);
		}
		addChild(this.icon);
		
		super(text, 0x889999, new GlowFilter(0xFFFF00), false);
		textField.x = 0;
		textField.width = 120;
		
		addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		addEventListener(MouseEvent.CLICK, callback);		
	}
	
	function mouseOut(event:MouseEvent)
	{
		if (icon != null)
			icon.scaleX =
			icon.scaleY = 1;
		color = 0x889999;
		glow = false;
	}
	
	function mouseOver(event:MouseEvent)
	{
		if (icon != null)
			icon.scaleX =
			icon.scaleY = 1.2;
		color = 0xFFFFFF;
		glow = true;
	}
	
	function get_iconVisible():Bool 
	{
		if (icon == null) return false;
		return icon.visible;
	}
	
	function set_iconVisible(value:Bool):Bool 
	{
		if (icon == null) return value;
		return icon.visible = value;
	}
}