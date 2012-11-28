package views.components.widgets;

import nme.Assets;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.events.Event;
import nme.ui.Mouse;

class Cursor extends Sprite
{

	public function new() 
	{
		super();
		var bitmapData:BitmapData = Assets.getBitmapData( "image/sprites/Pointer.png" );
		var bitmap:Bitmap = new Bitmap( bitmapData );
		bitmap.x = - bitmap.width * 0.5;
		bitmap.y = - bitmap.height * 0.5;
		addChild( bitmap );
		addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
	}
	
	private function onAddedToStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		Mouse.hide();
		addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
	}
	
	private function onRemovedFromStage(e:Event):Void 
	{
		removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		Mouse.show();
	}
	
	private function onLeftStage():Void
	{
		
	}
	
	private function onReturnedToStage():Void
	{
		
	}
	
	override public function toString():String 
	{
		return "x:"+this.x+" y:"+this.y;
	}
}