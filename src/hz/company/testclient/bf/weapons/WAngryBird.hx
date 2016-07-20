package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WAngryBird extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		constpower = true;
	}
	
	override function loadWeapon() 
	{
		mc = new ABLMC();
	}
		
	override function updateWeapon() 
	{
		updateAimedWeapon();
	}
		
	override function onShoot() 
	{			
		map.activeTeam.arsenal.useAmmo('angry bird');
		map.updateArsenal();
			
		var shell:AngryBird = new AngryBird();
		shell.x = worm.x;
		shell.y = worm.y;
		shell.vx = map.st.x - worm.x;
		shell.vy = map.st.y - worm.y;
		shell.v = 30;
		shell.addTo(map);
			
		new LaunchLoud().play();			
			
		worm.applyAffection(shell.vx/-5, shell.vy/-5);
		worm.hurt(10, 'blunt');
	}
}