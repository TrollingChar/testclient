package hz.company.testclient;

import flash.events.Event;
import hz.company.testclient.interf.*;
import openfl.display.*;

/**
 * ...
 * @author 
 */
class Main extends Sprite 
{
	static public var I:Main;
	//public var connection:Connection;
	public var activePan:Panel;
	
	public var panMain:Panel;
	public var panTop:Panel;
	public var panArs:Panel;

	public function new() 
	{
		super();
		
		I = this;
		
		panMain = new PanelMain();
		addChild(panMain);
		
		panTop = new PanelTop();
		addChild(panTop);
		
		panArs = new PanelArsenal();
		addChild(panArs);
	}
	/*
	public function showPanel(pan:Panel) {
		if (activePan != null) {
			activePan.hidden = true;
		}
		activePan = pan;
		if (activePan != null) {
			activePan.hidden = false;
		}
	}*/
	
}
