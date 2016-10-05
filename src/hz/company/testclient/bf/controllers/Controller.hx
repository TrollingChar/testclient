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
	public var fuse:Int = 20000;
	
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
		if(fuse == 0) 
			fuseCallback();
		else
			work();
		fuse -= 20;
	}
	
	function fuseCallback() {
		work();
	}
	
	function work() 
	{
		object.velocity.y += object.world.gravity;
		Main.I.world.moveObject(object);
	}
}