package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WPuish extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		burst = 10;
		delay = 10;
		constpower = true;
	}
	
	override function loadWeapon() {
		mc = new PuishMC();
	}
		
	override function updateWeapon() {
		updateAimedWeapon();
	}
		
	override function onStartShooting() {		
		map.activeTeam.arsenal.useAmmo('puish');
		map.updateArsenal();
	}
		
	override function onShoot() {
		for(var i in 0...2) {
			var blt:PuishBeam = new PuishBeam(worm.x, worm.y, map.st.x, map.st.y, worm.team);
				blt.angle += (Math.random()-Math.random())*.1;	
				blt.addTo(map);
			}
		new PuishSound().play();
		//new Tinnitus().play();
	}
}