package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WHolyGrenade extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
	}
	
	override function loadWeapon() 
	{
		mc = new HHGInHandMC();
	}
		
	override function updateWeapon()
	{
		updateThrownWeapon();
	}
		
	override function onShoot()
	{			
		map.activeTeam.arsenal.useAmmo('holy grenade');
		map.updateArsenal();
			
		var shell:HHG = new HHG();
		shell.x = worm.x;
		shell.y = worm.y;
		shell.vx = map.st.x - worm.x;
		shell.vy = map.st.y - worm.y;
		shell.v = power * .6;
		shell.addTo(map);
			
		new Throw().play();
	}
}