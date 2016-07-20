package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WJetpack extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		constpower = true;
		nochange = false;
		ch.visible = false;
	}
	
	override function onShoot()
	{			
		map.activeTeam.arsenal.useAmmo('jetpack');
		map.updateArsenal();
		worm.controller = new WormControllerJetpack(worm);
	}
		
	override function onDisable(endTurn:Boolean = true) 
	{
		map.camera.mode = 'auto';
	}

}