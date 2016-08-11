package hz.company.testclient;
import flash.display.*;
import flash.events.*;
import flash.net.*;
import flash.text.*;
import Std;
import haxe.ds.IntMap;
import hz.company.testclient.bf.InputState;
import hz.company.testclient.bf.Team;
import hz.company.testclient.bf.World;

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
		socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
		socket.addEventListener(ErrorEvent.ERROR, onError);
		socket.addEventListener(Event.CONNECT, onConnect);
		socket.addEventListener(Event.CLOSE, onClose);
		socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
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
		sendAuth();
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
	
	function sendAuth() {		
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
		send(Base64Codec.EncodeToChar(ClientCommands.INPUT_DATA) + input.toString());
	}
	
	public function sendSynchronize(alive:Bool) 
	{
		send(Base64Codec.EncodeToChar(ClientCommands.SYNCHRONIZE));// + (alive ? "" : "-"));
	}
	
	public function sendRepeat(msgId:Int) 
	{
		send(Base64Codec.EncodeToChar(ClientCommands.REPEAT) + Base64Codec.Encode(msgId));
	}
	
	function receiveAuthConfirm() {
		Main.I.panConnection.hidden = true;
		Main.I.panMain.hidden = false;
		Main.I.id = id;
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
		//Main.I.panArs.hidden =
		Main.I.panInGame.hidden = false;
		
		var i:Int = Base64Codec.Decode(s.charAt(0));
		
		var teams:IntMap<Team> = new IntMap<Team>();
		Base64Codec.s = s.substring(1);
		for (j in 0...i) 
		{
			var teamId:Int = Base64Codec.DecodeFromString();
			teams.set(teamId, new Team(teamId));
		}
		
		Main.I.random = new Random(Base64Codec.DecodeFromString());
		
		Main.I.world = new World(teams);
		Main.I.addChildAt(Main.I.world, 0);
	}
	
	public function onSocketData(e:ProgressEvent)
	{
		while(socket.bytesAvailable > 0) {
			var s:String = socket.readUTF();
			
			//Main.I.log(s);
			
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
					receiveHisTurn(s);
				case ServerCommands.INPUT_DATA:
					receiveInput(s);
				case ServerCommands.PLAYER_LEFT:
					receivePlayerLeft(s);
				case ServerCommands.END_BATTLE:
					receiveEndBattle(s);
				default:
					
			}
		}
	}
	
	function receiveEndBattle(s:String) 
	{
		Main.I.world.finalize();
		Main.I.removeChild(Main.I.world);
		Base64Codec.s = s;
		var winner:Int = Base64Codec.DecodeFromString();
		if (winner == id) {
			Main.I.panResult.isWin(1);
		}
		else if (winner == 0) {
			Main.I.panResult.isWin(2);
		}
		else {
			Main.I.panResult.isWin(3);
		}
		Main.I.panResult.hidden = false;
	}
	
	function receivePlayerLeft(s:String) 
	{
		Base64Codec.s = s;
		var player:Int = Base64Codec.DecodeFromString();
		if (Main.I.world.activePlayer == player) {
			Main.I.world.changeState();
		}
	}
	
	function receiveInput(s:String) 
	{
		Main.I.world.update(InputState.parse(s));
	}
	
	function receiveHisTurn(s:String) 
	{
		Base64Codec.s = s;
		Main.I.world.activePlayer = Base64Codec.DecodeFromString();
		Main.I.world.syncronized = true;
		Main.I.world.changeState();
	}
}