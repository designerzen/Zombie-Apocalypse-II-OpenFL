package controllers;
import openfl.geom.Rectangle;

/**
 * ...
 * @author zen
 */

class PowerUpFactory extends Factory
{
private var gamePort:Rectangle;

	public function new( viewPort:Rectangle ) 
	{
		gamePort = viewPort;
		super();
	}
	
	// a method that gets called every x seconds
	public function spawn( quantity:Int=1 ):Void
	{
		for ( c in 0...quantity )
		{
			var integer:Int = Std.int( Math.random() * 3);
			switch ( integer )
			{
				//case 0: add( new PriestZombie( gamePort ) );
				//case 1: add( new NudeZombie( gamePort ) );
				//	case 2: add( new Torso( gamePort ) );
				default:
			}
		}
	} 
}