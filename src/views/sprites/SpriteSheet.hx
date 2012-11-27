package views.sprites;

import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.errors.ArgumentError;
import nme.errors.Error;
import nme.events.Event;
import nme.geom.Point;
import nme.geom.Rectangle;

/*

This is the bitmap that you fill with data then
request "frames" from.

*/

class SpriteSheet extends Bitmap
{
	private var oblong:Rectangle;
	private var position:Point;
	private var source:BitmapData;
	
	private var sequences:Hash<SpriteSequence>;
	
	public var activeFrame:SpriteFrame;
	
	// Construct
	public function new( bitmapDataSheet:BitmapData ) 
	{
		source = bitmapDataSheet;
		
		position = new Point();
		oblong = new Rectangle();
		sequences = new Hash();
		sequences.set( "default", new SpriteSequence( ) );
		
		super();
		addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
	}
	
	private function onAddedToStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		added();
	}
	
	private function added() 
	{
		bitmapData = source;
	}
	
	// ===========================================================================
	
	// Clone the bitmap data area of *just* this frame
	public function getBitmapData( frameID:String, sequenceID:String="default" ):BitmapData
	{
		var frame:SpriteFrame = getFrame( frameID, sequenceID );
		var segment:BitmapData = new BitmapData(10, 10, true, 0xffffffff);
		// draw frame onto segment
		position.x = 0;
		position.y = 0;
		segment.lock();
		segment.copyPixels( source, frame.mask, position );
		segment.unlock();
		//frame
		return segment;
	}	
	
	public function getFrame( frameID:String, sequenceID:String="default" ):SpriteFrame
	{
		activeFrame = sequences.get( sequenceID ).getFrame( frameID );
		return activeFrame;
	}

	// see if we have a sequence in memory that matches that id
	public function getSequence( sequenceID:String="default" ):SpriteSequence
	{
		return sequences.get( sequenceID );
	}
	
	// if we have a sequence created externally that we wish to inject into the method
	public function setSequence( sequence:SpriteSequence, sequenceID:String="default" ):Void
	{
		// check to see if this has a frame
		if ( activeFrame == null ) activeFrame = sequence.frames[0];
		sequences.set( sequenceID, sequence );
	}
	
	
	// Paste a sprite's frame onto the target canvas at location x and y
	public function copyFramePixels( canvas:BitmapData, frameID:String, x:Int, y:Int, sequenceID:String="default" ):Rectangle
	{
		// first lets try and get this frame data...
		if ( sequences.exists( sequenceID ) )
		{
			// sequence exists! now fetch it and copy pixels
			var sequence:SpriteSequence = sequences.get( sequenceID );
			var frame:SpriteFrame = sequence.getFrame( frameID );
			position.x = x;
			position.y = y;
			oblong = frame.mask;
			//oblong.x = frame.x;
			//oblong.y = frame.y;
			canvas.lock();
			canvas.copyPixels( source, frame.mask, position );
			canvas.unlock();
			return oblong;
		}else {
			// no sequence with this name
			throw new ArgumentError( "Sequence "+sequenceID+" has not been previously registered. Use createSequence() first." );
		}
		return null;
	}
		// Paste a sprite's frame onto the target canvas at location x and y
	public function copySequencePixels( canvas:BitmapData, x:Int=0, y:Int=0, sequenceID:String="default", lock:Bool=true ):Void
	{
		// first lets try and get this frame data...
		if ( sequences.exists( sequenceID ) )
		{
			// sequence exists! now fetch it and copy pixels
			var sequence:SpriteSequence = sequences.get( sequenceID );
			var frame:SpriteFrame = sequence.getCurrent();
			position.x = x;
			position.y = y;
			if ( lock ) canvas.lock();
			canvas.copyPixels( source, frame.mask, position );
			if ( lock )  canvas.unlock();
			
		}else {
			// no sequence with this name
			throw new ArgumentError( "Sequence "+sequenceID+" has not been previously registered. Use createSequence() first." );
		}
	}
	
	
	// Define a small portion of the large spritesheet as a specific 'frame'
	public function addFrame( rectangle:Rectangle, frameID:String, sequenceID:String="default" ):String
	{
		// Create a model of the intended data but don't create any bitmaps
		var frame:SpriteFrame = new SpriteFrame( rectangle, frameID );
		// if there is a sequence name, append it !
		var sequenceExists:Bool = sequences.exists( sequenceID);
		
		var sequence:SpriteSequence = ( sequenceExists ) ? sequences.get( sequenceID ) : sequences.get( "default" );
		if (!sequenceExists) throw new Error( "No Sequence with the name '"+sequenceID+"' exists" );
		sequence.append( frame );
		
		if ( activeFrame == null ) activeFrame = frame;
		
		return frameID;
	}
	
	// A way of defining multiple frames in a row
	public function createSequence( sequenceID:String="default" ):SpriteSequence
	{
		var spriteSequence:SpriteSequence = new SpriteSequence( );
		sequences.set( sequenceID, spriteSequence );
		return spriteSequence;
	}
	
	// TODO : Empty our library of references
	public function clearAll():Void
	{
		//sequences.remove();
	}
	
	
	
}
