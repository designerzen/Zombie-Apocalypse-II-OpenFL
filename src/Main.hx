package ;

import openfl.display.Sprite;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.events.Event;
import views.TestMediator;
import views.ZombieGameMediator;

/*



 */

class Main extends Sprite 
{
	
	public function new() 
	{
		super();
		// set stage
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		// entry point
		addChild( new ZombieGameMediator() );
		//addChild( new TestMediator() );
	}
}
