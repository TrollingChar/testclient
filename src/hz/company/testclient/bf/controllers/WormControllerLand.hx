package hz.company.testclient.bf.controllers;
import hz.company.testclient.bf.objects.Worm;

/**
 * ...
 * @author 
 */
class WormControllerLand extends Controller
{
	
	public function new() 
	{
		super();
		fuse = 380;
	}
	
	override public function onAdd() 
	{
		var worm:Worm = cast(object, Worm);
		worm.velocity %= 0;
		worm.animsprite.showBehavior("land");
	}
	
	override function work() 
	{
		// nothing to do;
	}
	
	override function fuseCallback() 
	{
		object.controller = new WormControllerWalk();
	}
	
}