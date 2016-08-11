package hz.company.testclient.bf.objects;
import hz.company.testclient.bf.World;
import hz.company.testclient.bf.colliders.Collider;
import hz.company.testclient.bf.colliders.Collision;
import hz.company.testclient.bf.controllers.Controller;
import hz.company.testclient.geom.Point2D;
import openfl.display.Sprite;

/**
 * ...
 * @author 
 */
class Object // extends Sprite (спрайты добавляются отдельно, объект может вовсе не иметь их)
{
	public var world:World;
	public var colliders:List<Collider>;
	@:isVar public var controller(get, set):Controller;
	
	@:isVar public var position(get, set):Point2D;
	public var velocity:Point2D;
	public var angle(get, set):Float;
	
	public function new() 
	{
		velocity = new Point2D(0, 0);
		colliders = new List<Collider>();
	}
	
	function get_controller():Controller 
	{
		return controller;
	}
	
	function set_controller(value:Controller):Controller 
	{
		if (controller != null) controller.onRemove();
		if (value != null) {
			value.object = this;
			value.onAdd();
		}
		return controller = value;
	}
	
	public function update() {
		controller.update();
	}
	
	public function onAdd()
	{
		initController();
		initColliders();
		renderSprites();
	}
	
	function initController() 
	{
		// controller = new ...
	}
	
	function initColliders() 
	{
		// addCollider(new ...
		// addCollider(new ...
	}
	
	public function addCollider(collider:Collider) {
		collider.object = this;
		colliders.add(collider);
		//collider.updateTiles();
		collider.update();
		world.addCollider(collider);
	}
	
	public function removeCollider(collider:Collider) {
		//collider.freeTiles();
		world.removeCollider(collider);
		colliders.remove(collider);
	}
	
	function renderSprites() 
	{
		
	}
	
	function moveSprites() 
	{
		
	}
	
	function removeSprites() {
		
	}
	
	public function onRemove() 
	{
		removeSprites();
		controller = null;
		while (colliders.length > 0) 
		{
			colliders.pop().freeTiles();
		}
	}
	
	public function onCollision(collision:Collision) 
	{
		
	}
	
	function get_position():Point2D 
	{
		return position;
	}
	
	function set_position(value:Point2D):Point2D 
	{
		position = value;
		for (collider in colliders) 
		{
			collider.update();
		}
		moveSprites();
		return value;
	}
	
	@:deprecated
	public function setVelocity(v:Float) 
	{
		var V:Float = velocity ^ new Point2D(0, 0);
		if (V == 0)
			velocity.y = -v;
		else
			velocity *= v / V;
	}
	
	function get_angle():Float 
	{
		return 0;
	}
	
	function set_angle(value:Float):Float 
	{
		return value;
	}
	
}