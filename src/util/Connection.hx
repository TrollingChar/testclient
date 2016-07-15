package util;
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
	public var socket:Socket;
	var host:String;
	var port:Int;
	var connected:Bool;

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
	
	public function connect()
	{
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
	}
	
	function onClose(e:Event)
	{
		connected = false;
	}
	
	function onError(e:Event)
	{
		if (!connected) 
		{
			connect();
		}
	}
	
	public function sendAuth(id:Int) {
		send("0" + Base64Codec.Encode(id));
	}
	
	public function sendPing() {
		send("1");
	}
	
	public function sendReady() {
		send("2");		
	}
	
	public function sendNotReady() {
		send("3");		
	}
	
	function onSocketData(e:ProgressEvent)
	{
		/*var s:String = socket.readUTF();
		trace(s);*/
	}
}