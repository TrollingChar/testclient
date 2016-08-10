package hz.company.testclient.bf.controllers;
import hz.company.testclient.bf.objects.Object;
import hz.company.testclient.bf.objects.Worm;
import hz.company.testclient.geom.Point2D;

/**
 * ...
 * @author 
 */
class WormControllerWalk extends Controller
{	

	public function new(object:Object) 
	{
		this.object = object;
		this.object.velocity = 0;
	}
	
	override function work() 
	{
		var worm:Worm = object as Worm; 
		if (worm != null)
		{
			if (worm.testBelow(worm.position) > 1.0e-8)
			{
				worm.controller = new WormControllerJump(worm);
				return;
			}
			if (worm != worm.team.next()) return;
			if (worm.world.isWormsFrozen()) return;
			
			var cmd:String = "none";
			if ((worm.world.input.flags & InputState.a) && !(worm.world.input.flags & InputState.d))
				cmd = "left";
			if (!(worm.world.input.flags & InputState.a) && (worm.world.input.flags & 	InputState.d))
			    cmd = "right";
			
			if (worm.world.input.flags & InputState.s)
			{
				worm.velocity = 6;
				if (cmd == "left")
				{
					//worm.inverted = true;
					//worm.angle -= .1;
				}
				if (cmd == "right")
				{
					//worm.inverted = true;
					//worm.angle -= .1;
				}
				worm.controller = new WormControllerBeforeJump(worm);
				//map.camera.bindToObj(worm);
				return;
			}
			if (worm.world.input.flags & InputState.w)
			{
				if (cmd == "left") //worm.inverted = true;
				if (cmd == "right") //worm.inverted = false;
				worm.velocity = 4;
				//worm.angle += worm.inverted ? -.5 : .5;
				worm.controller = new WormControllerBeforeJump(worm);
				//map.camera.bindToObj(worm);
				return;
			}
			if (cmd == "left")
			{
				var offsetY:Float = worm.testBelow(worm.position - new Point2D(1, 0));
				if (offsetY == -5)
				{
					
					//nope
					
				} else
					if (offsetY > -5)
					{
						worm.position.x -= 1;
						worm.position.y += offsetY;
						
					}
					if (offsetY >= 5)
					{
						//
					}
				
			}
			
		}
	}
	
	
	
}