package hz.company.testclient.bf.objects;
import hz.company.testclient.bf.colliders.*;
import hz.company.testclient.geom.*;

/**
 * ...
 * @author 
 */
class Tester extends Object
{

	public function new(position:Point2D) 
	{
		super();
		this.position = position;
		this.velocity = new Point2D(0, 2*Worm.size);
		// нет спрайта
	}
	
	override function initColliders() 
	{
		addCollider(new ColliderCircle(new Point2D(0, 0), Worm.size));
	}
	
}