package hz.company.testclient.bf.colliders;
import hz.company.testclient.geom.Geometry;
import hz.company.testclient.geom.Point2D;

/**
 * ...
 * @author 
 */
class RelationDetection
{
	public static function pointToLine(point:ColliderPoint, line:ColliderLine):Float {
		var a:Point2D = line.cachePoint0;
		var b:Point2D = line.cachePoint1;
		var c:Point2D = point.cachePoint;
		
		var ab:Float = a ^ b;
		if (ab == 0) return 0;
		
		var i:Point2D = (b - a) / ab;
		var j:Point2D = new Point2D(-i.y, i.x);	// 90° по часовой стрелке
		
		// раскладываем вектор c-a по базису векторов (i, j)
		var ac_ij:Point2D = Geometry.convertToBasis(a - c, i, j);
		
		return ac_ij.y;
	}
	
	public static function pointToCircle(point:ColliderPoint, circle:ColliderCircle):Float {
		var dist:Float = point.cachePoint ^ circle.cachePoint;
		return dist - circle.radius;
	}

	public static function circleToLine(circle:ColliderCircle, line:ColliderLine):Float {
		var a:Point2D = line.cachePoint0;
		var b:Point2D = line.cachePoint1;
		var c:Point2D = circle.cachePoint;
		
		var ab:Float = a ^ b;
		if (ab == 0) return 0;
		
		var i:Point2D = (b - a) / ab;
		var j:Point2D = new Point2D(-i.y, i.x);	// 90° по часовой стрелке
		
		// раскладываем вектор c-a по базису векторов (i, j)
		var ac_ij:Point2D = Geometry.convertToBasis(a - c, i, j);
		
		return ac_ij.y - circle.radius;		
	}
	
	public static function circleToCircle(circle0:ColliderCircle, circle1:ColliderCircle):Float {
		var dist:Float = circle0.cachePoint ^ circle1.cachePoint;
		var radii:Float = circle0.radius + circle1.radius;
		return dist - radii;
	}
	
}