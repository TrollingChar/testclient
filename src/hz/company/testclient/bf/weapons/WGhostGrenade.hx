package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WGhostGrenade extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		fuse = 1;
	}
	
	override function loadWeapon() 
	{
		mc = new GhostGrenadeInHandMC();
	}
		
	override function updateWeapon() 
	{
		updateThrownWeapon();
	}
		
	override function onShoot()
	{			
		map.activeTeam.arsenal.useAmmo('ghost grenade');
		map.updateArsenal();
			
		var shell:GhostGrenade = new GhostGrenade();
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