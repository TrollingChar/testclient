package hz.company.testclient;
import flash.display.*;
import flash.events.*;
import flash.net.*;
import flash.text.*;
import Std;

/**
 * ...
 * @author Trollingchar
 */
class Connection
{
	var main:Sprite;
	var socket:Socket;
	var host:String;
	var port:Int;
	var connected:Bool;
	
	var id:Int;

	public function new(host:String, port:Int) 
	{
		this.host = host;
		this.port = port;
		connected = false;
		socket = new Socket();
		socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
		socket.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
		socket.addEventListener(ErrorEvent.ERROR, this.onError);
		socket.addEventListener(Event.CONNECT, this.onConnect);
		socket.addEventListener(Event.CLOSE, this.onClose);
		socket.addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
    }
	
	public function connect(id:Int)
	{
		this.id = id;
		socket.connect(host, port);
	}
	
	public function close()
	{
		connected = false;
		socket.close();
	}
	
	public function send(s:String)
	{
		socket.writeUTF(s);
		socket.flush();
	}
	
	function onConnect(e:Event)
	{
		connected = true;
		sendAuth(id);
		
		//var textfield:TextField = new TextField();
		//textfield.width = 960;
		//textfield.height = textfield.y = 100;
		//textfield.text = "кекеке";
		//textfield.textColor = 0x00FF00;
		//textfield.type = TextFieldType.INPUT;
		//
		//main.stage.addChild(textfield);
		//textfield.addEventListener(KeyboardEvent.KEY_DOWN, function(event:KeyboardEvent){
			//if (event.charCode == 13){
				///*var i:Null<Int> = Std.parseInt(textfield.text);
				//trace(textfield.text);
				//if (i != null) {
					//send(Base64Codec.Encode(i));
				//}*/
				//send(textfield.text);
				//textfield.text = "";
			//}
		//});
	}
	
	function onClose(e:Event)
	{
		connected = false;
	}
	
	function onError(e:Event)
	{
		if (!connected) 
		{
			connect(id);
		}
	}
	
	function sendAuth(id:Int) {
		send("0" + Base64Codec.Encode(id));
	}
	
	function sendPing() {
		send("1");
	}
	
	function sendReadyToBattle() {
		send("2");		
	}
	
	function sendCancelBattle() {
		send("3");		
	}
	
	function receiveLoginConfirm() {
		
	}
	
	function receivePing() {
		
	}
	
	function receiveCancelBattle() {
		
	}
	
	function receiveStartBattle() {
		
	}
	
	function onSocketData(e:ProgressEvent)
	{
		var s:String = socket.readUTF();
		trace(s);
		switch (s.charAt(0)) 
		{
			case "0":
				receiveLoginConfirm();
				break;
			case "1":
				receivePing();
				break;
			default:
				
		}
	}
}