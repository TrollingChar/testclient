package hz.company.testclient.bf.objects;
import flash.display.Shape;
import flash.display.Sprite;
import format.SVG;
import hz.company.testclient.bf.colliders.ColliderCircle;
import hz.company.testclient.bf.colliders.Collision;
import hz.company.testclient.bf.controllers.Controller;
import hz.company.testclient.geom.Geometry;
import hz.company.testclient.geom.Point2D;
import openfl.Assets;

/**
 * ...
 * @author I'm
 */
class TestBall extends Object
{
	var sprite:Sprite;

	public function new() 
	{
		super();
		
		sprite = new Sprite();
		var shape:Shape = new Shape();
		var svg:SVG = new SVG(Assets.getText("img/ball.svg"));
		svg.render(shape.graphics);
		shape.scaleX =
		shape.scaleY = .2;
		shape.x =
		shape.y = -5;
		sprite.addChild(shape);
	}
	
	override function initController() 
	{
		controller = new Controller();
	}
	
	override function renderSprites() 
	{
		sprite.x = position.x;
		sprite.y = position.y;
		world.layers[Layers.PROJECTILE].addChild(sprite);
	}
	
	override function removeSprites() 
	{
		world.layers[Layers.PROJECTILE].removeChild(sprite);
	}
	
	override function moveSprites() 
	{
		sprite.x = position.x;
		sprite.y = position.y;
	}
	
	override public function onCollision(collision:Collision) 
	{
		var normal:Point2D = collision.normal;
		var tangential:Point2D = new Point2D(-normal.y, normal.x);
		var convertedVelocity:Point2D = Geometry.convertToBasis(velocity, tangential, normal);
		velocity = tangential * convertedVelocity.x * .9 + normal * convertedVelocity.y * -.5;
	}
	
	override function initColliders()
	{
		addCollider(new ColliderCircle(new Point2D(0, 0), 5));
	}
}