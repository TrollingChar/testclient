package hz.company.testclient.bf.controllers;
import hz.company.testclient.bf.World;
import hz.company.testclient.bf.objects.Object;
import hz.company.testclient.bf.objects.Worm;
import hz.company.testclient.geom.Point2D;

/**
 * ...
 * @author 
 */
class WormControllerWalk extends Controller
{	

	public function new() 
	{
		super();
	}
	
	override public function onAdd() 
	{
		object.velocity = new Point2D(0, 0);
	}
	
	override function work() 
	{
		var worm:Worm = cast(object, Worm);
		
		// так не бывает
		if (worm == null) {
			Main.I.log("worm == null");
			return;		
		}
	
		var world:World = worm.world;
		
		if (Worm.testBelow(worm.position, world) >= 5)
		{
			// под ногами нет земли
			worm.controller = new WormControllerJump();
			//Main.I.log("fall");
			return;
		}
		
		var offsetX:Float = 0;		
		if (world.input.flags & InputState.a != 0)		// влево
			offsetX -= 1.0;
		if (world.input.flags & InputState.d != 0)		// вправо
			offsetX += 1.0;
		
		// не твой ход
		if (worm != world.activeWorm) {
			//Main.I.log("not your turn");
			offsetX = 0;
		}
		
		// ты не можешь двигаться
		if (world.wormFrozen) {
			//Main.I.log("frozen in place");
			offsetX = 0;
		}
		
		// повернуться влево или вправо, если ты можешь двигаться
		// нужно для работы прыжков и всей фигни
		if (offsetX < 0) worm.facingRight = false;
		if (offsetX > 0) worm.facingRight = true;
		
		// нельзя одновременно прыгнуть и проползти
		if (world.input.flags & (InputState.w | InputState.s) != 0)
			offsetX = 0;
			
		// обработать ползание или стояние на месте
		var offsetY:Float = Worm.testBelow(worm.position + new Point2D(offsetX, 0), world);		
		if (offsetY > -5) {
			// если в стенку не ползешь
			worm.position += new Point2D(offsetX, offsetY);
		}
		
		// обработать прыжок
		if (world.input.flags & InputState.s != 0)
		{
			worm.setVelocity(6);
			// мы перезаписали offsetX, но мы еще помним флаги и направление червя
			if (world.input.flags & (InputState.a | InputState.d) != 0)
			{
				worm.angle += worm.facingRight ? .1 : -.1;
			}
			worm.controller = new WormControllerJump();
			//worm.controller = new WormControllerBeforeJump(worm);
			return;
		}
		if (world.input.flags & InputState.w != 0)
		{
			worm.setVelocity(4);
			worm.angle += worm.facingRight ? -.5 : .5;
			worm.controller = new WormControllerJump();
			//worm.controller = new WormControllerBeforeJump(worm);
			return;
		}		
		
	}
	
	
	
}