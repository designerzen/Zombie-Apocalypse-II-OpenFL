package views.sprites;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Rectangle;

class BitmapMovieClip extends Sprite
{
	private var sprites:SpriteSheet;
	private var sequence:SpriteSequence;
	private var oblong:Rectangle;
	
	private var canvas:BitmapData;
	
	public function new( bitmapData:BitmapData, width:Int, height:Int ) 
	{
		super();
		canvas = new BitmapData( width, height, true );
		oblong = new Rectangle( 0, 0, width, height );
		sprites = new SpriteSheet( bitmapData );
		sequence = sprites.getSequence();
		addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
	}
	
	public function addFrame( x:Float, y:Float , frameID:String ):Void
	{
		oblong.x = x;
		oblong.y = y;
		sprites.addFrame( oblong, frameID );
	}
	
	private function onAddedToStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addChild( new Bitmap( canvas ) );
		play();
	}
	
	public function play():Void
	{
		addEventListener( Event.ENTER_FRAME, onEveryFrame );
	}
	
	public function stop( ):Void
	{
		removeEventListener( Event.ENTER_FRAME, onEveryFrame );
	}
	
	public function gotoAndPlay( frame:String ):Void
	{
		play();
	}
	public function gotoAndStop( frame:String ):Void
	{
		
	}
	
	private function onEveryFrame(e:Event):Void 
	{
		/**/
		canvas.lock();
		canvas.fillRect( oblong, 0xffffffff );
			
		sprites.copySequencePixels( canvas, 0, 0 , false );
		canvas.unlock();
		
		sequence.next();
		//this.alpha = Math.random();
		
	}
	
	
	
}