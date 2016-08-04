package hz.company.testclient.bf;
import haxe.ds.IntMap;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

/**
 * ...
 * @author 
 */
class Synchronizer
{
	var input:IntMap<InputState>;
	var miss:IntMap<Dynamic>;
	var missCount:Int;
	var nextToReceive:Int;
	var nextToRead:Int;
	var timer:Timer;
	
	public function new() 
	{
		input = new IntMap<InputState>();
		miss = new IntMap<Void>();
		missCount = 1;
		nextToReceive =
		nextToRead = 0;
		miss.set(0, null);
		timer = new Timer(10, 0);
		timer.addEventListener(TimerEvent.TIMER, timerTick);
	}
	
	function void():Void {}
	
	function timerTick(e:TimerEvent):Void 
	{
		for (i in miss.keys()) 
		{
			Main.I.connection.sendRepeat(i);
		}
	}
	
	public function receive(msgId:Int, msg:InputState) {
		input.set(msgId, msg);
		
		if (miss.remove(msgId)) missCount--;
		
		if (msgId == nextToReceive) {
			// reset timeout
			timer.reset();
			timer.start();
		}
		
		if(msgId > nextToReceive) {
			for (i in nextToReceive...msgId) 
			{
				miss.set(i, null);
			}
			missCount += msgId - nextToReceive;
		}
		
		nextToReceive = msgId + 1;
		
		miss.set(nextToReceive, null);
		missCount++;
		
		Main.I.log(Std.string(missCount));
	}
	
	public function shutdown() {
		timer.removeEventListener(TimerEvent.TIMER, timerTick);
	}
	
	public function readNext():InputState {
		if (input.exists(nextToRead)) {
			var state:InputState = input.get(nextToRead);
			input.remove(nextToRead++);
			return state;
		}
		return null;
	}
}