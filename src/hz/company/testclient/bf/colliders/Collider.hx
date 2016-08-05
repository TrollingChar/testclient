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
	
	@:deprecated
	public function update() {
		// recompute cachePoint
	}
	
	public function updateTiles() {
		
	}
	
	public function freeTiles() {
		
	}
	
	public function passableFor(collider:Collider) {
		// объекты не сталкиваются сами с собой
		return collider.object == object;
	}
	
	public function getTop() : Float
	{
		return object.position.y;
	}
	
	public function getLeft() : Float
	{
		return object.position.x;
	}
	
	public function getBottom() : Float
	{
		return object.position.y;
	}
	
	public function getRight() : Float
	{
		return object.position.x;
	}
	
}