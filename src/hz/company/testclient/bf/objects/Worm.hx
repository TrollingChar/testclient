package hz.company.testclient.bf.objects;
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextField;
import hz.company.testclient.bf.Team;
import hz.company.testclient.bf.colliders.ColliderLine;
import hz.company.testclient.bf.colliders.ColliderPoint;
import hz.company.testclient.bf.colliders.Collision;
import hz.company.testclient.bf.colliders.RelationDetection;
import hz.company.testclient.bf.controllers.WormControllerWalk;
import hz.company.testclient.interf.Label;
import openfl.Assets;
import format.SVG;
import hz.company.testclient.bf.controllers.Controller;
import hz.company.testclient.geom.Geometry;
import hz.company.testclient.geom.Point2D;
import openfl.events.Event;
import spritesheet.AnimatedSprite;
import spritesheet.Spritesheet;
import spritesheet.data.BehaviorData;
import spritesheet.importers.BitmapImporter;

import hz.company.testclient.bf.colliders.ColliderCircle;

/**
 * ...
 * @author 
 */
class Worm extends Object
{	
	public static inline var size = 7;
	
	public var hp:Int = 60;
	public var team:Team;
	@:isVar public var facingRight(get, set):Bool;
	
	var sprite:Sprite;
	var wormAndWeapon:Sprite;
	var animsprite:AnimatedSprite;
	var labelHp:Label;
	
	public function new() 
	{
		super();
		
		sprite = new Sprite();
		
		wormAndWeapon = new Sprite();
		sprite.addChild(wormAndWeapon);
		
		// temporary shape
		//var shape:Shape = new Shape();
		//var svg:SVG = new SVG(Assets.getText("img/worm.svg"));
		//svg.render(shape.graphics);
		//shape.scaleX =
		//shape.scaleY = 0.4;
		//shape.x =
		//shape.y = -size;
		//sprite.addChild(shape);
		
		// new sprite
		var sheet:Spritesheet = BitmapImporter.create(Assets.getBitmapData("img/worm.png"), 6, 1, 128, 128);
		sheet.addBehavior(new BehaviorData("stand", [0, 1, 2, 3, 4, 5, 5, 4, 3, 2, 1, 0], true, 100));
		//sheet.addBehavior(new BehaviorData("walk", [0]));
		animsprite = new AnimatedSprite(sheet, true);
		animsprite.showBehavior("stand");
		wormAndWeapon.addChild(animsprite);
		
		wormAndWeapon.scaleX =
		wormAndWeapon.scaleY = 0.4;
		wormAndWeapon.x = wormAndWeapon.width * -.5;
		wormAndWeapon.y = wormAndWeapon.height * -.5;
		
		labelHp = new Label(Std.string(hp), 0x889999, null, false);
		labelHp.scaleX = labelHp.scaleY =  	0.5;
		labelHp.x = sprite.x - 150 * 0.5;
		labelHp.y = sprite.y - size * 10;
		sprite.addChild(labelHp);
	}
	
	override function initController() 
	{
		controller = new WormControllerWalk();
	}
	
	override function renderSprites() 
	{
		sprite.x = position.x;
		sprite.y = position.y;
		world.layers[Layers.PROJECTILE].addChild(sprite);
	}
	
	override function updateSprites() 
	{
		animsprite.update(20);
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
		controller = new WormControllerWalk();
		//var normal:Point2D = collision.normal;
		//var tangential:Point2D = new Point2D(-normal.y, normal.x);
		//var convertedVelocity:Point2D = Geometry.convertToBasis(velocity, tangential, normal);
		//velocity = tangential * convertedVelocity.x * .45 + normal * convertedVelocity.y * -.25;
	}
	
	override function initColliders()
	{
		addCollider(new ColliderCircle(new Point2D(0, 0), size));
		addCollider(new ColliderCircle(new Point2D(0, size), size));
		addCollider(new ColliderLine(new Point2D(size, 0), new Point2D(size, size)));
		addCollider(new ColliderLine(new Point2D(-size, size), new Point2D(-size, 0)));
		
		//addCollider(new ColliderLine(new Point2D(-5, 10), new Point2D(5, 10)));
	}	
	
	public function onAddToTeam() 
	{
		labelHp.color = team.color;
	}
	
	// проверяет землю под указанной точкой
	public static function testBelow(point:Point2D, world:World):Float {
		var tester:Tester = new Tester(point);
		world.addObject(tester);
		world.moveObject(tester);
		world.removeObject(tester);
		return tester.position.y - point.y - size;	
	}
	
	// проверяет землю над указанной точкой
	public function testAbove(point:Point2D):Float {
		return 0;
	}
	
	function get_facingRight():Bool 
	{
		return facingRight;
	}
	
	function set_facingRight(value:Bool):Bool 
	{
		if (facingRight != value) sprite.scaleX *= -1;
		return facingRight = value;
	}
}