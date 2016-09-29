package hz.company.testclient.bf.objects;
import hz.company.testclient.bf.World;
import hz.company.testclient.bf.colliders.*;
import hz.company.testclient.geom.*;

/**
 * ...
 * @author 
 */
class Tester extends Object
{
	public var relativePath:Float = 0;

	public function new(position:Point2D, velocity:Point2D) 
	{
		super();
		this.position = position;
		this.velocity = velocity;
		//this.velocity = new Point2D(0, 2*Worm.size);
		// нет спрайта, нечего добавлять
	}
	
	public function test():Float {
		var world:World = Main.I.world;
		relativePath = 1;
		world.addObject(this);
		world.moveObject(this);
		world.removeObject(this);
		return relativePath;
	}
	
	override public function onCollision(collision:Collision) 
	{
		relativePath = collision.relativePath;
	}
	
	override function initColliders() 
	{
		addCollider(new ColliderCircle(new Point2D(0, 0), Worm.size));
	}
	
}