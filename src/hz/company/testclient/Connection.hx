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
		if (!connected) 
		{
			connect(id);
		}
	}
	
	function sendAuth(id:Int) {
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
	
	function receiveStartBattle() {
		
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
				receiveStartBattle();
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