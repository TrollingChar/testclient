package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WAirstrike extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		constpower = true;
		ch.visible = false;
		targ.visible = true;
	}
	
	override function loadWeapon() 
	{
		mc = new RedButtonMC();
	}
		
	override function updateWeapon() 
	{
		updateFixedWeapon();
	}
		
	override function onShoot() 
	{
		map.activeTeam.arsenal.useAmmo('airstrike');
		map.updateArsenal();
		for (var i in -2...2) 
		{
			var bomb:AirstrikeBomb = new AirstrikeBomb();
			bomb.y = -500;// + Math.random()*100;
			//bomb.vy = Math.random()*5;
			bomb.x = map.st.x + i*30;
			bomb.addTo(map);
		}
	}
}