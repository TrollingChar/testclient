package hz.company.testclient.bf.colliders;

/**
 * ...
 * @author 
 */
class ColliderCircle extends Collider
{
	var offset:Point;
	var cachePoint:Point;
	var radius:Float;
	
	public function new() 
	{
		super();
		
	}
	
	override public function collideWithPoint(collider:ColliderPoint):Collision {
		
		
	}
	
	override public function collideWithLine(collider:ColliderLine):Collision {
		
	}
	
	override public function collideWithCircle(collider:ColliderCircle):Collision {
		
	}
	
}