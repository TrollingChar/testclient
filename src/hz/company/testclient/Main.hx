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
	
	public var pan1:Panel;
	public var pan2:Panel;
	public var pan3:Panel;

	public function new() 
	{
		super();
		
		I = this;
		pan1 = new Panel();
		pan2 = new Panel();
		pan3 = new Panel();
		addChild(pan1);
		addChild(pan2);
		addChild(pan3);
	}
	
	public function showRandom() {
		/*if (activePan != null) {
			activePan.hidden = true;
		}*/
		if (Math.random() < 1.0 / 3.0) {
			//activePan = pan1;
			pan1.hidden = false;
			pan2.hidden =
			pan3.hidden = true;
		} else if (Math.random() < 0.5) {
			//activePan = pan2;
			pan2.hidden = false;
			pan1.hidden =
			pan3.hidden = true;
		} else {
			//activePan = pan3;
			pan3.hidden = false;
			pan2.hidden =
			pan1.hidden = true;
		}
		//activePan.hidden = false;
	}

}
