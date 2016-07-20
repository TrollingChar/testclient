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
		object.onAdd();
	}
	public function remove(object:Object)
	{
		object.
	}
	
}