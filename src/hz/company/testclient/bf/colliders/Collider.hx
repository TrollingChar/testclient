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
	
	public function collideWithPoint():Collision {
		return null;
	}
	
	public function collideWithLine():Collision {
		return null;
	}
	
	public function collideWithCircle():Collision {
		return null;
	}
	
	public function updateTiles() {
		
	}
	
	public function freeTiles() {
		
	}
	
}