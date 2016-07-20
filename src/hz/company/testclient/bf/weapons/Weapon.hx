package hz.company.testclient.bf.weapons;
import openfl.display.MovieClip;
import openfl.media.SoundChannel;

/**
 * ...
 * @author 
 */
class Weapon
{
	public var map:Map,
	//public var worm:Worm,
	public var name:String;
	public var shots:Int;
	public var burst:Int;
	public var delay:Int;
	public var recharge:Int;
	public var fuse:Int;
	public var maxpower:Float;
	public var constpower:Bool;
	public var nochange:Bool;
	public var resets:Bool;
			
	public var ready:Bool;
	public var power:Int = 0;
	public var fires:Bool = false;
	public var shotsleft:Int;
	public var burstleft:Int;
	public var delayleft:Int;
	public var disabled:Bool = false;
			
	//public var ch:CrosshairMC,
	//public var targ:TargetMC,
	public var mc:MovieClip;
	public var sound:SoundChannel;
			
	public function new(/*worm:Worm*/) 
	{
		this.worm = worm;
		shots = 1;
		burst = 1;
		delay = 5;
		recharge = 20;
		fuse = 5;
		maxpower = 30;
		constpower = false;
		nochange = true;
		resets = true;
		ready = true;
		ch = new CrosshairMC();
		//ch.visible = false;
		targ = new TargetMC();
		targ.visible = false;
		loadWeapon();
	}
	
	public function setFuse(f:int) 
	{
		if(!fires) fuse = f;
	}
		
	public function addToMap(map:Map) 
	{
		this.map = map;
		map.layers[Layers.CROSSHAIR].addChild(ch);
		map.layers[Layers.CROSSHAIR].addChild(targ);
		drawWeapon();
		map.camera.bindToObj(worm);
	}
		
	public function update() 
	{
		if(disabled) return;
		if (fires) 
		{
			if (--delayleft <= 0) 
			{
				shoot();
			}
		} 
		else 
		{
			if (--delayleft <= 0) 
			{
				map.timerFrozen = false;
				//else
					//return;					
				if (map.st.mb) 
				{
					if (!resets || ready) 
					{
						if(nochange) map.weaponSelect = false;
						map.timerFrozen = true;
						if (constpower) 
						{
							startShooting();
						} 
						else 
							if (++power >= 50) 
							{
								startShooting();
							}
					}
				} 
				else 
				{
					ready = true;
					if (power)
					{
						map.timerFrozen = true;
						//sound.stop();
						startShooting();
						ready = false;
					}
				}
			}
		}
		updateCrosshair();
		updateWeapon();
	}
		
	function startShooting() 
	{
		onStartShooting();
		fires = true;
		shots--;
		burstleft = burst;
		shoot();
	}
		
	function stopShooting()
	{
		onStopShooting();
		if(resets) ready = false;
		fires = false;
		power = 0;
		if(shots > 0)
			delayleft = recharge;
		else
			disable();
	}
		
	function shoot() 
	{
		onShoot();
		if(--burstleft > 0)
			delayleft = delay;
		else
			stopShooting();
	}
		
	function disable(endTurn:Boolean = true) 
	{
		if(disabled) return;
		disabled = true;
		map.timerFrozen = false;
		map.layers[Layers.CROSSHAIR].removeChild(ch);
		map.layers[Layers.CROSSHAIR].removeChild(targ);
		hideWeapon();
		onDisable(endTurn);
	}
		
	function onShoot() 
	{
		/*var gren:Grenade = new Grenade();
		gren.x = worm.x;
		gren.y = worm.y;
		gren.vx = map.st.x - worm.x;
		gren.vy = map.st.y - worm.y;
		gren.v = power * maxpower / 50;
		gren.addTo(map);
		gren.controller.fuse = 50 * fuse;
		new Throw().play();*/
	}
		
	function onStartShooting() 
	{ 		
	}
		
	function onStopShooting()
	{
		//map.camera.bindToObj(null);
		//map.camera.mode = 'auto';		
	}
		
	function onDisable(endTurn:Boolean = true) 
	{
		map.camera.bindToObj(null);
		map.camera.mode = 'auto';
		if(endTurn) map.setRetreat(3);
	}
		
	function updateCrosshair() 
	{
		if(power) ch.showCircle() else ch.hideCircle();
		ch.distance = power;
		ch.x = worm.x;
		ch.y = worm.y;
		var angle = Math.atan2(map.st.y - ch.y, map.st.x - ch.x);
		ch.angle = angle;
		targ.x = map.st.x;
		targ.y = map.st.y;
	}
		
	function loadWeapon() 
	{
		//mc = new BazookaMC();
	}
		
	function drawWeapon()
	{
		if(!mc) return;
		map.layers[Layers.WEAPON].addChild(mc);
		updateWeapon();
	}
		
	function updateWeapon() 
	{
		//updateAimedWeapon();
	}
		
	function updateAimedWeapon()
	{			
		mc.x = worm.x;
		mc.y = worm.y;
		mc.rotation = ch.angle * 180 / Math.PI;
		mc.scaleY = map.st.x > worm.x ? 1 : -1;
		mc.scaleX = 1;
	}
		
	function updateThrownWeapon()
	{
		mc.x = worm.x;
		mc.y = worm.y;
		mc.scaleX = map.st.x > worm.x ? 1 : -1;
		mc.scaleY = 1;
	}
		
	function updateFixedWeapon() 
	{
		mc.x = worm.x;
		mc.y = worm.y;
		mc.scaleX = worm.inverted ? -1 : 1;
		mc.scaleY = 1;
	}
		
	function hideWeapon()
	{
		if(!mc) return;
		map.layers[Layers.WEAPON].removeChild(mc);
	}
		
	public function die() 
	{			
		if(!map) return;
		disable(false);
	}
}