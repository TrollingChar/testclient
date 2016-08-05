package hz.company.testclient.bf.colliders;
import hz.company.testclient.geom.Point2D;
import openfl.geom.Point;

/**
 * ...
 * @author 
 */
class ColliderPoint extends Collider
{
	var offset:Point2D;
	var cachePoint:Point2D;	

	public function new(offset:Point2D) 
	{
		super();
	}
	
	override public function getTop() : Float
	{
		return cachePoint.y;
	}
	
	override public function getLeft() : Float
	{
		return cachePoint.y;
	}
	
	override public function getBottom() : Float
	{
		return cachePoint.y;
	}
	
	override public function getRight() : Float
	{
		return cachePoint.x;
	}
}