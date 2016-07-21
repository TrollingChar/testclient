package hz.company.testclient.bf.camera;
import hz.company.testclient.bf.World;
import openfl.geom.Point;

/**
 * ...
 * @author 
 */
class Camera
{
	var world:World;
	var view:Point;
	var target:Point;

	public function new(world:World, view:Point) 
	{
		this.world = world;
		target = this.view = view;
	}
	
	public function update() {
		
	}
	
	public function getView():Point {
		return view;
	}
	
	public function lookAt(target:Point) {
		this.target = target;
	}
	
}