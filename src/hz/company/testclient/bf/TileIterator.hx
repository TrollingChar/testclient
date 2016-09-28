package hz.company.testclient.bf;
import hz.company.testclient.bf.colliders.Collider;

/**
 * ...
 * @author 
 */
class TileIterator
{
	var colliders:List<List<Collider>>;
	
	public static function iterator(left:Float, top:Float, right:Float, bottom:Float):Iterator<Collider> {
		return new TileIterator(left, top, right, bottom);
	}
	
	public function new(left:Float, top:Float, right:Float, bottom:Float) {
		
		// сначала посчитать затронутые тайлы
		var leftTile:Int = Math.ceil(left / Tile.size) - 1;
		var	topTile:Int = Math.ceil(top / Tile.size) - 1;
		var	rightTile:Int = Math.ceil(right / Tile.size);
		var	bottomTile:Int = Math.ceil(bottom / Tile.size);
		
		// затем из каждого достать коллайдеры которые в нем есть
		for (x in leftTile...rightTile+1) 
		{
			for (y in topTile...bottomTile+1) 
			{
				var tile:Tile = Main.I.world.getTileAt(x, y);
				colliders.add(tile.colliders);
				if (tile.land > 0) colliders.add(tile.getLandColliders(Math.floor(left), Math.floor(top), Math.ceil(right), Math.ceil(bottom)));
			}
		}
	}
	
	public function hasNext():Bool {
		return false;
	}
	
	public function next():Collider {
		return null;
	}
}