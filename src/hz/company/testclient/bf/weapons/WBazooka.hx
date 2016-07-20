package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WBazooka extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
	}
	
	override function loadWeapon() 
	{
		mc = new BazookaMC();
	}
		
	override function updateWeapon()
	{
		updateAimedWeapon();
	}
		
	override function onShoot() 
	{			
		map.activeTeam.arsenal.useAmmo('bazooka');
		map.updateArsenal();
			
		var shell:BazookaShell = new BazookaShell();
		shell.x = worm.x;
		shell.y = worm.y;
		shell.vx = map.st.x - worm.x;
		shell.vy = map.st.y - worm.y;
		shell.v = power * .6;
		shell.addTo(map);
			
		new Launch().play(40);
	}
}