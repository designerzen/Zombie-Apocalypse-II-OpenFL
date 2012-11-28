package controllers.input;
import controllers.input.Keys;
import controllers.input.Mouse;

/*

Static instances of regularly used input methods

 */

class GlobalInput 
{
	static public var mouse ( getMouse, null ):Mouse;
	static public var keyboard ( getKeyboard, null ) :Keys;

	static inline public function getMouse( ):Mouse
	{
		if ( mouse == null ) mouse = new Mouse();
		return mouse;
	}
	static inline public function getKeyboard( ):Keys
	{
		if ( keyboard == null ) keyboard = new Keys();
		return keyboard;
	}
	// a quick way of ignoring input
	static inline public function start( useMouse:Bool=false, useKeyboard:Bool=false ):Bool
	{
		// create if not created!
		if (useMouse) mouse.enable();
		if (useKeyboard) keyboard.enable();
		return true;
	}
	
	// a quick way of ignoring input
	static inline public function stop( useMouse:Bool=false, useKeyboard:Bool=false ):Bool
	{
		if (!useMouse) mouse.disable();
		if (!useKeyboard) keyboard.disable();
		return true;
	}
	
	
}