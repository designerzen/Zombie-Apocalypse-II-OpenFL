package controllers.input;
import nme.events.EventDispatcher;

/**
 * ...
 * @author zen
 */

class JoyStick extens EventDispatcher
{

	public function new() 
	{
			Lib.current.stage.addEventListener (JoystickEvent.AXIS_MOVE, stage_onJoyAxisMove);
Lib.current.stage.addEventListener (JoystickEvent.BALL_MOVE, stage_onBallMove);
Lib.current.stage.addEventListener (JoystickEvent.BUTTON_DOWN, stage_onJoyButtonDown);
Lib.current.stage.addEventListener (JoystickEvent.BUTTON_UP, stage_onJoyButtonUp);
Lib.current.stage.addEventListener (JoystickEvent.HAT_MOVE, stage_onJoyHatMove);
	}
	
}