package ;

import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.Lib;
import views.TestMediator;
import views.ZombieGameMediator;

/*



 */

class Main extends Sprite 
{
	// Called by the compiler!
	static public function main() 
	{
		// set the stage to remain at a fixed size
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		Lib.current.addChild( new Main() );
	}
	
	public function new() 
	{
		super();
		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end
	}

	private function init(e) 
	{
		// entry point
		addChild( new ZombieGameMediator() );
		//addChild( new TestMediator() );
	}
	
	
}
