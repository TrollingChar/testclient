package hz.company.testclient.bf;

/**
 * ...
 * @author 
 */
class Random
{	
	private var seed(get, set):Int;

	public function new(seed:Int) 
	{
		this.seed = seed;
	}
	
	public function nextInt(n:Int = 0x7FFFFFFF): int
	{
		return n > 0 ? nextNumber() * n : nextNumber();
	}
	
	function get_seed():Int 
	{
		return seed;
	}
	
	function set_seed(value:Int):Int 
	{
		return seed = value;
	}
	
	public function nextNumber():Float
	{
		seed = (seed*9301+49297) % 233280;
		return seed / 233280.0;
	}
}