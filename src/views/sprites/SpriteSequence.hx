package views.sprites;

import openfl.errors.Error;
import openfl.geom.Rectangle;

// A simple model sub class to hold named sequences of frames
class SpriteSequence
{
	public var mask:Rectangle;
	
	public var name:String;
	public var frames:Array<SpriteFrame>;
	public var library:Map<String, SpriteFrame>;
	
	public var quantity:Int = 0;
	public var position:Int = 0;
	
	public function new( id:String="default", framesInSequence:Array<SpriteFrame>=null )
	{
		library = new Map();
		name = id;
		if ( framesInSequence != null )
		{
			frames = framesInSequence;
			quantity += frames.length;
			mask = frames[0].mask;
		}else {
			frames = new Array<SpriteFrame>();
		}
		
	}

	public function getFrame( id:String ):SpriteFrame
	{
		if ( library.exists( id ) ) return library.get( id );
		else throw new Error("No Frame with the name '"+id+"' exists in the sequence "+name );
	}
	
	public function append( frame:SpriteFrame ):Void
	{
		frames.push( frame );
		library.set( frame.name, frame );
		mask = frame.mask;
		quantity++;
	}
	
	// check to see if it is valid...
	public function getCurrent():SpriteFrame
	{
		if ( quantity < 1 ) throw new Error( "Frames must be added to a sequence to start!" );
		return frames[ position ];
	}
	
	public function goto( frame:Int ):SpriteFrame
	{
		position = frame;
		return frames[ position ];
	}
	
	public function next():SpriteFrame
	{
		// loop
		position = ( position + 1 < quantity ) ? position + 1 : 0;
		//trace( frames[position] );
		return frames[position];
	}
	
	public function previous():SpriteFrame
	{
		// loop
		position = ( position - 1 > 0 ) ? position - 1 : quantity - 1;
		return frames[position];
	}
	
	// Export this as a snippet of text that can be saved to disk
	// then loaded into a spriteSheet with the import command
	public function importSettings()
	{
		
	}
	public function exportSettings()
	{
		
	}
	
	// output : Sequence 'sequence' : frame#1 { name }
	public function toString():String
	{
		var output:String = 'Sequence "'+name+'" : ';
		for ( i in 0...frames.length ) output += '\n\tFrame#'+i+' { ' + frames[ i ] + ' }';
		return output;
	}
}