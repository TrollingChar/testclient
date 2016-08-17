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
	public var immediateResponse:Bool;
	
	var id:Int;

	public function new(host:String, port:Int) 
	{
		this.host = host;
		this.port = port;
		connected = false;
		immediateResponse = true;
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
	
	public function onSocketData(e:ProgressEvent) {
		var b:Bool = true;
		while (immediateResponse && b) b = readData();
	}
	
	public function readData():Bool
	{
		try {
			if (socket.bytesAvailable > 0) {
				var s:String = socket.readUTF();
				Main.I.log(s);
				
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
						Main.I.log("Invalid command");
				}
				return true;
			}
			return false;
		} catch (e:Dynamic) {
			//Main.I.world.paused = true;
			Main.I.log("Error: " + Std.string(e));
			return false;
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
		Main.I.receiveAuthConfirm(id);
	}
	
	function receiveCancel() {
		Main.I.receiveCancel();
	}
	
	function receiveStartBattle(s:String) {
		
		var i:Int = Base64Codec.Decode(s.charAt(0));
		
		var teams:IntMap<Team> = new IntMap<Team>();
		Base64Codec.s = s.substring(1);
		for (j in 0...i) 
		{
			var teamId:Int = Base64Codec.DecodeFromString();
			teams.set(teamId, new Team(teamId));
		}
		
		// decode
		Main.I.receiveStartBattle(teams, Base64Codec.DecodeFromString());		
	}
	
	function receiveEndBattle(s:String) 
	{
		Base64Codec.s = s;		
		Main.I.receiveEndBattle(Base64Codec.DecodeFromString());
	}
	
	function receivePlayerLeft(s:String) 
	{
		Base64Codec.s = s;
		Main.I.receivePlayerLeft(Base64Codec.DecodeFromString());
	}
	
	function receiveInput(s:String) 
	{
		Main.I.receiveInput(InputState.parse(s));
	}
	
	function receiveHisTurn(s:String) 
	{
		Base64Codec.s = s;
		Main.I.receiveHisTurn(Base64Codec.DecodeFromString());
		immediateResponse = false;
	}
}