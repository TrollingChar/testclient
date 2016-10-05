package hz.company.testclient.bf.controllers;

/**
 * ...
 * @author 
 */
class GrenadeController extends Controller
{

	public function new() 
	{
		super();
		fuse = 5000;
	}
	
	override function fuseCallback() 
	{
		Main.I.world.removeObject(object);
	}
	
}