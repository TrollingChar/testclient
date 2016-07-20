package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class WTeleport extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		constpower = true;
		nochange = false;
		recharge = 0;
		ch.visible = false;
		targ.visible = true;
	}
	
	override function loadWeapon() {
		mc = new RedButtonMC();
	}
		
	override function updateWeapon() {
		updateFixedWeapon();
	}
		
	override function onShoot() {
		var head:Float = Worm.head,
			body:Float = Worm.body;
			
			/*for each(var obj:_Object in map.objects) {				
				if(obj is Crate) continue;
				if(
					(obj as _Object).hitTestCircle(worm.x, worm.y, head) ||
					(obj as _Object).hitTestCircle(worm.x, worm.y+body, head) ||
					(obj as _Object).hitTestRectangle(worm.x-head, worm.y, worm.x+head, worm.y+body)
				) continue;
				if(
					(obj as _Object).hitTestCircle(map.st.x, map.st.y, head) ||
					(obj as _Object).hitTestCircle(map.st.x, map.st.y+body, head) ||
					(obj as _Object).hitTestRectangle(map.st.x-head, map.st.y, map.st.x+head, map.st.y+body)
				) { 
					shots++; 
					return;
				}
			}*/			
			
		if(worm.collided(map.st.x, map.st.y)) {
			shots++; 
			return;
		}
			
		map.activeTeam.arsenal.useAmmo('teleport');
		map.updateArsenal();
					
		map.makeSmoke(worm.x, worm.y, 40);			
		worm.x = map.st.x;
		worm.y = map.st.y;
		worm.vx = worm.vy = 0;
		map.makeSmoke(worm.x, worm.y, 40);	
	}		
		
	override function onStopShooting() { }
		
	override function onDisable(endTurn:Boolean = true) {
		map.camera.bindToObj(null);
		map.camera.mode = 'auto';
		if(endTurn) map.setRetreat(0);
	}
}