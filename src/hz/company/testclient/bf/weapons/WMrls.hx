package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WMrls extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		burst = 5;
		delay = 10;
	}
	
	override function loadWeapon() {
		mc = new MrlsMC();
	}
		
	override function updateWeapon() {
		updateAimedWeapon();
	}
		
	override function onStartShooting() {		
		burst = map.activeTeam.arsenal.getAmmo('mrls');
		if(fuse < burst || burst < 0) burst = fuse;
	}
		
	override function onShoot() {				
		map.activeTeam.arsenal.useAmmo('mrls');
		map.updateArsenal();
			
		var shell:MrlsShell = new MrlsShell();
		shell.x = worm.x;
		shell.y = worm.y;
		shell.vx = map.st.x - worm.x;
		shell.vy = map.st.y - worm.y;
		shell.v = power * .6;
		shell.addTo(map);
			
		shell.angle += (Math.random() - Math.random()) * .05;
		shell.v *= 1 + (Math.random() - Math.random()) * .05;
			
		new Launch().play(40);
	}
}