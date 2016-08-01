package hz.company.testclient.bf.controllers;
import hz.company.testclient.bf.objects.Object;

/**
 * ...
 * @author 
 */
class Controller
{
	public var object:Object;
	public var fuse:Int = 2000;
	var map:Map;
	var bounceForbidX:Float,
	var bounceForbidY:Float,
	var bounceForbidR:Float;

	public function new(object:Object) 
	{
		obj = object;
		map = obj.map;
		//map.addEventListener(Event.ENTER_FRAME, _work);
	}
	
	public function onAdd()
	{
		
	}
	
	public function onRemove() 
	{
		
	}
	
	public function update() 
	{
		
	}
	
	function fuseCallback() {
		work();
	}
	
	public function update() {
		if(fuse-- == 0) 
			fuseCallback();
		else
			work();
	}
		
	public function work() {}
		
	public function die() {
		//map.removeEventListener(Event.ENTER_FRAME, _work);
	}
}