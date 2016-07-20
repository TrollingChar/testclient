package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WGrenade extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
	}
	
	override function loadWeapon() 
	{
		mc = new GrenadeInHandMC();
	}
		
	override function updateWeapon()
	{
		updateThrownWeapon();
	}
		
	override function onShoot() 
	{			
		map.activeTeam.arsenal.useAmmo('grenade');
		map.updateArsenal();
			
		var shell:Grenade = new Grenade();
		shell.x = worm.x;
		shell.y = worm.y;
		shell.vx = map.st.x - worm.x;
		shell.vy = map.st.y - worm.y;
		shell.v = power * .6;
		shell.addTo(map);
		shell.controller.fuse = 50 * fuse;
		
		new Throw().play();
	}
}