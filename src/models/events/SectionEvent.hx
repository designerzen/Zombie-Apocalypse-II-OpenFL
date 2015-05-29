package models.events;

import openfl.events.Event;

class SectionEvent extends Event
{

	static public inline var REQUEST_REMOVAL:String = "section.requestingRemoval";
	
	public function new(type : String, bubbles : Bool = false, cancelable : Bool = false)
	{
		super( type, bubbles, cancelable );
	}

	override public function clone():Event 
	{
		return new SectionEvent( type, bubbles, cancelable );
	}
}