/*

This is for composite fonts that are made up from lots and lots of 
individual bitmaps. For Bitmap fonts that depend on a spritesheet
use SpriteSheetFont

*/

package views.sprites;

import openfl.display.Bitmap;
import openfl.display.BitmapData;

class BitmapFont
{
	private var library:Hash<BitmapData>
	
	public function new() 
	{
		library = new Hash<BitmapData>();
	}
	
	public function add( character:String, bitmapData:BitmapData ):Void
	{
		library.set( character, bitmapData );
	}
	
	// short way of adding lowercase a-z
	public function addAtoZ( arrayOfCharacters:Array<BitmapData> ):Void
	{
		for ( c in 0...26 )
		{
			var data:BitmapData = arrayOfCharacters[ c ];
			add( i, data );
		}
	}
	
	public function fetch( character:String ):BitmapData
	{
		return library.get( character );
	}
}