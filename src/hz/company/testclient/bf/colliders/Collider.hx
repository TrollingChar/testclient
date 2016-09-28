package hz.company.testclient.bf.colliders;
import hz.company.testclient.bf.Tile;
import hz.company.testclient.bf.objects.Object;
import hz.company.testclient.geom.Point2D;

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
	
	public function relationToPoint(collider:ColliderPoint):Float {
		return 0;
	}
	
	public function relationToLine(collider:ColliderLine):Float {
		return 0;
	}
	
	public function relationToCircle(collider:ColliderCircle):Float {
		return 0;
	}
	
	
	public function update() {
		// recompute cachePoint
		freeTiles();
		markTiles();
	}
	
	public function test(objectPosition:Point2D) {
		
	}
	
	public function markTiles() {
		// сначала посчитать затронутые тайлы
		var leftTile:Int = Math.ceil(getLeft() / Tile.size) - 1;
		var	topTile:Int = Math.ceil(getTop() / Tile.size) - 1;
		var	rightTile:Int = Math.ceil(getRight() / Tile.size);
		var	bottomTile:Int = Math.ceil(getBottom() / Tile.size);
		
		// затем в каждый записать наш коллайдер
		for (x in leftTile...rightTile+1) 
		{
			for (y in topTile...bottomTile+1) 
			{
				var tile:Tile = Main.I.world.getTileAt(x, y);
				tile.addCollider(this);
				tiles.add(tile);
			}
		}
	}
	
	public function freeTiles() {
		for (tile in tiles) tile.removeCollider(this);
		tiles.clear();
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