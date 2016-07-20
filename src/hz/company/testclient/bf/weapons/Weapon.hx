package hz.company.testclient.bf.weapons;

/**
 * ...
 * @author 
 */
class Weapon
{
	public var
			map:Map,
			worm:Worm,
			name:String,
			shots:int,
			burst:int,
			delay:int,
			recharge:int,
			fuse:int,
			maxpower:Number,
			constpower:Boolean,
			nochange:Boolean,
			resets:Boolean,
			
			ready:Boolean,
			power:int = 0,
			fires:Boolean = false,
			shotsleft:int,
			burstleft:int,
			delayleft:int,
			disabled:Boolean = false,
			
			ch:CrosshairMC,
			targ:TargetMC,
			mc:MovieClip,
			sound:SoundChannel;
	public function new() 
	{
		
	}
	
}