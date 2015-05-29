package models;

import openfl.events.EventDispatcher;

class Player extends EventDispatcher
{
	public var health:Health;
	public var score:Points;
	public var name:String = "...";
	
	public function new() 
	{
		health = new Health( 1,1 );
		score = new Points();
		super();
	}
	
	public function addPoints( points:Int ):Int
	{
		// if we get over a cerrtain amount of points, 1UP
		return score.score += points;
	}
	
	public function removeEnergy( percent:Float ):Float
	{
		health.energy -= percent;
		// check to see if we are dead
		
		return health.energy;
	}
	
	// dispatches on dead event and bonuslife events to GUI
}