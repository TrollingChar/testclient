package hz.company.testclient.bf.colliders;
import hz.company.testclient.bf.colliders.*;
import hz.company.testclient.geom.*;
import openfl.geom.*;

/**
 * ...
 * @author 
 */
class ColliderCircle extends Collider
{
	public var offset:Point2D;
	public var cachePoint:Point2D;
	public var radius:Float;
	
	public function new(point:Point2D, radius:Float) 
	{
		super();		
		this.cachePoint = point;
		this.radius = radius;
	}
	
	override public function collideWithPoint(collider:ColliderPoint):Collision 
	{
		return CollisionDetection.pointToCircle(collider, this, -object.velocity).reverse();
	}
	
	override public function collideWithLine(collider:ColliderLine):Collision 
	{
		return CollisionDetection.circleToLine(this, collider, object.velocity);
	}
	
	override public function collideWithCircle(collider:ColliderCircle):Collision
	{
		return CollisionDetection.circleToCircle(this, collider, object.velocity);
	}
	
    override public function getTop() : Float
	{
		return cachePoint.y - radius;
	}
	
	override public function getLeft() : Float
	{
		return cachePoint.x - radius;
	}
	
	override public function getBottom() : Float
	{
		return cachePoint.y + radius;
	}
	
	override public function getRight() : Float
	{
		return cachePoint.x + radius;
	}
	
}