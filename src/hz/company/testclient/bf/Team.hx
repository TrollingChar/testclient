package hz.company.testclient.bf;
import hz.company.testclient.bf.objects.Worm;

/**
 * ...
 * @author 
 */
class Team
{
	public var color:Int;
	var worms:Int;
	var activeWorm:Worm;
	var otherWorms:List<Worm>;
	
	public function new() 
	{
		otherWorms = new List();
		worms = 0;
	}
	
	public function add(worm:Worm)
	{
		worm.team = this;
		otherWorms.add(worm);
		worms++;
		worm.onAddToTeam();
	}
	
	public function next():Worm {
		do 
		{
			activeWorm = otherWorms.pop();
		} while (activeWorm != null && activeWorm.hp > 0);
		otherWorms.add(activeWorm);
		return activeWorm;
	}
}