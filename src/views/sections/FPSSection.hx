package views.sections;

import controllers.input.GlobalInput;
import controllers.input.Keys;
import controllers.input.Mouse;
import models.events.SectionEvent;
import nme.display.BitmapData;
import nme.geom.Rectangle;
import views.components.characters.Character;
import views.components.widgets.Cursor;

/*
 
First Person Shooter Section

 */

class FPSSection extends Section
{
	private var cursor:Cursor;
	private var mouse:Mouse;
	private var keyboard:Keys;
	
	public function new( bitmapData:BitmapData, sectionID:String="FPSSection" , mask:Rectangle=null ) 
	{
		cursor = new Cursor();
		super( bitmapData, sectionID , mask );
	}
	
	override private function added():Void 
	{
		super.added();
		mouse = GlobalInput.mouse;
		keyboard = GlobalInput.keyboard;
		addChild( cursor );
	}
	
	override private function removed():Void 
	{
		//removeChild( cursor );
		mouse = null;
		keyboard = null;
		super.removed();
	}
	
	// Move crosshairs
	override private function update(elapsed:Int):Void 
	{
		cursor.x = stage.mouseX;
		cursor.y = stage.mouseY;
		super.update(elapsed);
	}
	
	
	
	
	private function onComplete():Void
	{
		dispatchEvent( new SectionEvent( SectionEvent.REQUEST_REMOVAL ) );
	}
	/*
	private function onMouseMove( event:MouseEvent ):Void 
	{
		cursor.x = stage.mouseX;
		cursor.y = stage.mouseY;
		event.updateAfterEvent();
	}
	*/
}