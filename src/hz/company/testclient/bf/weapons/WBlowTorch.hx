package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WBlowTorch extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		//burst = 150;
		//delay = 1;
		constpower = true;
	}
	
	override function loadWeapon() 
	{
		mc = new TorchMC();
	}
		
	override function updateWeapon() 
	{
		updateAimedWeapon();
	}
		
	override function onStartShooting() 
	{		
		map.activeTeam.arsenal.useAmmo('torch');
		map.updateArsenal();
	}
		
	override function onShoot() 
	{
		if(!map.st.mb) return;
		var blt:Bullet = new Bullet(worm.x, worm.y, map.st.x, map.st.y);
		blt.angle += (Math.random()-Math.random())*.05;
		new GunSound().play();
		blt.addTo(map);
	}
}