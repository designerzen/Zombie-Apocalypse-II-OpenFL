package views.components.animations;

import openfl.display.BitmapData;
import openfl.events.Event;
import openfl.events.EventDispatcher;

class BloodDripping extends EventDispatcher
{

	inline static public var COMPLETE:String = "bloodDrippibgCompleted";
	
	private var dripLengths:Array<Int>;
	private var dripComplete:Array<Bool>;
	private var canvas:BitmapData;
	private var completionCounter:Int;
	private var complete:Bool = true;
	private var rate:Int;
	
	public function new( speed:Int = 2 ) 
	{
		rate = speed;
		super();
	}
	
	public function registerBitmap( bitmapData:BitmapData ):Void
	{
		completionCounter = 0;
		complete = false;
		dripLengths = new Array<Int>();
		dripComplete = new Array<Bool>();
		canvas = bitmapData;
		for ( b in 0...canvas.width )
		{
			dripLengths[ b ] = 0;
			dripComplete[ b ] = false;
		}
	}
	
	public function update():Void
	{
		// nothing to update
		if ( complete ) return ;
		
		// fetch a random number 
		var column:Int = Std.int( Math.random() * dripLengths.length );
		
		// check to see if it is already complete
		var completed:Bool = dripComplete[ column ];
		
		// if it is... search for the next free one or return...
		if (completed) return;
		
		for ( i in 0...rate )
		{
			// there is still some room left! fill it...
			var quantity:Int = dripLengths[ column ]++;
			// now check to see if it is already full
			if ( quantity >= canvas.height ) 
			{
				// increment complete counter...
				dripComplete[ column ] = true;
				completionCounter++;
				break;
			}else {
				// or else paint it red
				// lets do some colour conversion here as we cannot guarantea that we have an alpha channel at all!
				var rgb:Int = canvas.getPixel(column, quantity);
				var r = rgb >> 16 & 0xFF;
				var g = rgb >> 8 & 0xFF;
				var b = rgb & 0xFF;
				
				r = 255;
				g = Std.int( g * 0.75);
				b = Std.int( b * 0.75);
				
				var hex:Int = ( ( r << 16 ) | ( g << 8 ) | b );

				canvas.setPixel( column, quantity, hex );			
			}
		}
		
		// now check to see if we have completed all blood
		if ( completionCounter >= dripComplete.length ) onComplete();
		
	}

	private function onComplete():Void
	{
		complete = true;
		dispatchEvent( new Event( COMPLETE ) );
	}
}