package hz.company.testclient;

import hz.company.testclient.bf.*;
import hz.company.testclient.interf.*;
import openfl.display.*;
import openfl.filters.*;
import openfl.events.*;
import openfl.desktop.Clipboard;
import openfl.desktop.ClipboardFormats;
import openfl.ui.Keyboard;

/**
 * ...
 * @author 
 */
class Main extends Sprite 
{
	static public var I:Main;
	
	var logText:String = "game log:\n";
	
	public var connection:Connection;
	public var input:InputState;			// данные мыши и клавиатуры этого компьютера
	public var id:Int;						// id игрока
	public var random:Random;
	
	public var debugTextField:Label;
	public var panMain:Panel;
	public var panTop:Panel;
	public var panArs:PanelArsenal;
	public var panInGame:PanelInGame;
	public var panConnection:Panel;
	public var panCancel:Panel;
	public var panHelp:Panel;
	public var world:World;
	public var panResult:PanelResult;

	public function new() 
	{
		super();
		
		I = this;
		
		random = new Random(100500);
		
		debugTextField = new Label("test", 0xFFFFFF, new GlowFilter(0x00FFFF), true);
		debugTextField.x = 350;
		debugTextField.y = -25;
		addChild(debugTextField);
		
		panConnection = new PanelConnection();
		addChild(panConnection);
		
		input = new InputState(0, 0);
		stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, rightMouseDown);
		stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, rightMouseUp);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
						
		panMain = new PanelMain();
		addChild(panMain);
		
		panHelp = new PanelHelp();
		addChild(panHelp);
		
		panCancel = new PanelCancel();
		addChild(panCancel);
		
		panTop = new PanelTop();
		addChild(panTop);
		
		panArs = new PanelArsenal();
		addChild(panArs);
		
		panInGame = new PanelInGame();
		addChild(panInGame);
		
		panResult = new PanelResult();
		addChild(panResult);
		
		/*
		var label:Label = new Label("Label 1", 0xFFFFFF, new GlowFilter(0xFF00FF), true);
		label.x = 350;
		label.text = "Азазазаззазазазаззазазаззаз";
		addChild(label);
		*/
	}
	
	private function keyUp(e:KeyboardEvent):Void 
	{
		//debugTextField.text = "released " + Std.string(e.keyCode);
		switch (e.keyCode) 
		{
			case Keyboard.W:		input.flags &= ~InputState.w;
			case Keyboard.A:		input.flags &= ~InputState.a;
			case Keyboard.S:		input.flags &= ~InputState.s;
			case Keyboard.D:		input.flags &= ~InputState.d;
			case Keyboard.SPACE:	input.flags &= ~InputState.sp;
			default:
		}
	}
	
	private function keyDown(e:KeyboardEvent):Void 
	{
		//debugTextField.text = "pressed " + Std.string(e.keyCode);
		switch (e.keyCode) 
		{
			case Keyboard.W:		input.flags |= InputState.w;
			case Keyboard.A:		input.flags |= InputState.a;
			case Keyboard.S:		input.flags |= InputState.s;
			case Keyboard.D:		input.flags |= InputState.d;
			case Keyboard.SPACE:	input.flags |= InputState.sp;			
			case Keyboard.C:		Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, logText);
			default:
		}
	}
	
	private function rightMouseUp(e:MouseEvent):Void 
	{
		
	}
	
	private function rightMouseDown(e:MouseEvent):Void 
	{
		if (world != null) world.paused = false;
	}
	
	private function mouseUp(e:MouseEvent):Void 
	{
		input.flags &= ~InputState.mb;
	}
	
	private function mouseDown(e:MouseEvent):Void 
	{
		input.flags |= InputState.mb;
	}
	
	// мы всегда будем знать где вызывается эта функция
	@:deprecated
	public function log(msg:String) {
		debugTextField.text = msg;
		logText += msg + "\n";
	}
	
}
