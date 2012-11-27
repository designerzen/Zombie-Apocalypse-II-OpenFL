package views.sections;

import models.Player;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.PixelSnapping;
import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;

class Section extends Sprite
{
	private var background:BitmapData;
	private var backgroundOriginal:BitmapData;
	private var bitmap:Bitmap;
	private var viewPort:Rectangle;
	private var origin:Point;
	
	public var timeAdded:Float;
	public var type:String;
	
	public var player:Player;
	
	public function new( bitmapData:BitmapData, sectionID:String="Section" , mask:Rectangle=null ) 
	{
		// create a transparent 32-bit bitmap
		var alphaImage:BitmapData = new BitmapData( bitmapData.width, bitmapData.height, false, 0 );
		origin = new Point();
		alphaImage.copyPixels( bitmapData, bitmapData.rect, origin );
		bitmapData.dispose();
		
		type = sectionID;
		background = alphaImage;
		//backgroundOriginal = background.clone();
		// jeash doesn't like clone()? ;(
		backgroundOriginal =  new BitmapData( background.width, background.height, false, 0 );
		backgroundOriginal.copyPixels( background, background.rect, origin );
		
		
		bitmap = new Bitmap( background, AUTO, false );
		viewPort = (mask != null ) ? mask : new Rectangle( 0, 0, background.width, background.height );
		
		super( );
		
		addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
	}
	
	private function onAddedToStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		
		addChild( bitmap );
		
		timeAdded = Lib.getTimer();
		
		added();
		
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		addEventListener( Event.ENTER_FRAME, onEveryFrame );
	}
	
	// override!
	private function added() 
	{
		
	}
	
	private function onRemovedFromStage(e:Event):Void 
	{
		removeEventListener( Event.ENTER_FRAME, onEveryFrame );
		removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		removed();
	}
	
	// override!
	private function removed() 
	{
		// now redraw the background original to background ready for redisplay
		// background.copyPixels( backgroundOriginal, backgroundOriginal.rect, new Point() );
		// or destroy!
		// FIXME :
		background.dispose();
		background = null;
		backgroundOriginal.dispose();
		backgroundOriginal = null;
	}
	
	/*
	static double lastUpdate=0;
	if (lastUpdate!=0) {
	  deltaT = time() - lastUpdate;
	  velocity += acceleration * deltaT;
	  position += velocity * deltaT;
	}
	lastUpdate = time();
	*/
	private function onEveryFrame(e:Event):Void 
	{
		var now:Float = Lib.getTimer();
		var timeElapsed:Int = Std.int( now - timeAdded );
		update( timeElapsed );
	}
	
	private function update( elapsed:Int ):Void
	{
		
	}
}