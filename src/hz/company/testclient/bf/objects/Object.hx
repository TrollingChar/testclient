package hz.company.testclient.bf.objects;
import hz.company.testclient.bf.colliders.Collider;
import hz.company.testclient.bf.controllers.Controller;
import openfl.display.Sprite;

/**
 * ...
 * @author 
 */
class Object extends Sprite
{
	public var world:World;
	public var colliders:List<Collider>;
	@isVar public var controller(get, set):Controller;
	
	public var x:Float;
	public var y:Float;
	public var vx:Float;
	public var vy:Float;
	
	public function new() 
	{
		
	}
	
	function get_controller():Controller 
	{
		return controller;
	}
	
	function set_controller(value:Controller):Controller 
	{
		if (controller != null) controller.remove();
		return controller = value;
	}
	
	public function onAdd()
	{
		
	}
	
	public function onRemove() 
	{
		
	}
	
	public function add(collider:Collider) {
		colliders.add(collider);
		collider.onAdd();
	}
	
}