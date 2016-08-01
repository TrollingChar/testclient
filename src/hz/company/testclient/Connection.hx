package hz.company.testclient;
import flash.display.*;
import flash.events.*;
import flash.net.*;
import flash.text.*;
import Std;
import hz.company.testclient.bf.InputState;

/**
 * ...
 * @author Trollingchar
 */
class Connection
{
	var socket:Socket;
	var host:String;
	var port:Int;
	public var connected:Bool;
	
	var id:Int;

	public function new(host:String, port:Int) 
	{
		//Main.I.debugTextField.text = "entering connection.new";
		this.host = host;
		this.port = port;
		connected = false;
		socket = new Socket();
		socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
		socket.addEventListener(ErrorEvent.ERROR, onError);
		socket.addEventListener(Event.CONNECT, onConnect);
		socket.addEventListener(Event.CLOSE, onClose);
		socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
		//Main.I.debugTextField.text = "leaving connection.new";
    }
	
	public function connect(id:Int)
	{
		//Main.I.debugTextField.text = "preparing to connect";
		this.id = id;
		socket.connect(host, port);
		//Main.I.debugTextField.text = "connecting";
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
		//Main.I.debugTextField.text = "connected";
		connected = true;
		sendAuth();

		//var textfield:TextField = new TextField();
		//textfield.width = 960;
		//textfield.height = textfield.y = 100;
		//textfield.text = "кекеке";
		//textfield.textColor = 0x00FF00;
		//textfield.type = TextFieldType.INPUT;
		//
		//Main.I.panConnection.addChild(textfield);
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
		//Main.I.debugTextField.text = "error!";
		if (!connected) 
		{
			connect(id);
		}
	}
	
	function sendAuth() {		
		//Main.I.debugTextField.text = "sending auth data";
		send(Base64Codec.EncodeToChar(ClientCommands.AUTHORIZE) + Base64Codec.Encode(id));
	}
	
	public function sendPing() {
		send("");
	}
	
	public function sendToBattle() {
		send(Base64Codec.EncodeToChar(ClientCommands.TO_BATTLE));
	}
	
	public function sendCancel() {
		send(Base64Codec.EncodeToChar(ClientCommands.CANCEL));		
	}
	
	public function sendInput(input:InputState) {
		// сделать в классе InputState
		send(Base64Codec.EncodeToChar(ClientCommands.INPUT_DATA));
	}
	
	function receiveAuthConfirm() {
		Main.I.panConnection.hidden = true;
		Main.I.panMain.hidden = false;
	}
	
	function receiveCancel() {
		Main.I.panCancel.hidden = true;
		Main.I.panMain.hidden = false;
	}
	
	function receiveStartBattle(s:String) {
		Main.I.panCancel.hidden =
		Main.I.panMain.hidden = true;
		Main.I.panCancel.position =
		Main.I.panMain.position = 0;
		Main.I.panArs.hidden = false;
		Main.I.panInGame.hidden = false;
		
		Main.I.debugTextField.text = "Начать игру между игроками:\n";
		var i:Int = Base64Codec.Decode(s.charAt(0));
		Base64Codec.s = s.substring(1);
		for (j in 0...i) 
		{
			Main.I.debugTextField.text += " Игрок #" + Std.string(Base64Codec.DecodeFromString()) + "\n";
		}
	}
	
	function onSocketData(e:ProgressEvent)
	{
		var s:String = socket.readUTF();
		
		Main.I.debugTextField.text = s;
		
		var cmd:Int = Base64Codec.Decode(s.charAt(0));
		s = s.substring(1);
		
		switch (cmd) 
		{
			case ServerCommands.AUTH_CONFIRM:
				receiveAuthConfirm();
			case ServerCommands.START_BATTLE:
				receiveStartBattle(s);
			case ServerCommands.CANCEL:
				receiveCancel();
			case ServerCommands.HIS_TURN:
				receiveHisTurn();
			case ServerCommands.INPUT_DATA:
				receiveInput();
			case ServerCommands.PLAYER_LEFT:
				receivePlayerLeft();
			case ServerCommands.END_BATTLE:
				receiveEndBattle();
			default:
				
		}
	}
	
	function receiveEndBattle() 
	{
		
	}
	
	function receivePlayerLeft() 
	{
		
	}
	
	function receiveInput() 
	{
		
	}
	
	function receiveHisTurn() 
	{
		
	}
}