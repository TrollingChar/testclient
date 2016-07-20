package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WFirePunch extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		constpower = true;
		ch.visible = false;
	}
	
	override function onShoot() 
	{			
		map.activeTeam.arsenal.useAmmo('fire punch');
		map.updateArsenal();
			
		worm.vx = 0;
		worm.vy = -7;
		worm.controller = new WormControllerBeforeFirePunch(worm);
	}
}