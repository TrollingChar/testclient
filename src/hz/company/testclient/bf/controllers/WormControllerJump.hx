package hz.company.testclient.bf.controllers;
import hz.company.testclient.bf.World;
import hz.company.testclient.bf.objects.Object;

/**
 * ...
 * @author 
 */
class WormControllerJump extends Controller
{
	var world:World;
	
	public override function work() {
		object.velocity.y += world.gravity;
		world.wait();
	}
}