package hz.company.testclient.bf;
import flash.events.Event;
import haxe.ds.HashMap;
import haxe.ds.IntMap;
import haxe.io.Input;
import hz.company.testclient.bf.colliders.Collider;
import hz.company.testclient.bf.colliders.Collision;
import hz.company.testclient.bf.colliders.CollisionDetection;
import hz.company.testclient.bf.objects.Object;
import hz.company.testclient.bf.objects.TestBall;
import hz.company.testclient.bf.objects.Worm;
import hz.company.testclient.geom.Point2D;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.utils.Timer;

/**
 * ...
 * @author I'm
 */
class World extends Sprite
{	
	public var syncronized:Bool;	// когда действия игроков нужно синхронизировать, событие таймера не обрабатывается
	public var myTurn:Bool;			// но во время моего хода это по моему клиенту синхронизируются все остальные
	public var synchronizer:Synchronizer;
	
	@:isVar var timer(get, set):Int;			// в миллисекундах
	@:isVar var timerVisible(get, set):Bool;	// видно таймер или нет
	var timerFrozen:Bool;						// идет время на таймере или нет
	var nextState:GameState;
	var teams:IntMap<Team>;
	var land:BitmapData;
	var objects : List<Object>;
	var colliders : List<Collider>;
	var tiles:IntMap < IntMap<Tile> > ;
	
	public var gravity:Float = 0.25;
	
	public var layers:Array<Sprite>;// слои для вывода спрайтов

	public function new(teams:IntMap<Team>) 
	{
		super();
		this.teams = teams;
		addEventListener(Event.ADDED_TO_STAGE, addedToStage);
	}
	
	private function addedToStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		
		// разложить слои
		layers = new Array<Sprite>();
		for (i in 0...Layers.AMOUNT) 
		{
			addChild(layers[i] = new Sprite());
		}
		
		this.objects = new List<Object>();
		
		// создать карту
		land = Assets.getBitmapData("img/coffee_map.png");
		layers[Layers.SURFACE].addChild(new Bitmap(land));
		
		// инициализация игры
		enterState(GameState.REMOVE_0HP);
		
		var ball = new TestBall();
		ball.position = new Point2D(100, 100);
		add(ball);
		
		// пуск основного таймера!
		stage.addEventListener(Event.ENTER_FRAME, enterFrame);
	}
	
	private function enterFrame(e:Event):Void 
	{
		Main.I.debugTextField.glow = true;
		if (syncronized) {
			if (myTurn) {
				update(Main.I.input);
				Main.I.connection.sendInput(Main.I.input);
			} else {
				/*var state:InputState = synchronizer.readNext();
				if (state != null) {
					update(state);
				} else {
					Main.I.debugTextField.glow = false;					
				}*/
			}
		} else {
			update();
		}
	}
	
	public function wait(time:Int = 500) {
		if (timer < time) timer = time;
	}
	
	public function changeState() {
		switch (nextState) 
		{
			case GameState.BEFORE_TURN:
				enterState(GameState.BEFORE_TURN);
			case GameState.SYNCHRONIZING:
				enterState(GameState.SYNCHRONIZING);
			case GameState.TURN:
				enterState(GameState.TURN);
			case GameState.ENDING_TURN:
				enterState(GameState.ENDING_TURN);
			case GameState.AFTER_TURN:
				enterState(GameState.AFTER_TURN);
			case GameState.REMOVE_0HP:
				enterState(GameState.REMOVE_0HP);
			default:
				Main.I.log("change to unknown state");
		}
	}
	
	function enterState(state:GameState) {
		switch (state) 
		{
			case GameState.BEFORE_TURN: {
				Main.I.debugTextField.text = "BEFORE TURN";
				nextState = GameState.SYNCHRONIZING;
				if (.5 < 1) {
					// drop crates
					wait();
				} else {
					changeState();
				}
			}
			case GameState.SYNCHRONIZING: {
				Main.I.debugTextField.text = "SYNCHRONIZING";
				nextState = GameState.TURN;
				syncronized = true;
				Main.I.connection.sendSynchronize(true);
			}
			case GameState.TURN: {
				Main.I.debugTextField.text = myTurn ? "MY TURN" : "TURN";
				synchronizer = new Synchronizer();
				nextState = GameState.ENDING_TURN;
				wait(30000);
				timerVisible = true;
			}
			case GameState.ENDING_TURN: {
				Main.I.debugTextField.text = "ENDING TURN";
				nextState = GameState.AFTER_TURN;
				synchronizer.shutdown();
				//timerVisible = false;
				syncronized =
				myTurn = false;
				wait();
			}
			case GameState.AFTER_TURN: {
				Main.I.debugTextField.text = "AFTER TURN";
				nextState = GameState.REMOVE_0HP;
				if (.5 < 1) {
					// poison damage
					wait();
				} else {
					changeState();
				}
			}
			case GameState.REMOVE_0HP: {
				Main.I.debugTextField.text = "REMOVE 0 HP";
				if (.5 < 0) {
					// hitpointless worms begin exploding
					wait();
				} else {
					nextState = GameState.BEFORE_TURN;
					changeState();
				}
			}
			default:
				Main.I.log("entering unknown state");
		}
	}
	
	public function isLand(x:Int, y:Int):Bool {
		return false;
	}
	
	public function update(input:InputState = null)
	{
		for (object in objects) {
			object.controller.update();
		}
		for (object in objects) {
			move(object);
		}
		
		if(!timerFrozen) timer -= 20;
		if (timer <= 0) changeState();
	}
	
	public function add(object:Object)
	{
		object.world = this;
		object.onAdd();
		objects.add(object);
	}
	
	public function move(object:Object) {
		// фильтр коллайдеров по тайлам
		
		// фильтр перекрывающихся с коллайдером объектов
		
		var collision:Collision = null;
		// сталкивание с картой всех примитивов объекта
		for (collider in object.colliders) 
		{
			var top:Int = Math.floor(collider.getTop() + Math.min(0, object.velocity.y));
			var bottom:Int = Math.ceil(collider.getBottom() + Math.max(0, object.velocity.y));
			var left:Int = Math.floor(collider.getLeft() + Math.min(0, object.velocity.x));
			var right:Int = Math.ceil(collider.getRight() + Math.max(0, object.velocity.x));
			
			for (x in left...right) 
			{
				for (y in top...bottom) 
				{
					var temp:Collision;					
					if (isLand(x - 1, y - 1) || isLand(x, y - 1) || isLand(x - 1, y) || isLand(x, y)) {
						
					}
					
					if (true)
					{
						// столкнуть коллайдер с линиями
					}
				}
			}
		}
		
		// сталкивание с другими коллайдерами всех примитивов объекта
		
		// само столкновение с вычислением нормали к поверхности
		
		// сдвинуть объект и его коллайдеры
		object.position += object.velocity;
	}	
	
	public function remove(object:Object)
	{
		objects.remove(object);
		object.onRemove();
		object.world = null;
	}
	
	public function addCollider(collider:Collider) 
	{
		
	}
	
	public function removeCollider(collider:Collider) 
	{
		
	}
	
	function get_timerVisible():Bool 
	{
		return timerVisible;
	}
	
	function set_timerVisible(value:Bool):Bool 
	{
		//Main.I.panInGame.btn1.text = value ? timer > 0 ? Std.string(Std.int((timer + 999) / 1000)) : "0" : "";
		Main.I.panInGame.btn1.text = value ? timer > 0 ? Std.string(timer) : "0" : "";
		return timerVisible = value;
	}
	
	function get_timer():Int 
	{
		return timer;
	}
	
	function set_timer(value:Int):Int 
	{
		var i:Int = value > 0 ? Std.int((value + 999) / 1000) : 0;
		if (timerVisible) Main.I.panInGame.btn1.text = Std.string(value);
		return timer = value;
	}
	
}