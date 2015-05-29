package controllers.input;

import openfl.display.Stage;
import openfl.events.EventDispatcher;
import openfl.events.MouseEvent;
import openfl.Lib;

class Mouse extends EventDispatcher
{
	private var stage:Stage;

	public var pressed:Bool = false;
	
	public function new() 
	{
		super();
		start();
	}
	
	// PUBLIC METHODS ---------------------------------------------------------------------
	
	public function enable() 
	{
		
	}
	
	public function disable() 
	{
		
	}
	
	public function start():Void
	{
		// Haxe rocks! AS3 would need a reference to the stage in the constructor :)
		stage = Lib.current.stage;
		stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
	}
	
	public function stop():Void
	{
		stage.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
	}
	
	// EVENTS -------------------------------------------------------------------------------
	
	private function onMouseDown( event:MouseEvent):Void 
	{
		pressed = true;
		stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
		dispatchEvent( event );
	}
	
	private function onMouseUp( event:MouseEvent):Void 
	{
		pressed = false;
		stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
		dispatchEvent( event );
	}
	
}