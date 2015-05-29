package views.sprites;

import openfl.display.BitmapData;
import openfl.geom.Rectangle;

class BitmapSpriteFrame
{

	public var mask:Rectangle;
	
	public var name:String;
	public var id:Int;
	public var x:Int;
	public var y:Int;
	public var width:Int;
	public var height:Int;
	public var bitmapData:BitmapData;
	
	public function new( bitmapFrame:BitmapData, x:Int, y:Int, title:String='none' )
	{
		name = title;
		this.x = x;
		this.y = y;
		width = Std.int( bitmapFrame.width );
		height = Std.int( bitmapFrame.height );
		bitmapData = bitmapFrame;
		mask = new Rectangle( x,y, width, height );
	}
	
}