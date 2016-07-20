package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WBlaster extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		constpower = true;
		shots = 2;
		recharge = 50;
	}
	
	override function loadWeapon() 
	{
		mc = new BlasterMC();
	}
		
	override function updateWeapon() 
	{
		updateAimedWeapon();
	}
	
	override public function update() 
	{
		if(map.st.sp) disable(); else super.update();
	}
		
	override function onShoot() 
	{			
		map.activeTeam.arsenal.useAmmo('blaster');
		map.updateArsenal();
		var blt:BlasterBullet = new BlasterBullet(worm.x, worm.y, map.st.x, map.st.y);
		new BlasterSound().play();
		blt.addTo(map);
	}
		
	override function onStopShooting() 
	{
		super.onStopShooting();
		if(!map.activeTeam.arsenal.getAmmo('blaster')) disable();
	}
}