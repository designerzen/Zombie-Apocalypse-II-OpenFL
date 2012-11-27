package models;

class Health 
{

	public var lives:Int;
	public var energy:Float;
	
	public function new( amountOfLives:Int=1, amountOfEnergy:Float=1 ) 
	{
		lives = amountOfLives;
		energy = amountOfEnergy;
	}
	
}