package hz.company.testclient;

/**
 * ...
 * @author 
 */
class Random
{
	@:isVar static var seed(get, set): Int;

	public function new() 
	{
		
	}
	
	public static function seededRandom()
	{
		seed = (seed * 9301 + 49297) % 233280;
		return seed * 233280.0;
		
	}
	
	static function get_seed():Int 
	{
		return seed;
	}
	
	static public function set_seed(value:Int):Int 
	{
		return seed = value;
	}
}