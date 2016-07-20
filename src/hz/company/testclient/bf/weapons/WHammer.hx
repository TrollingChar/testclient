package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WHammer extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		constpower = true;
	}
	
	override function loadWeapon() 
	{
		mc = new HammerMC();
	}
		
	override function updateWeapon() 
	{
		updateAimedWeapon();
	}
		
	override function onShoot() 
	{
		map.activeTeam.arsenal.useAmmo('hammer');
		map.updateArsenal();
			
		var x:Float = map.st.x;
		var y:Number = map.st.y;
		var dx:Number = x - worm.x;
		var dy:Number = y - worm.y;
		var r:Number = Math.sqrt(dx*dx + dy*dy);
		if (r) 
		{
			x = worm.x + 10*dx/r;
			y = worm.y + 10*dy/r;
		}
			
			/*for each(var obj:_Object in map.objects) {
				var dist:Number = Math.sqrt((x-obj.x)*(x-obj.x) + (y-obj.y)*(y-obj.y));
				if(dist < 20) {
					if(obj != worm) {
						obj.hurt(15, 'blunt');
						obj.applyAffection(15*dx/r, 15*dy/r);
					}
				}
			}*/
	}
}