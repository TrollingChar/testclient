package hz.company.testclient.bf.colliders;
import hz.company.testclient.bf.colliders.ColliderCircle;
import hz.company.testclient.bf.colliders.ColliderPoint;
import hz.company.testclient.bf.colliders.Collision;
import hz.company.testclient.geom.Point2D;

/**
 * ...
 * @author 
 */
class ColliderLine extends Collider
{
	public var offset0:Point2D;
	public var offset1:Point2D;
	public var cachePoint0:Point2D;
	public var cachePoint1:Point2D;

	public function new(point0:Point2D, point1:Point2D) 
	{
		super();
		this.offset0 =
		this.cachePoint0 = point0;
		this.offset1 =
		this.cachePoint1 = point1;
	}
	
	override public function update() 
	{
		cachePoint0 = object.position + offset0;
		cachePoint1 = object.position + offset1;
	}
	
	override public function collideWithCircle(collider:ColliderCircle):Collision 
	{
		return CollisionDetection.circleToLine(collider, this, -object.velocity).reverse();
	}
	
	override public function collideWithPoint(collider:ColliderPoint):Collision 
	{
		return CollisionDetection.pointToLine(collider, this, -object.velocity).reverse();
	}
	
	override public function getTop() : Float
	{
		return Math.min(cachePoint0.y, cachePoint1.y);
	}
	
	override public function getLeft() : Float
	{
		return Math.min(cachePoint0.x, cachePoint1.x);
	}
	
	override public function getBottom() : Float
	{
		return Math.max(cachePoint0.y, cachePoint1.y);		
	}
	
	override public function getRight() : Float
	{
		return Math.max(cachePoint0.x, cachePoint1.x);
	}
		
}