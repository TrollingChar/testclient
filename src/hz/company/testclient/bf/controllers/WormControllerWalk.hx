package hz.company.testclient.bf.controllers;
import hz.company.testclient.bf.World;
import hz.company.testclient.bf.objects.Object;
import hz.company.testclient.bf.objects.Tester;
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
	
		var world:World = worm.world;
		
		var offset:Float = new Tester(worm.position, new Point2D(0, Worm.size * 2)).test();
		
		if (offset >= 1)
		{
			// под ногами нет земли
			worm.controller = new WormControllerJump();
			return;
		}		
		//if (Worm.testBelow(worm.position, world) >= Worm.size)
		//{
			//// под ногами нет земли
			//worm.controller = new WormControllerJump();
			//return;
		//}
		
		var offsetX:Float = 0;		
		if (world.input.flags & InputState.a != 0)		// влево
			offsetX -= Worm.speed;
		if (world.input.flags & InputState.d != 0)		// вправо
			offsetX += Worm.speed;
		
		// не твой ход или ты не можешь двигаться, то просто спуститься до касания с землей
		if (worm != world.activeWorm || world.wormFrozen) {			
			worm.position.y += offset * Worm.size * 2 - Worm.size;
			return;
		}
		
		// не твой ход или ты не можешь двигаться
		//if (worm != world.activeWorm || world.wormFrozen) {
			//var offsetY:Float = Worm.testBelow(worm.position, world);		
			//if (offsetY > -Worm.size) {
				//// если в стенке не застрял
				//worm.position.y += offsetY;
			//}
			//return;
		//}
		
		// повернуться влево или вправо, если ты можешь двигаться
		// нужно для работы прыжков и всей фигни
		if (offsetX < 0) worm.facingRight = false;
		if (offsetX > 0) worm.facingRight = true;
		
		// нельзя одновременно прыгнуть и проползти
		if (world.input.flags & (InputState.w | InputState.s) != 0)
			offsetX = 0;
			
		// обработать ползание или стояние на месте
		if (offsetX != 0) {	
			// ползем
			// посмотреть что с той стороны
			offsetX *= new Tester(worm.position, new Point2D(offsetX, 0)).test();
			var tester:Tester = new Tester(worm.position + new Point2D(offsetX, 0), new Point2D(0, Worm.size * 2));
			var spaceDown:Float = tester.test();
			if (spaceDown < 0.5) {
				// надо проверить, не упирается ли червь в потолок
				tester.velocity.y = -Worm.size;
				var spaceUp:Float = tester.test();
				if (spaceUp >= 1) // не упирается
					worm.position += new Point2D(offsetX, spaceDown * Worm.size * 2 - Worm.size);
			} else {
				worm.position += new Point2D(offsetX, spaceDown * Worm.size * 2 - Worm.size);				
			}
		} else {
			// на месте
			worm.position.y += offset * Worm.size * 2 - Worm.size;
		}
		
		//var offsetY:Float = Worm.testBelow(worm.position + new Point2D(offsetX, 0), world);		
		//if (offsetY > -Worm.size) {
			//// если в стенку не ползешь
			//worm.position += new Point2D(offsetX, offsetY);
		//}
			
		// обработать ползание или стояние на месте
		//var offsetY:Float = Worm.testBelow(worm.position + new Point2D(offsetX, 0), world);		
		//if (offsetY > -Worm.size) {
			//// если в стенку не ползешь
			//worm.position += new Point2D(offsetX, offsetY);
		//}
		
		// обработать прыжок
		if (world.input.flags & InputState.s != 0)
		{
			worm.velocity %= 7;
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
			worm.velocity %= 5;
			worm.angle += worm.facingRight ? .5 : -.5;
			worm.controller = new WormControllerJump();
			//worm.controller = new WormControllerBeforeJump(worm);
			return;
		}
		
	}
	
	
	
}