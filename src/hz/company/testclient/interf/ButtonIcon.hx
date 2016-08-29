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
	
	public function new(callback:MouseEvent->Void, text:String, icon:Bitmap = null) 
	{
		var svg:SVG;
		svg = new SVG(Assets.getText("img/button-icon.svg"));
		shape = new Shape();
		svg.render(shape.graphics);
		
		addChild(shape);
		
		this.icon = new Sprite();
		if(icon != null) {
			icon.x = -icon.width / 2;
			icon.y = -icon.height / 2;
			this.icon.addChild(icon);
		}
		this.icon.x = shape.width / 2;
		this.icon.y = shape.height / 2;
		this.icon.scaleX =
		this.icon.scaleY = .3;
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
		color = 0x889999;
		glow = false;
	}
	
	function mouseOver(event:MouseEvent)
	{		
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