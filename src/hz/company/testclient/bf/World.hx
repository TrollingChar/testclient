package hz.company.testclient.bf;
import flash.events.Event;
import haxe.ds.HashMap;
import haxe.ds.IntMap;
import hz.company.testclient.bf.colliders.Collider;
import hz.company.testclient.bf.objects.Object;
import hz.company.testclient.bf.objects.Worm;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;

/**
 * ...
 * @author I'm
 */
class World extends Sprite
{
	var syncronized:Bool;			// когда действия игроков нужно синхронизировать, событие таймера не обрабатывается
	var myTurn:Bool;				// но во время моего хода это по моему клиенту синхронизируются все остальные
	var timer:Int;					// в миллисекундах
	var input:InputState;			// данные мыши и клавиатуры этого компьютера
	var nextState:GameState;
	var teams:IntMap<Team>;			// на первое время
	var land:BitmapData;
	var objects : List<Object>;
	//var colliders : List<Collider>;
	var tiles:IntMap < IntMap<Tile> > ;
	
	var layers:Array<Sprite>;		// слои для вывода спрайтов

	public function new() 
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, addedToStage);
	}
	
	private function addedToStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		
		this.objects = new List<Object>();
		land = Assets.getBitmapData("img/coffee_map.png");
		addChild(new Bitmap(land));
		
		nextState = GameState.REMOVE_0HP;
		
		stage.addEventListener(Event.ENTER_FRAME, enterFrame);
	}
	
	private function enterFrame(e:Event):Void 
	{
		if (syncronized) {
			if (myTurn) {
				update(input);
				Main.I.connection.sendInput(input);
			}
		} else {
			update();
		}
	}
	
	public function wait(time:Int = 500) {
		if (timer < time) timer = time;
	}
	
	function changeState() {
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
		switch (nextState) 
		{
			case GameState.BEFORE_TURN: {
				nextState = GameState.SYNCHRONIZING;
				if (Random.float() < .1) {
					// drop crates
					wait();
				} else {
					changeState();
				}
			}
			case GameState.SYNCHRONIZING: {
				nextState = GameState.TURN;
				syncronized = true;
			}
			case GameState.TURN: {
				nextState = GameState.ENDING_TURN;
				wait(30000);
			}
			case GameState.ENDING_TURN: {
				nextState = GameState.AFTER_TURN;
				syncronized =
				myTurn = false;
				wait();
			}
			case GameState.AFTER_TURN: {
				nextState = GameState.REMOVE_0HP;
				if (Random.float() < .1) {
					// poison damage
					wait();
				} else {
					changeState();
				}
			}
			case GameState.REMOVE_0HP: {
				if (Random.float() < .1) {
					// hitpointless worms begin exploding
					wait();
				} else {
					nextState = GameState.BEFORE_TURN;
					changeState;
				}
			}
			default:
				Main.I.log("entering unknown state");
		}
	}
	
	public function update(input:InputState = null)
	{		
		for (object in objects) {
		}
	}
	
	public function add(object:Object)
	{
		// ...
		object.world = this;
		object.onAdd();
	}
	
	public function move(object:Object) {		
		// фильтр коллайдеров по тайлам
		
		// фильтр перекрывающихся с коллайдером объектов
		
		// сталкивание с картой всех примитивов объекта
		
		// сталкивание с другими коллайдерами всех примитивов объекта
		
		// само столкновение с вычислением нормали к поверхности
		
		// сдвинуть объект и его коллайдеры
	}	
	
	public function remove(object:Object)
	{
		object.onRemove();
		// ...
		object.world = null;
	}
	
}