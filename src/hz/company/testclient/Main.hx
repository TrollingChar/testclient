package hz.company.testclient;

import openfl.filters.GlowFilter;
import openfl.events.Event;
import openfl.geom.Point;
import hz.company.testclient.interf.*;
import hz.company.testclient.bf.World;
import hz.company.testclient.bf.colliders.Collider;
import hz.company.testclient.bf.colliders.ColliderCircle;
import openfl.display.*;
import hz.company.testclient.geom.Point2D;
import openfl.system.Security;
import openfl.text.TextField;

/**
 * ...
 * @author 
 */
class Main extends Sprite 
{
	static public var I:Main;
	
	public var connection:Connection;
	public var id:Int;
	
	public var debugTextField:Label;
	public var panMain:Panel;
	public var panTop:Panel;
	public var panArs:PanelArsenal;
	public var panInGame:PanelInGame;
	public var panConnection:Panel;
	public var panCancel:Panel;
	public var panHelp:Panel;
	public var world:World;

	public function new() 
	{
		super();
		
		I = this;
		
		debugTextField = new Label("test", 0xFFFFFF, new GlowFilter(0x00FFFF), true);
		debugTextField.x = 350;
		debugTextField.y = -25;
		addChild(debugTextField);
		
		panConnection = new PanelConnection();
		addChild(panConnection);
						
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
		
		/*
		var label:Label = new Label("Label 1", 0xFFFFFF, new GlowFilter(0xFF00FF), true);
		label.x = 350;
		label.text = "Азазазаззазазазаззазазаззаз";
		addChild(label);
		*/
	}
	
	public function log(msg:String) {
		debugTextField.text = msg;
	}
	
}
