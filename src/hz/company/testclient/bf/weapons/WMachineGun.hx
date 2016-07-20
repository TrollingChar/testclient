package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WMachineGun extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		burst = 30;
		delay = 4;
		constpower = true;
	}
	
	override function loadWeapon() 
	{
		mc = new MachineGunMC();
	}
		
	override function updateWeapon() {
		updateAimedWeapon();
	}
		
	override function onStartShooting() {		
		map.activeTeam.arsenal.useAmmo('machine gun');
		map.updateArsenal();
	}
		
	override function onShoot() {			
		var blt:Bullet = new Bullet(worm.x, worm.y, map.st.x, map.st.y);
		blt.angle += (Math.random()-Math.random())*.05;
		new Shot().play();//0, 0, new SoundTransform(.2));
		blt.addTo(map);
	}
}