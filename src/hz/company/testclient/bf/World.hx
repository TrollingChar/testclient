package hz.company.testclient.bf;
import haxe.ds.*;
import hz.company.testclient.bf.Tile;
import hz.company.testclient.bf.colliders.*;
import hz.company.testclient.bf.objects.*;
import hz.company.testclient.geom.*;
import openfl.*;
import openfl.events.*;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;

/**
 * ...
 * @author I'm
 */
class World extends Sprite
{	
	public var paused:Bool;
	public var syncronized:Bool;				// когда действия игроков нужно синхронизировать, событие таймера не обрабатывается
	public var activePlayer:Int;				// но во время моего хода это по моему клиенту синхронизируются все остальные
	public var input:InputState;				// состояние клавиатуры и мыши текущего игрока
	public var inputQueue:List<InputState>;		// состояние активного игрока, прочитанное из сокета
	
	@:isVar var timer(get, set):Int;			// в миллисекундах
	@:isVar var timerVisible(get, set):Bool;	// видно таймер или нет
	public var timerFrozen:Bool;				// идет время на таймере или нет
	public var activeWorm:Worm;					// червяк, получивший ход
	public var wormFrozen:Bool;					// червяк не может двигаться
	
	var nextState:GameState;
	var currentState:GameState;
	
	var teams:IntMap<Team>;
	var land:BitmapData;
	var objects : List<Object>;
	//var colliders : List<Collider>;
	var tiles:IntMap < IntMap<Tile> > ;			// сначала x, потом y
	
	public var gravity:Float = 0.5;
	
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
		land = Assets.getBitmapData("img/tiled-map.png");
		layers[Layers.SURFACE].addChild(new Bitmap(land));
		tiles = new IntMap<IntMap<Tile>>();
		for (x in 0...100) 
		{
			for (y in 0...50) 
			{
				getTileAt(x, y).recomputeLand();
			}
		}
		
		// инициализация игры
		enterState(GameState.REMOVE_0HP);
		for (team in teams) 
		{
			var worm:Worm;			
			worm = new Worm();
			worm.position = new Point2D(Main.I.random.genrand_int32() % 800, 100);
			team.add(worm);			
			addObject(worm);
			worm = new Worm();
			worm.position = new Point2D(Main.I.random.genrand_int32() % 800, 100);
			team.add(worm);			
			addObject(worm);
		}
		
		wormFrozen = true;
		timerVisible = true;
		
		// пуск основного таймера!
		stage.addEventListener(Event.ENTER_FRAME, enterFrame);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
	}
	
	public function finalize() {
		stage.removeEventListener(Event.ENTER_FRAME, enterFrame);
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
		Main.I.panArs.hidden =
		Main.I.panInGame.hidden = true;
	}
	
	private function stage_mouseMove(e:MouseEvent):Void 
	{
		var x:Float = Main.I.input.x = e.stageX;
		var y:Float = Main.I.input.y = e.stageY;
		
		//var _x:Int = Math.floor(x / Tile.size);
		//var _y:Int = Math.floor(y / Tile.size);
		//
		//Main.I.log(Std.string(getTileAt(_x, _y).land));
	}
	
	private function enterFrame(e:Event):Void 
	{
		try 
		{
			//if (paused) return;		
			Main.I.connection.readData();
			
			if (syncronized) {
				if (activePlayer == Main.I.id)
					updateAndSend(Main.I.input);
			} else {
				update(Main.I.input);
			}
		} catch (e:Dynamic) {
			Main.I.log(Std.string(e));
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
		currentState = state;
		switch (state) 
		{
			case GameState.BEFORE_TURN: {
				//Main.I.debugTextField.text = "BEFORE TURN";
				nextState = GameState.SYNCHRONIZING;
				if (Main.I.random.genrand_int32() % 2 == 0) {
					// drop crates
					timer = 500;
				} else {
					changeState();
				}
			}
			case GameState.SYNCHRONIZING: {
				//Main.I.debugTextField.text = "SYNCHRONIZING";
				nextState = GameState.TURN;
				syncronized = true;
				Main.I.connection.sendSynchronize(true);
			}
			case GameState.TURN: {
				//Main.I.debugTextField.text = activePlayer == Main.I.id ? "MY TURN" : "TURN";
				nextState = GameState.ENDING_TURN;
				wormFrozen = false;
				var team:Team = teams.get(activePlayer);
				//Main.I.log(Std.string(team));
				activeWorm = team.next();
				timer = 15000;
				timerVisible = true;
			}
			case GameState.ENDING_TURN: {
				//Main.I.debugTextField.text = "ENDING TURN";
				nextState = GameState.AFTER_TURN;
				Main.I.connection.immediateResponse =
				wormFrozen = true;
				//timerVisible = false;
				syncronized = false;
				activeWorm = null;
				activePlayer = 0;
				timer = 500;
			}
			case GameState.AFTER_TURN: {
				//Main.I.debugTextField.text = "AFTER TURN";
				nextState = GameState.REMOVE_0HP;
				if (Main.I.random.genrand_int32() % 2 == 0) {
					// poison damage
					timer = 500;
				} else {
					changeState();
				}
			}
			case GameState.REMOVE_0HP: {
				//Main.I.debugTextField.text = "REMOVE 0 HP";
				if (Main.I.random.genrand_int32() % 5 == 5) {	// never happens
					// hitpointless worms begin exploding
					nextState = GameState.REMOVE_0HP;
					timer = 500;
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
		return land.getPixel32(x, y) >>> 24 != 0;
	}
	
	public function getObjects():List<Object> {
		return objects.filter(function(o):Bool {return true;});
	}
	
	function updateAndSend(input:InputState) {
		if (currentState == GameState.TURN) {
			Main.I.connection.sendInput(Main.I.input);
			update(input);
		} else {
			Main.I.log("wrong time to send data");
		}
	}
	
	public function update(input:InputState)
	{
		this.input = input;
		
		for (object in objects) {
			object.update();
		}
		/*
		for (object in objects) {
			moveObject(object);
		}
		*/
		if (timer % 200 == 0 && input.flags & InputState.mb != 0 && currentState == GameState.TURN) {
			for (i in 0...5) 
			{
				var ball:TestBall = new TestBall();
				ball.position = new Point2D(input.x, input.y);
				ball.velocity = new Point2D(Main.I.random.genrand_float() - .5, Main.I.random.genrand_float() - 1.5) * 10;
				addObject(ball);				
			}
		}
		
		if (!timerFrozen) timer -= 20;
		if (timer <= 0) changeState();
		
		Main.I.log(Std.string(objects.length));
	}
	
	public function addObject(object:Object)
	{
		object.world = this;
		object.onAdd();
		objects.add(object);
	}
	
	public function moveObject(object:Object) {		
		if (~object.velocity <= 0) return;
		
		var collision:Collision = null;
		
		for (collider in object.colliders) 
		{
			var top:Float = collider.getTop() + Math.min(0, object.velocity.y);
			var bottom:Float = collider.getBottom() + Math.max(0, object.velocity.y);
			var left:Float = collider.getLeft() + Math.min(0, object.velocity.x);
			var right:Float = collider.getRight() + Math.max(0, object.velocity.x);
			
			for (list in getCollidersIn(left, top, right, bottom)) 
			{
				for (obstacle in list) 
				{
					var temp:Collision = null;
					if (Std.is(obstacle, ColliderPoint))
					{
						temp = collider.collideWithPoint(cast(obstacle, ColliderPoint));
					} else if (Std.is(obstacle, ColliderLine)) 
					{
						temp = collider.collideWithLine(cast(obstacle, ColliderLine));
					} else if (Std.is(obstacle, ColliderCircle)) 
					{
						temp = collider.collideWithCircle(cast(obstacle, ColliderCircle));
					}
					if(temp != null) {
						if (collision == null) {
							collision = temp;
						} else if (collision.relativePath > temp.relativePath) {
							collision = temp;							
						}
					}
				}
			}
		}
		
		// само столкновение с вычислением нормали к поверхности
		if (collision == null) {
			// нет препятствий
			object.position += object.velocity;
		} else {
			var collider:Collider = collision.collider;
			var position:Point2D = object.position;
			var offset:Point2D = object.velocity * collision.relativePath;
			var lowerBound:Float = 0;
			var upperBound:Float = 2;
			
			var relationBefore:Float = 0;
			var relationAfter:Float = 0;
			
			while (Math.abs(lowerBound - upperBound) > 0.000001 && lowerBound < 1) 
			{				
				var guess:Float = (lowerBound + upperBound) / 2;
				
				// сдвигает коллайдер
				collider.test(position + offset * guess);
				
				if (Std.is(collision.collided, ColliderCircle)) {
					relationAfter = collision.collider.relationToCircle(cast(collision.collided, ColliderCircle));
				} else if (Std.is(collision.collided, ColliderLine)) {
					relationAfter = collision.collider.relationToLine(cast(collision.collided, ColliderLine));					
				} else if (Std.is(collision.collided, ColliderPoint)) {
					relationAfter = collision.collider.relationToPoint(cast(collision.collided, ColliderPoint));					
				} else {
					Main.I.log("unknown collider");
				}
				if (relationAfter < 0) {
					upperBound = guess;
				} else {
					lowerBound = guess;
				}
			}
			Main.I.log("lower bound = " + Std.string(lowerBound));
			object.position += offset * lowerBound;
			object.onCollision(collision);
		}
	}
	
	@:deprecated
	public function moveObjectOld(object:Object) {
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
					// точки
					if (isLand(x - 1, y - 1) || isLand(x, y - 1) || isLand(x - 1, y) || isLand(x, y)) {
						temp = collider.collideWithPoint(new ColliderPoint(new Point2D(x, y)));
						if(temp != null) {
							if (collision == null) {
								collision = temp;
							} else if (collision.relativePath > temp.relativePath) {
								collision = temp;							
							}
						}
					}
					// горизонтальные линии
					//if (isLand(x, y) || isLand)
					//{
						//
					//}
				}
			}
		}
		
		// сталкивание с другими коллайдерами всех примитивов объекта
		
		
		// само столкновение с вычислением нормали к поверхности
		if (collision == null) {
			// нет препятствий
			object.position += object.velocity;
		} else {
			var collider:Collider = collision.collider;
			var position:Point2D = object.position;
			var offset:Point2D = object.velocity * collision.relativePath;
			var lowerBound:Float = 0;
			var upperBound:Float = 2;
			
			var relationBefore:Float = 0;
			var relationAfter:Float = 0;
			
			while (Math.abs(lowerBound - upperBound) > 0.000001 && lowerBound < 1) 
			{				
				var guess:Float = (lowerBound + upperBound) / 2;
				
				// сдвигает коллайдер
				collider.test(position + offset * guess);
				
				if (Std.is(collision.collided, ColliderCircle)) {
					relationAfter = collision.collider.relationToCircle(cast(collision.collided, ColliderCircle));
				} else if (Std.is(collision.collided, ColliderLine)) {
					relationAfter = collision.collider.relationToLine(cast(collision.collided, ColliderLine));					
				} else if (Std.is(collision.collided, ColliderPoint)) {
					relationAfter = collision.collider.relationToPoint(cast(collision.collided, ColliderPoint));					
				} else {
					Main.I.log("unknown collider");
				}
				if (relationAfter < 0) {
					upperBound = guess;
				} else {
					lowerBound = guess;
				}
			}			
			
			object.position += offset * lowerBound;
			object.onCollision(collision);
		}
	}	
	
	public function removeObject(object:Object)
	{
		objects.remove(object);
		object.onRemove();
		object.world = null;
	}
	
	public function kickPlayer(id:Int) 
	{
		if (id == activePlayer) changeState();
	}
	
	public function setActivePlayer(id:Int) 
	{
		syncronized = true;
		activePlayer = id;
		changeState();
	}
	
	public function arsenalKeyDown() 
	{
		Main.I.panArs.hidden = !Main.I.panArs.hidden;
	}
	
	public function arsenalKeyUp() 
	{
		
	}
	
	public function getTileAt(x:Int, y:Int) 
	{
		if (tiles.exists(x))
			if (tiles.get(x).exists(y))
				return tiles.get(x).get(y);
		return new Tile(x, y);
	}
	
	public function addTile(tile:Tile) {
		var x:Int = tile.x;
		var y:Int = tile.y;
		if (!tiles.exists(x))
			tiles.set(x, new IntMap<Tile>());
		if (!tiles.get(x).exists(y))
			tiles.get(x).set(y, tile);
	}
	
	// возвращает все коллайдеры из выбранного прямоугольника
	public function getCollidersIn(left:Float, top:Float, right:Float, bottom:Float):List<List<Collider>>
	{		
		var result:List<List<Collider>> = new List<List<Collider>>();
		
		// сначала посчитать затронутые тайлы
		var leftTile:Int = Math.ceil(left / Tile.size) - 1;
		var	topTile:Int = Math.ceil(top / Tile.size) - 1;
		var	rightTile:Int = Math.floor(right / Tile.size);
		var	bottomTile:Int = Math.floor(bottom / Tile.size);
		
		// затем из каждого достать коллайдеры которые в нем есть
		for (x in leftTile...rightTile+1) 
		{
			for (y in topTile...bottomTile+1) 
			{
				var tile:Tile = Main.I.world.getTileAt(x, y);
				//result.add(tile.colliders);
				if (tile.land > 0) result.add(tile.getLandColliders(Math.floor(left), Math.floor(top), Math.ceil(right), Math.ceil(bottom)));
			}
		}
		return result;
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