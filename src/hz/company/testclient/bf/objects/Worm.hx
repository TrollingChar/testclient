package hz.company.testclient.bf.objects;
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextField;
import hz.company.testclient.bf.Team;
import hz.company.testclient.bf.colliders.ColliderLine;
import hz.company.testclient.bf.colliders.ColliderPoint;
import hz.company.testclient.bf.colliders.Collision;
import hz.company.testclient.bf.colliders.RelationDetection;
import hz.company.testclient.interf.Label;
import openfl.Assets;
import format.SVG;
import hz.company.testclient.bf.controllers.Controller;
import hz.company.testclient.geom.Geometry;
import hz.company.testclient.geom.Point2D;
import openfl.events.Event;

import hz.company.testclient.bf.colliders.ColliderCircle;

/**
 * ...
 * @author 
 */
class Worm extends Object
{
	
	public var hp:Int = 60;
	public var team:Team;
	var sprite:Sprite;
	var labelHp:Label;
	
	public function new() 
	{
		super();
		
		sprite = new Sprite();
		var shape:Shape = new Shape();
		var svg:SVG = new SVG(Assets.getText("img/worm.svg"));
		svg.render(shape.graphics);
		shape.scaleX =
		shape.scaleY = 0.2;
		shape.x =
		shape.y = -5;
		sprite.addChild(shape);
		labelHp = new Label(Std.string(hp), 0x889999, null, false);
		labelHp.scaleX = labelHp.scaleY =  0.3;
		labelHp.x = sprite.x - 45;
		labelHp.y = sprite.y - 23;
		sprite.addChild(labelHp);
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
		//world.paused = true;
		var normal:Point2D = collision.normal;
		var tangential:Point2D = new Point2D(-normal.y, normal.x);
		var convertedVelocity:Point2D = Geometry.convertToBasis(velocity, tangential, normal);
		velocity = tangential * convertedVelocity.x * .45 + normal * convertedVelocity.y * -.25;
	}
	
	override function initColliders()
	{
		addCollider(new ColliderCircle(new Point2D(0, 0), 5));
		addCollider(new ColliderCircle(new Point2D(0, 5), 5));
		addCollider(new ColliderLine(new Point2D(5, 0), new Point2D(5, 5)));
		addCollider(new ColliderLine(new Point2D(-5, 5), new Point2D(-5, 0)));
		
		//addCollider(new ColliderLine(new Point2D(-5, 10), new Point2D(5, 10)));
	}	
	
	public function onAddToTeam() 
	{
		labelHp.color = team.color;
	}
	
	// проверяет землю под указанной точкой
	public function testBelow(point:Point2D):Float {
		var tester:Tester = new Tester(point);
		world.add(tester);
		world.move(tester);
		world.remove(tester);
		return tester.position.y - point.y - 5;
	}
	
	// проверяет землю над указанной точкой
	public function testAbove(point:Point2D):Float {
		return 0;
	}
}