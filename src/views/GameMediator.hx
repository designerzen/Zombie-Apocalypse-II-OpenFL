package views;

import models.Player;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

import flash.events.Event;
import models.events.SectionEvent;

import views.sections.Section;

class GameMediator extends Sprite
{

	// current section
	private var section:Section;
	private var player:Player;
	
	public function new() 
	{
		super();
		addEventListener( Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	private function onAddedToStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		added();
	}
	
	private function added() 
	{
		
	}
	
	// changing section calls the "removed" method
	public function changeSection( screen:Section ):Void
	{
		// remove existing
		if ( section != null ) 
		{
			removeChild( section );
			section.removeEventListener( SectionEvent.REQUEST_REMOVAL, onRemovalRequest );
		}
		
		// add new
		section = screen;
		section.player = player;
		section.addEventListener( SectionEvent.REQUEST_REMOVAL, onRemovalRequest );
		addChildAt( section, 0 );
	}
	
	private function onRemovalRequest(event:SectionEvent):Void 
	{
		changeState( section );
	}
	
	private function changeState( fromSection:Section ):Void
	{
		
	}
	
}