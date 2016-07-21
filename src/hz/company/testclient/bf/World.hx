package hz.company.testclient.bf;
import flash.events.Event;
import haxe.ds.HashMap;
import haxe.ds.IntMap;
import hz.company.testclient.bf.colliders.Collider;
import hz.company.testclient.bf.objects.Object;
import openfl.display.BitmapData;
import openfl.display.Sprite;

/**
 * ...
 * @author I'm
 */
class World extends Sprite
{
	var land:BitmapData;
	var objects : List<Object>;
	//var colliders : List<Collider>;
	var tiles:IntMap < IntMap<Tile> > ;
	
	var layers:Array<Sprite>;

	public function new() 
	{
		super();
		this.objects = new List<Object>();
		//this.colliders = new List<Collider>();
		addEventListener(Event.ADDED_TO_STAGE, addedToStage);
	}
	
	private function addedToStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		
	}
	
	public function update()
	{
	//var iterator : Iterator;
	//iterator = this.objects.iterator;
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