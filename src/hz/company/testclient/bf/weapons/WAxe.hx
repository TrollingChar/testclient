package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WAxe extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		constpower = true;
		ch.visible = false;
	}
	
	override function loadWeapon() 
	{
		mc = new AxeMC();
	}
		
	override function updateWeapon() 
	{
		updateAimedWeapon();
	}
		
	override function onShoot() 
	{
		map.activeTeam.arsenal.useAmmo('axe');
		map.updateArsenal();
		var x:Float = map.st.x;
		var y:Float = map.st.y;
		var dx:Float = x - worm.x;
		var dy:Float = y - worm.y;
		var r:Float = Math.sqrt(dx*dx + dy*dy);
		if (r) 
		{
			x = worm.x + 10*dx/r;
			y = worm.y + 10*dy/r;
		}
		//хз как тут форич организовать
		/*for each(var obj:_Object in map.objects) 
		{
			r = Math.sqrt((x-obj.x)*(x-obj.x) + (y-obj.y)*(y-obj.y));
			if (r < 20) 
			{
				if(obj != worm)
					if(obj is Worm)
						obj.hurt(Math.floor((obj as Worm).hp / 2) + 5, 'edge');
					else
						obj.hurt(5, 'edge');
			}
		}*/
	}
}