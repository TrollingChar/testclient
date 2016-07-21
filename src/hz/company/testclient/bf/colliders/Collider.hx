package hz.company.testclient.bf.colliders;
import hz.company.testclient.bf.Tile;
import hz.company.testclient.bf.objects.Object;

/**
 * ...
 * @author 
 */
class Collider
{
	public var object:Object;
	var tiles:List<Tile>;

	public function new() 
	{
		
	}
	
	public function collideWithPoint(collider:ColliderPoint):Collision {
		return null;
	}
	
	public function collideWithLine(collider:ColliderLine):Collision {
		return null;
	}
	
	public function collideWithCircle(collider:ColliderCircle):Collision {
		return null;
	}
	
	public function updateTiles() {
		
	}
	
	public function freeTiles() {
		
	}
	
}