package hz.company.testclient.bf.controllers;
import hz.company.testclient.bf.World;
import hz.company.testclient.bf.controllers.Controller;
import hz.company.testclient.bf.objects.Object;

/**
 * ...
 * @author 
 */
class Controller
{
	public var object:Object;
	public var fuse:Int = 2000;
	
	public function new() {
		
	}
	
	public function onRemove() 
	{
		
	}
	
	public function onAdd() 
	{
		
	}
	
	public function update() 
	{
		Main.I.log("controller works");
		if(fuse-- == 0) 
			fuseCallback();
		else
			work();
	}
	
	function fuseCallback() {
		work();
	}
	
	function work() 
	{
		object.velocity.y += object.world.gravity;
	}
	
	
	/*
	public var object:Object;
	var map:Map;

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
	*/
}