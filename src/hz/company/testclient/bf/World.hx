package hz.company.testclient.bf;
import hz.company.testclient.bf.colliders.Collider;
import hz.company.testclient.bf.objects.Object;
import openfl.display.Sprite;

/**
 * ...
 * @author I'm
 */
class World extends Sprite
{
	var objects : List<Object>;
	var colliders : List<Collider>;
	
	var layers:Array<Sprite>;

	public function new() 
	{		
		this.objects = new List<Object>();
		this.colliders = new List<Collider>();
	}
	
	public function update()
	{
	//var iterator : Iterator;
	//iterator = this.objects.iterator;
		for (iterator in objects.iterator) {
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