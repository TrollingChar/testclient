package hz.company.testclient;

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
	
	public var debugTextField:TextField;
	public var panMain:Panel;
	public var panTop:Panel;
	public var panArs:Panel;
	public var panInGame:Panel;
	public var panConnection:Panel;
	public var panCancel:Panel;
	public var panHelp:Panel;
	public var world:World;

	public function new() 
	{
		super();
		
		I = this;
		Random.init(0);
		
		debugTextField = new TextField();
		debugTextField.text = "test";
		debugTextField.width = 1000;
		debugTextField.height = 600;
		addChild(debugTextField);
		
		panConnection = new PanelConnection();
		addChild(panConnection);
		
		
		//world = new World();
		//addChild(world);
		//
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
	}
	
	public function log(msg:String) {
		// здесь мы выводим сообщение о том, что именно пошло не так
	}
	
}
