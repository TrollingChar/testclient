package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WDynamite extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		constpower = true;
		ch.visible = false;
	}
	
	override function loadWeapon()
	{
		mc = new DynamiteInHandMC();
	}
		
	override function updateWeapon() 
	{
		updateThrownWeapon();
	}
		
	override function onShoot() 
	{			
		map.activeTeam.arsenal.useAmmo('dynamite');
		map.updateArsenal();
		
		var shell:Dynamite = new Dynamite();
		shell.x = worm.x;
		shell.y = worm.y;
		shell.vx = map.st.x - worm.x;
		shell.vy = map.st.y - worm.y;
		shell.v = 10;
		shell.addTo(map);
		shell.controller.fuse = 250;
		shell.controller.moveRectangle(3, 6);
		shell.v = 0;
			
		new Throw().play();
	}
}