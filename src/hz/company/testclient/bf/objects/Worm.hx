package hz.company.testclient.bf.objects;
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextField;
import hz.company.testclient.bf.Team;
import hz.company.testclient.bf.colliders.Collision;
import hz.company.testclient.bf.controllers.WormControllerJump;
import hz.company.testclient.interf.Label;
import openfl.Assets;
import format.SVG;
import hz.company.testclient.bf.controllers.Controller;
import hz.company.testclient.geom.Geometry;
import hz.company.testclient.geom.Point2D;

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
	var hplabel:Label;
	
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
		hplabel = new Label(Std.string(hp), 0x889999, null, false);
		hplabel.scaleX = hplabel.scaleY =  0.3;
		hplabel.x = sprite.x - 45;
		hplabel.y = sprite.y - 23;
		sprite.addChild(hplabel);
	}
	
	override function initController() 
	{
		controller = new WormControllerJump();
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
	
	
	public function onAddToTeam() 
	{
		
	}
	
	/*
	var wormMask:Array;
	public var mc:WormMC;
	public var tf:TextField;
	public var tfName:TextField;
	public var inverted:Bool;
	public var handleCollision:Bool;
	public var name:String;
	public var dmgOverTime:Int;
	public static inline var head:Float = 5;
	public static inline var body:Float = 5;
	public static inline var dangerSpeed:Float = 12;
		
	public function new(hp:Int, name:String = "Червяк") 
	{
		super();
		vx = vy = 0;
		hp = this.hp;
		this.name = name;
		handleCollision = true;
	}
	
	public function onAddToTeam() {
		
	}
		
	//// head radius = 5, dist = 5
	//public override function occupies(x:Int, y:Int) {			
		////return(this.x-x)*(this.x-x) + (this.y-y)*(this.y-y) < 100;
		//if(this.x-x > head) return false;
		//if(x-this.x > head) return false;
		//if(y-this.y > 0 && y-this.y < body) return true;
		//if((this.x-x)*(this.x-x) + (this.y-y)*(this.y-y) < head*head) return true;
		//y -= body;
		//if((this.x-x)*(this.x-x) + (this.y-y)*(this.y-y) < head*head) return true;
		//return false;
	//}

	public override function addTo(map:Map) {
		super.addTo(map);
		mc = new WormMC();
		inverted = Math.random() < .5;
		mc.x = x;
		mc.y = y;
		map.layers[Layers.WORM].addChild(mc);		
			
		var myFormat:TextFormat = new TextFormat();
		myFormat.size = 16;
		//myFormat.bold = true;
		myFormat.align = TextFormatAlign.CENTER;
			
		tf = new TextField();
		tf.defaultTextFormat = myFormat;
		tf.x = x-80;
		tf.y = y-30;
		tf.width = 160;
		tf.height = 60;
		tf.textColor = 0x999999;
		tf.selectable = false;
		tf.text = 'NULL';
		//tf.border = true;
		hp = hp;
		map.layers[Layers.TEXT].addChild(tf);
			
			
		tfName = new TextField();
		tfName.defaultTextFormat = myFormat;
		tfName.x = x-80;
		tfName.y = y-50;
		tfName.width = 160;
		tfName.height = 60;
		tfName.textColor = 0x999999;
		tfName.selectable = false;
		tfName.text = _name;
		//tf.border = true;
		map.layers[Layers.TEXT].addChild(tfName);
			
		controller = new WormControllerJump(this);
	}
		
	public function set inverted(val:Bool) {
		inverted = val;
		if(mc) mc.scaleX = inverted ? -1 : 1;			
	}
		
	public function get inverted() {
		return inverted;
	}
		
	public override function set x(val:Float) { 
		x = val;
		if(mc) mc.x = Math.ceil(val);
		if(tf) tf.x = Math.ceil(val)-80;
		if(tfName) tfName.x = Math.ceil(val)-80;
	}
		
	public override function set y(val:Float) { 
		y = val;
		if(mc) mc.y = Math.ceil(val);
		if(tf) tf.y = Math.ceil(val)-30;
		if(tfName) tfName.y = Math.ceil(val)-50;
	}
		
	public function get hp():Int {
		return this.hp;
	}
		
	public function set hp(val:Int) {
		hp = val > 0 ? val : 0;
		hpLabelUpdate();
		return;
	}
		
	public function get dmgOverTime():Int {
		return this.dmgOverTime;
	}
		
	public function set dmgOverTime(val:Int) {
		this.dmgOverTime = val;
		hpLabelUpdate();
		return;
	}
		
	public override function applyPoison(dose:Int, cap:Bool = true) {
		if(cap && (dmgOverTime >= dose)) return;
		dmgOverTime += dose;
		if(cap && (dmgOverTime > dose)) dmgOverTime = dose;
	}
		
	function hpLabelUpdate() {
		if(tf) tf.text = _hp.toString() + (dmgOverTime ? (' (' + (-dmgOverTime).toString() + ')') : '');
	}
		
	public override function explode() {
		var map = this.map;
		die();
		new Explosion().play();
		map.makeHole(x, y+head, 30);
		map.makeBlast(x, y+head+body, 60, 5);
		map.dealDamage(x, y+head, 60, 19, 15);
		map.makeSmoke(x, y+head, 50);
	}
		
	public override function die() {
		if(map) {
			map.layers[Layers.WORM].removeChild(mc);
			map.layers[Layers.TEXT].removeChild(tf);
			map.layers[Layers.TEXT].removeChild(tfName);
			if(this == map.activeWorm) map.setRetreat(0);
		}
		var temp:Worm = this;
		if(team) {
			if(this == team.currentWorm) team.switchWorm();
			team.worms = team.worms.filter(function(worm, id, arr) { return temp != worm; });
		}
		super.die();
	}
		
	public function collided(x:Float, y:Float) {
		for(row in Math.ceil(y+head+body)...Math.floor(y-head)) {
			for(col in Math.floor(x-head)...Math.ceil(x+head)) {
				if(occupies(col-x+this.x, row-y+this.y) && map.isLand(col, row))
					return true;
				}
			}
		return false;			
	}
		
		public function checkBelow(x:Float, y:Float) {
			var l:Float = y;
			y += body-5;
			var left:Int = Math.ceil(x-head),
			var right:Int = Math.floor(x+head),
			var top:Int = Math.ceil(y-head),
			var bottom:Int = Math.floor(y+head+10);
				
			var minDist:Float = 10;
			
			//filter objects
			var w:Object = this;
			var objects:Array = map.objects.filter(function(obj, id, arr) {					
				return !(
					(obj as _Object).hitTestCircle(w.x, w.y, head) ||
					(obj as _Object).hitTestCircle(w.x, w.y+body, head) ||
					(obj as _Object).hitTestRectangle(w.x-head, w.y, w.x+head, w.y+body)
				);
			});
			
			var temp:CollisionParams;
			for each(var obj:_Object in objects) {
				temp = obj.getCircleCollision(x, y, head, 0, 10);
				if(temp) if(temp.d < minDist) minDist = temp.d;
			}
			
			//find
			for(row in top...bottom) {
				for(col in left...right) {
					if(!map.isLand(col, row)) continue;
					var dx:Float = col-x,
					var dy:Float = row-y,
					var d:Float = Math.sqrt(dx*dx+dy*dy);
					if(d < head) {
						return -5;
					}
					if(dy < 0) continue;
					var d = dy - Math.sqrt(head*head - dx*dx)
					
					if(d < minDist) minDist = d;
				}
			}
			minDist -= 5 + 1.0e-9;
			
			//trace(controller);
			//trace(minDist);
			
			y = _ + minDist;
			top = Math.ceil(y-head);
			bottom = Math.floor(y+head+10);
			
			// verify
			for each(var obj:_Object in objects) {				
				if(
					(obj as _Object).hitTestCircle(x, y, head) ||
					(obj as _Object).hitTestCircle(x, y+body, head) ||
					(obj as _Object).hitTestRectangle(x-head, y, x+head, y+body)
				) return -5;
			}
			
			for(var row:int = top; row <= bottom; row++) {
				for(var col:int = left; col <= right; col++) {
					if(!map.isLand(col, row)) continue;
					if(row-y > 0 && row-y < body) {
						return -5;
					}
					if((col-x)*(col-x) + (row-y)*(row-y) < head*head) {
						return -5;
					}
					//do not check lower circle
					//if((col-x)*(col-x) + (row-y-body)*(row-y-body) < head*head) trace('collision!');
				}
			}
			return minDist;
		}
		
		public function checkLeft() {
			return checkBelow(x-1, y);
			// 5 = gap, -5 = wall
		}
		
		public function checkRight() {
			return checkBelow(x+1, y);
			// 5 = gap, -5 = wall
		}
		
		public function checkHere() {
			return checkBelow(x, y);
			// 5 = gap, -5 = wall
		}
		
		public function checkLeft() {
			for(var i:int = 5; i > -5; i--)
				if(!collided(x-1, y+i)) return i;
			return -5;
			// 5 = gap, -5 = wall
		}
		
		public function checkRight() {
			for(var i:int = 5; i > -5; i--)
				if(!collided(x+1, y+i)) return i;
			return -5;
			// 5 = gap, -5 = wall
		}
		
		public function checkHere() {
			for(var i:int = 5; i > -5; i--)
				if(!collided(x, y+i)) return i;
			return -5;
			// 5 = gap, -5 = wall
		}
		
		public function checkAbove() {
			for(i in -5...5)
				if(!collided(x, y+i)) return i;
			return 5;
			// -5 = open space, 0 - stuck
		}
		
		public override function onCollision() {
			if(handleCollision)
				controller = new WormControllerWalk(this);
		}		
		
		public override function applyAffection(vx:Float, vy:Float) {
			//if(controller is WormControllerWalk)
				//y += Math.max(Math.min(0, checkAbove()+1), Math.min(0, vx>0 ? checkLeft() : checkRight()));
			
			controller = new WormControllerSlide(this);
			super.applyAffection(vx, vy);
		}
		
		public override function hurt(dmg:Int, type:String) {
			if(!map) return;
			var m:Map = map;
			hp -= dmg;
			if(dmg > 0) {
				if(this == m.activeWorm) m.setRetreat(0);
				new RisingLabel(x, y, vx, vy, dmg.toString(), team ? team.color : 0x999999).addTo(m);		
			} else if(dmg < 0) {
				new RisingLabel(x, y, vx, vy, '+'+(-dmg).toString(), team ? team.color : 0x999999).addTo(m);					
			}
		}
		
		function get_hp():Int 
		{
			return hp;
		}
		
		function set_hp(value:Int):Int 
		{
			return hp = value;
		}
		
		public function get team():Team {
			return team;
		}
		
		public function set team(val:Team) {
			team = val;
			if(tf) tf.textColor = team.color;
			if(tfName) tfName.textColor = team.color;
		}*/
}