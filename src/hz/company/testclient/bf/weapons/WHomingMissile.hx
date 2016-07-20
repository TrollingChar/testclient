package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WHomingMissile extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		shots = 2;
		delay = 10;
		recharge = 0;
		constpower = true;
		nochange = false;
		targ.visible = true;
		ch.visible = false;
	}
	
	override function loadWeapon() 
	{
		mc = new HomingLauncherMC();
	}
		
	override function updateWeapon() 
	{
		if(shots > 1)
			updateFixedWeapon();
		else
			updateAimedWeapon();
	}
		
	override function onShoot()
	{
		if (shots) 
		{
			targ.x = map.st.x;
			targ.y = map.st.y;
			//trace('onShoot');
		} 
		else 
		{
			map.activeTeam.arsenal.useAmmo('homing');
			map.updateArsenal();	
			var shell:HomingMissile = new HomingMissile(targ.x, targ.y);
			shell.x = worm.x;
			shell.y = worm.y;
			shell.vx = map.st.x - worm.x;
			shell.vy = map.st.y - worm.y;
			shell.v = power * .6;
			shell.addTo(map);		
			new Launch().play();
		}
	}
		
	override function onStopShooting() 
	{
		if (shots) 
		{
			ch.visible = true;
			constpower = false;
			nochange = true;
			//burst = 25;
			//map.camera.bindToObj(worm);
			map.camera.mode = 'auto';
		}
	}
		
	override function updateCrosshair() 
	{
		if(power) ch.showCircle() else ch.hideCircle();
		ch.distance = power;
		ch.x = worm.x;
		ch.y = worm.y;
		var angle = Math.atan2(map.st.y - ch.y, map.st.x - ch.x);
		ch.angle = angle;
		if (shots > 1)
		{
			targ.x = map.st.x;
			targ.y = map.st.y;
			//trace('updateCrosshair');
		}
	}
}