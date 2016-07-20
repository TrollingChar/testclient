package hz.company.testclient.bf.weapons;
import company.testclient.bf.weapons.Weapon;

/**
 * ...
 * @author 
 */
class NoWeapon extends Weapon
{

	public function new(/*worm:Worm*/) 
	{
		super(worm);
		ch.visible = false;
	}
	
	override public function addToMap(map:Map) 
	{
		this.map = map;
		map.layers[Layers.CROSSHAIR].addChild(ch);
		map.layers[Layers.CROSSHAIR].addChild(targ);
		drawWeapon();
		//map.camera.bindToObj(worm);
	}
		
	override public function update() { }
}