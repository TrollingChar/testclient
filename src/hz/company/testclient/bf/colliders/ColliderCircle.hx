package hz.company.testclient.bf.colliders;
import openfl.geom.Point;

/**
 * ...
 * @author 
 */
class ColliderCircle extends Collider
{
	public var offset:Point;
	public var cachePoint:Point;
	public var radius:Float;
	
	public function new() 
	{
		super();		
	}
	
	override public function collideWithCircle(collider:ColliderCircle):Collision {
		//
		//if ((this.radius == 0) && (collider.radius == 0))
			//return null;
		//
		//if ((((collider.cachePoint.x - this.cachePoint.x) * this.object.vx) + 
		//((collider.cachePoint.y - this.cachePoint.y) * this.object.vy)) < 0)
			//return 0;
		//
		//var v:Float = Math.sqrt(this.object.vx * this.object.x +
		                        //this.object.vy * this.object.vy);
		//
		//var a:Float = Math.sqrt( Math.pow((this.cachePoint.x - collider.cachePoint.x), 2) + 
		                         //Math.pow((this.cachePoint.y - collider.cachePoint.y), 2));
		//
		//var b:Float = Math.sqrt( Math.pow((this.cachePoint.x + this.object.vx - collider.cachePoint.x), 2) +
		                         //Math.pow((this.cachePoint.y + this.object.vy - collider.cachePoint.y), 2));
								 //
		//var p:Float = (a + b + v) / 2;
		//var S:Float = Math.sqrt(p * (p - a) * (p - b) * (p - v));
		//var h:Flaot = (2 * S) / v;
		//
		//if ((this.radius + collider.radius) > h)
			//return null;
		//
		//var d:Float = Math.sqrt(a * a - h * h) - Math.sqrt(Math.pow(this.radius + collider.radius) - h * h);
		//
		//if ((d < 0) || (d >= v))
			//return null;
				                   //
		//if (Math.isNaN(d))
			//return null;
		//
		//if (d)
		//{
			//this.cachePoint.x += this.object.vx * d / v;
			//this.cachePoint.y += this.object.vy * d / v;
		//}
		//
		//if ((Math.isNaN(this.cachePoint.x) || (Math.isNaN(collider.cachePoint.x))
			//return null;
		//
		//return new Collision(/* Parametrs */);
		
		return null;
	}
	
}