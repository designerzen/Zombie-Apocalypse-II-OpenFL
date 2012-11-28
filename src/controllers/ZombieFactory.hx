package controllers;
import nme.geom.Rectangle;
import views.components.characters.Character;
import views.components.characters.NudeZombie;
import views.components.characters.PriestZombie;
import views.components.characters.Torso;

/**
 * ...
 * @author zen
 */

class ZombieFactory extends Factory
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
			switch ( Std.int( Math.random() * 3) )
			{
				case 0: add( new PriestZombie( gamePort ) );
				case 1: add( new NudeZombie( gamePort ) );
				case 2: add( new Torso( gamePort ) );
			}
		}
	} 
}