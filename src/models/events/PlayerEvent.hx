package models.events;

import nme.events.Event;

class PlayerEvent extends Event 
{
	static public inline var GAME_OVER:String = "player.gameOver";
	static public inline var DEAD:String = "player.died";
	
	public function new(type : String, bubbles : Bool = false, cancelable : Bool = false)
	{
		super( type, bubbles, cancelable );
	}

	override public function clone():Event 
	{
		return new PlayerEvent( type, bubbles, cancelable );
	}
}