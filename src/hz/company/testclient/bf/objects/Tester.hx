package hz.company.testclient.bf.objects;
import hz.company.testclient.bf.colliders.ColliderPoint;
import hz.company.testclient.geom.Point2D;

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
		this.velocity = new Point2D(0, 10);
		// нет спрайта
	}
	
	override function initColliders() 
	{
		addCollider(new ColliderPoint(new Point2D(0, 0)));
	}
	
}