package views.components.characters;

import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import openfl.Lib;
import views.sprites.SpriteSheet;

class Character extends SpriteSheet
{
	public var type:String;
	public var screen:Rectangle;
	public var energy:Float = 1;
	
	// TODO : Override width & height with currentFrame.mask
	
	//override 
	public var dimensions( get_dimensions, null ):Rectangle;
	
	private function get_dimensions( ):Rectangle
	{
		return activeFrame.mask;
	}
	
	// ===============================================================
	public var previousCharacter:Character;
	public var nextCharacter:Character;
	
	public function unlink( clearFromMemory:Bool = true ):Void
	{
		// bind last to next
		if (previousCharacter != null) previousCharacter.nextCharacter = nextCharacter;
		// and next to last
		if ( nextCharacter != null ) nextCharacter.previousCharacter = previousCharacter;
		if ( clearFromMemory ) destroy();
	}
	// ===============================================================
	
	private var fps:Int = 15;
	private var beginTime:Int;
	private var frameDuration:Float;
	public var frameRate( get_frameRate, set_frameRate ):Int;
	
	private function get_frameRate():Int
	{
		return fps;
	}
	public function set_frameRate( framesPerSecond:Int=32 ):Int
	{
		beginTime = 0;
		frameDuration = 1000 / framesPerSecond;
		return fps = framesPerSecond;
	}

	// SPEED UP / SLOW DOWN THE ANIMATION DEPENDENT ON FRAMERATE!
	private function frameCheck( timeCode:Int ):Bool 
	{
		if ( beginTime == 0 ) beginTime = timeCode;
		
		var elapsed:Int = timeCode - beginTime;
		
		// check to see if enough time has passed before updating!
		if ( elapsed > frameDuration )
		{
			beginTime = timeCode;
			return true;
		}
		
		return false;
	}
	// ===============================================================
	
	// Construct!
	public function new( bitmapDataSheet:BitmapData, viewPort:Rectangle = null,  characterType:String = "Character" ) 
	{
		screen = viewPort;
		type = characterType;
		frameDuration = 1000 / fps;
		super( bitmapDataSheet );
		setUpFrames();
	}
	
	// Over-ride
	public function setUpFrames():Void
	{
		
	}

	// works out from the spritesheet whether or not this pixel
	// location on the original bitmap is 100% transparent
	public function collisionTest( x:Int, y:Int ):Bool
	{
		// if no frame has been requested
		if ( activeFrame == null ) return false;
		// work out the offset of this frame and subtract
		if ( x > activeFrame.width ) return false;
		if ( y > activeFrame.height ) return false;
		// find out where on the spritesheet the frame lives
		// var offsetX:Int = x + activeFrame.x;
		// var offsetY:Int = y + activeFrame.y;
		// first check to see if we are in the correct zone!
		var colour:Int = source.getPixel32( x + activeFrame.x, y+activeFrame.y ); //-Std.int(this.y)
		if (colour == 0) return false;
		else return true;
	}
	// Over-ride
	
	// a way of killing a character!
	// Returns the amount of points that this character is worth
	public function damage( power:Float=0.2 ):Int
	{
		energy -= power;
		return 0;
	}
	
	public function destroy() 
	{
		// clean up memory!
	}
	
	
	// Over-ride!
	// Returns true if the sprite has changed
	// or false if it hasn't
	public function update( timeCode:Int ):Bool
	{
		return frameCheck( timeCode );
	}
	
	public function render( timeCode:Int, background:BitmapData, sequenceID:String="default", lock:Bool=true ) :Void
	{
		update( timeCode );
		// always paint it!
		copySequencePixels( background, Std.int(this.x), Std.int(this.y), sequenceID, lock );
	}
}