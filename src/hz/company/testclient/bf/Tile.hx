package hz.company.testclient.bf;
import hz.company.testclient.bf.colliders.Collider;

/**
 * ...
 * @author I'm
 */
class Tile
{
	public var colliders : List<Collider>;
	public var land : Bool;
	
	public function new() 
	{
		colliders = new List<Collider>();
	}
	
}