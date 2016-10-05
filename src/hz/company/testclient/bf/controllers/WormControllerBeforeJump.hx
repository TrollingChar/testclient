package hz.company.testclient.bf.controllers;
import flash.geom.Point;
import hz.company.testclient.bf.objects.Worm;
import hz.company.testclient.geom.Point2D;

/**
 * ...
 * @author 
 */
class WormControllerBeforeJump extends Controller
{
	var v:Point2D;

	public function new() 
	{
		super();
		fuse = 260;
	}
	
	override public function onAdd() 
	{
		var worm:Worm = cast(object, Worm);
		v = worm.velocity;
		worm.velocity %= 0;
		worm.animsprite.showBehavior("before jump");
	}
	
	override function work() 
	{
		// nothing to do;
	}
	
	override function fuseCallback() 
	{
		object.controller = new WormControllerJump();
	}
	
	override public function onRemove() 
	{
		object.velocity = v;
	}
	
}