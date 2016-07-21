package hz.company.testclient.interf;

import openfl.*;
import openfl.events.*;
import openfl.display.*;
import openfl.text.*;
import openfl.geom.Point;

/**
 * ...
 * @author Trollingchar
 */
class Panel extends Sprite
{
	var st:Stage;	
	public var posHidden:Point;
	public var posShown:Point;
	@:isVar public var position(get, set):Float;
	public var hidden:Bool;
	

	public function new() 
	{
		super();
		
		posHidden = new Point();
		posShown = new Point();
		
		addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		/*
		btn = new Button(Std.string(Math.random()), function(e:Event) { Main.I.showRandom(); });
		btn.y = 200;
		btn.x = Math.random() * 700;
		addChild(btn);
		*/
		hidden = true;
	}
	
	function addedToStage(event:Event) {
		removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		stage.addEventListener(Event.RESIZE, Resize);
		stage.addEventListener(Event.ENTER_FRAME, Update);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, MouseMove);
		//stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, function(e:MouseEvent) {text.text = "mouse down"; });
		//stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, function(e:MouseEvent) {text.text = "mouse up"; });
		Resize(null);
		position = hidden ? 0 : 1;
	}
	
	private function Update(e:Event):Void 
	{
		if (hidden) {
			if (position > 0.1) position -= 0.1; else position = 0.0;
		} else {
			if (position < 0.9) position += 0.1; else position = 1.0;			
		}
	}
	
	function MouseMove(event:MouseEvent) {
		//text.x = event.stageX;
		//text.y = event.stageY;
		//text.text = event.stageX + ", " + event.stageY;
	}
	
	function Resize(event:Event) {
		var scX:Float = stage.stageWidth / 1000;
		var scY:Float = stage.stageHeight / 600;
		var scale:Float = scaleX = scaleY = Math.min(scX, scY);
		posShown.x = stage.stageWidth / 2 - 500 * scale;
		posShown.y = stage.stageHeight / 2 - 300 * scale;
		posHidden.x = posShown.x;
		posHidden.y = stage.stageHeight;
		position = position;
	}
	
	function get_position():Float 
	{
		return position;
	}
	
	function set_position(value:Float):Float 
	{
		// 0 - hidden, 1 - shown
		x = (1.0 - value) * posHidden.x + value * posShown.x;
		y = (1.0 - value) * posHidden.y + value * posShown.y;
		return position = value;
	}
	
}