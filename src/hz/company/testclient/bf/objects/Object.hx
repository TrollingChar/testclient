package hz.company.testclient.bf.objects;
import hz.company.testclient.bf.colliders.Collider;
import openfl.display.Sprite;

/**
 * ...
 * @author 
 */
class Object extends Sprite
{
	@isVar public var colliders(get, set):List<Collider>;
	
	public var x:Float;
	public var y:Float;
	public var vx:Float;
	public var vy:Float;
	
	public function new() 
	{
		
	}
	
	function get_colliders():List<Collider> 
	{
		return colliders;
	}
	
	function set_colliders(value:List<Collider>):List<Collider> 
	{
		return colliders = value;
	}
	
}