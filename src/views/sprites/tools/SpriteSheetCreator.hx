/*////////////////////////////////////////////////////////////////////////////

Creates a large bitmap from a series of smaller bitmaps and automatically
create the appropriate SpriteSequence (which can itself export to xml)

////////////////////////////////////////////////////////////////////////////*/
package views.sprites.tools;

import nme.errors.Error;
import nme.geom.Point;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.geom.Rectangle;
import views.sprites.BitmapSpriteFrame;
import views.sprites.SpriteFrame;
import views.sprites.SpriteSequence;
import views.sprites.SpriteSheet;


class SpriteSheetCreator extends Bitmap
{

	private var sheetData:BitmapData;
	private var spriteSheet:SpriteSheet;
	
	private var collection:Array<BitmapSpriteFrame>;
	
	public function new() 
	{
		//frames = new Array<BitmapData>();
		collection = new Array<BitmapSpriteFrame>();
		super();
	}
	
	public function addFrame( bitmapData:BitmapData, name:String ):Void
	{
		//frames.push( bitmapData );
		var frame:BitmapSpriteFrame = new BitmapSpriteFrame( bitmapData, 0,0, name );
		collection.push( frame );
		sheetData = null;
	}
	
	// Creates a root squared bitmap which
	// features all your sprites
	public function exportBitmapData():BitmapData
	{
		// check cache!
		if (sheetData != null) return sheetData;
		
		// ensure there are frames added!
		if ( collection.length < 1 ) throw new Error( "Cannot Export Bitmap Data as there are no frames! Be sure to addFrame() before calling this export method." );
		
		
		// loop through the bitmaps & work out the 
		// area of all of the sprites
		var area:Int = 0;
		for ( f in 0...collection.length )
		{
			var bitmapFrame:BitmapSpriteFrame = collection[f];
			var bitmapDataFrame:BitmapData = bitmapFrame.bitmapData;
			area += bitmapDataFrame.width * bitmapDataFrame.height;
		}
		
		// empty
		if ( area < 1 ) throw new Error( "Cannot Export Bitmap Data from Frames as area is empty. Maybe add more frames" );
		
		// work out how big we should make our bitmap...
		// for speed it is best to have it at one of the following
		// breakdowns (all squares with Integer roots)
		var side:Int = Std.int( Math.sqrt( area ) );
		var point:Point = new Point();
		var oblong:Rectangle = new Rectangle();
		
		// now create our data...frame
		sheetData = new BitmapData( side, side, true, 0x00ffffff );
		
		// and our associated sprite sheet
		spriteSheet = new SpriteSheet( sheetData );
		
		// TODO : Re-organise the collection
		
		var rowX:Int = 0;
		var columnY:Int = 0;
		
		// now loop through and add the frames!
		for ( f in 0...collection.length )
		{
			var bitmap:BitmapSpriteFrame = collection[f];
			var bitmapDataFrame:BitmapData = bitmap.bitmapData;
			oblong = bitmap.mask.clone();
			oblong.x = point.x = rowX;
			oblong.y = point.y = columnY;
			sheetData.copyPixels( bitmapDataFrame, bitmapDataFrame.rect, point );
			rowX += Std.int( oblong.width );
			if ( rowX > side )
			{
				rowX = 0;
				columnY += Std.int( oblong.height );
			}
			
			// now save this as a frame in our sequence
			
			spriteSheet.addFrame( oblong, bitmap.name );
		}
		
		bitmapData = sheetData;
		
		return sheetData;
	}
	
	// Creates a root squared bitmap which
	// features all your sprites
	public function exportSpriteSheet():SpriteSheet
	{
		return spriteSheet;
	}	
	
	public function exportSequence():SpriteSequence
	{
		return spriteSheet.getSequence();
	}
	
	// Fetch the frames with their specified names and locations
	// and dimensions on the sprite sheets
	public function exportFrameSettings():String
	{
		return "";// spriteSheet.exportSettings();
	}
	
	public function destroy() 
	{
		sheetData = null;
		spriteSheet = null;
	
		collection = [];
	}
}