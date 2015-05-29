/*////////////////////////////////////////////////////////////////////////////

-

////////////////////////////////////////////////////////////////////////////*/
package views.sprites.tools;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;

/*
 
A development class that helps you add frames in the right area over
a sprite sheet by simply dragging the rectangle around and double clicking
to create a frame.

re-order them too

 */

class SpriteSheetHelper extends Sprite
{
	private var sheet:SpriteSheet;
	
	private var previewer:Bitmap
	
	public function new( bitmapDataSheet:BitmapData ) 
	{
		super();
		previewer = new Bitmap( new BitmapData( 100, 100, true, 0 ) );
		sheet = new SpriteSheet( bitmapDataSheet );
		addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
	}
	
	private function onAddedToStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		
		addChild( sheet );
		
		this.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
		previewer.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
		
		addEventListener( Event.ENTER_FRAME, onEveryFrame );
	}
	
	// Update preview
	private function onEveryFrame(e:Event):Void 
	{
		//previewer.bitmapData.fillRect
		sheet.copyFramePixels( previewer.bitmapData, "default", 0, 0);
	}
	
	
}

class SpriteMask extends Shape
{
	public function new()
	{
		
	}
}