package controllers.input;

import openfl.display.Stage;
import openfl.events.EventDispatcher;
import openfl.events.KeyboardEvent;
import openfl.Lib;

class Keys extends EventDispatcher
{

	private var stage:Stage;

	public var pressed:Bool = false;
	public var held:Int = -1;
	
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
		stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
	}
	
	public function stop():Void
	{
		stage.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
	}
	
	// EVENTS -------------------------------------------------------------------------------
	
	private function onKeyDown( event:KeyboardEvent ):Void 
	{
		pressed = true;
		held = event.keyCode;
		stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		dispatchEvent( event );
	}
	
	private function onKeyUp( event:KeyboardEvent ):Void 
	{
		pressed = false;
		held = -1;
		stage.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		dispatchEvent( event );
	}
	
}