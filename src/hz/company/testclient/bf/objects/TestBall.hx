package hz.company.testclient.bf.objects;
import flash.display.Shape;
import flash.display.Sprite;
import format.SVG;
import hz.company.testclient.bf.controllers.Controller;
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
	
	override function initColliders() 
	{
		super.initColliders();
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
}