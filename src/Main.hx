package;

import flash.events.*;
import flash.text.*;
import format.*;
import openfl.*;
import openfl.display.*;
import src.interf.*;
import util.*;

/**
 * ...
 * @author 
 */
class Main extends Sprite 
{
	static public var connection:Connection;
	
	public function new()
	{
		super();
		Base64Codec.Init();
			
		var pan:Panel = new Panel();
		addChild(pan);
		//pan.visible = false;
		
		connection = new Connection("localhost", 8080);
		connection.socket.addEventListener(Event.CONNECT, function(e:Event) {
			pan.visible = true;
		});
		connection.socket.addEventListener(ProgressEvent.SOCKET_DATA, function(e:ProgressEvent) {
			pan.text.text = connection.socket.readUTF();
		});
		connection.connect();
	}

}
