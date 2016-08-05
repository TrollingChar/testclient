package hz.company.testclient.bf.colliders;
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

	public function new() 
	{
		super();
		
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