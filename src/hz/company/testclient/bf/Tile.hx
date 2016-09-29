package hz.company.testclient.bf;
import hz.company.testclient.bf.colliders.Collider;
import hz.company.testclient.bf.colliders.ColliderLine;
import hz.company.testclient.bf.colliders.ColliderPoint;
import hz.company.testclient.geom.Point2D;

/**
 * ...
 * @author I'm
 */
class Tile
{
	static public inline var size:Int = 20;
	public var x:Int;
	public var y:Int;						// координаты тайла
	public var empty:Bool;					// если тайл пуст, то не надо его запоминать в хеш-таблицу
	//public var colliders:List<Collider>;	// коллайдеры, находящиеся здесь
	//public var landColliders:List<Collider>;// коллайдеры земли, находящиеся здесь
	public var land:Int;					// число пикселей земли которые находятся в тайле
	
	public function new(x:Int, y:Int) 
	{
		this.x = x;
		this.y = y;
		empty = true;
		land = 0;
		//colliders = new List<Collider>();
	}
	
	public function recomputeLand() 
	{
		land = 0;
		for (_x in 0...size) 
		{
			for (_y in 0...size) 
			{
				if (Main.I.world.isLand(_x + x * size, _y + y * size)) land++;
			}
		}
		if(land > 0 && empty) {
			Main.I.world.addTile(this);
			empty = false;
		}
	}
	
	public function addCollider(collider:Collider) {
		//colliders.add(collider);
		//if (empty) {
			//Main.I.world.addTile(this);
			//empty = false;
		//}
	}
	
	public function removeCollider(collider:Collider) {
		//colliders.remove(collider);
	}
	
	public function getLandColliders(left:Int, top:Int, right:Int, bottom:Int):List<Collider>
	{		
		if (land == 0) {
			Main.I.log("empty tile");
			return new List<Collider>();
		}
		
		var result:List<Collider> = new List<Collider>();
		if (land == size * size) {
			result.add(new ColliderPoint(new Point2D(x, y) * size));
			result.add(new ColliderPoint(new Point2D(x + 1, y) * size));
			result.add(new ColliderPoint(new Point2D(x, y + 1) * size));
			result.add(new ColliderPoint(new Point2D(x + 1, y + 1) * size));
			result.add(new ColliderLine(new Point2D(x, y) * size, new Point2D(x + 1, y) * size));
			result.add(new ColliderLine(new Point2D(x + 1, y) * size, new Point2D(x + 1, y + 1) * size));
			result.add(new ColliderLine(new Point2D(x + 1, y + 1) * size, new Point2D(x, y + 1) * size));
			result.add(new ColliderLine(new Point2D(x, y + 1) * size, new Point2D(x, y) * size));
			return result;
		}
		
		if (left < x * size) 
			left = x * size;
		if (top < y * size)
			top = y * size;
		if (right > (x + 1) * size)
			right = (x + 1) * size;
		if (bottom > (y + 1) * size)
			bottom = (y + 1) * size;
		
		
		// обходим точки
		for (_x in left...right+1) 
		{
			for (_y in top...bottom+1) 
			{
				var count:Int = 0;
				if (Main.I.world.isLand(_x, _y)) count++;
				if (Main.I.world.isLand(_x - 1, _y)) count++;
				if (Main.I.world.isLand(_x, _y - 1)) count++;
				if (Main.I.world.isLand(_x - 1, _y - 1)) count++;
				
				if (count == 1) result.add(new ColliderPoint(new Point2D(_x, _y)));
			}
		}
		
		//обходим горизонтальные линии
		for (_x in left...right) 
		{
			for (_y in top...bottom+1) 
			{	
				if (Main.I.world.isLand(_x, _y) && !Main.I.world.isLand(_x, _y - 1)) result.add(new ColliderLine(new Point2D(_x, _y), new Point2D(_x + 1, _y)));
				if (!Main.I.world.isLand(_x, _y) && Main.I.world.isLand(_x, _y - 1)) result.add(new ColliderLine(new Point2D(_x + 1, _y), new Point2D(_x, _y)));
			}
		}
		
		// обходим вертикальные линии
		for (_x in left...right+1) 
		{
			for (_y in top...bottom) 
			{
				if (Main.I.world.isLand(_x, _y) && !Main.I.world.isLand(_x - 1, _y)) result.add(new ColliderLine(new Point2D(_x, _y + 1), new Point2D(_x, _y)));
				if (!Main.I.world.isLand(_x, _y) && Main.I.world.isLand(_x - 1, _y)) result.add(new ColliderLine(new Point2D(_x, _y), new Point2D(_x, _y + 1)));
			}
		}
		
		return result;
	}
}