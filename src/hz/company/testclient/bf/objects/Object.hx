package hz.company.testclient.bf.objects;
import hz.company.testclient.bf.World;
import hz.company.testclient.bf.colliders.Collider;
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
	
	public var position:Point2D;
	public var velocity:Point2D;
	
	public function new() 
	{
		
	}
	
	function get_controller():Controller 
	{
		return controller;
	}
	
	function set_controller(value:Controller):Controller 
	{
		if (controller != null) controller.onRemove();
		value.object = this;
		value.onAdd();
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
		collider.updateTiles();
	}
	
	public function removeCollider(collider:Collider) {
		
	}
	
	function renderSprites() 
	{
		
	}
	
	public function onRemove() 
	{
		controller = null;
	}
	
	public function add(collider:Collider) {
		colliders.add(collider);
		collider.updateTiles();
	}
	
}