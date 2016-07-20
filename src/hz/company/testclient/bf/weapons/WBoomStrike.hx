package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WBoomStrike extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		constpower = true;
		ch.visible = false;
	}
	
	override function onShoot() 
	{
		map.activeTeam.arsenal.useAmmo('boom strike');
		map.updateArsenal();
		new Explosion().play();
		var x:Float = worm.x,
		var y:Float = worm.y;
		map.makeHole(x, y + Worm.head, 40);
		map.makeBlast(x, y + Worm.head + Worm.body, 80, 10, map.objects.filter(function(obj, id, arr) {return obj != worm;}));
		map.dealDamage(x, y + Worm.head, 80, 29, 25, map.objects.filter(function(obj, id, arr) {return obj != worm;}));
		map.makeSmoke(x, y + Worm.head, 70);
		//worm.vy -= 3;
	}
}