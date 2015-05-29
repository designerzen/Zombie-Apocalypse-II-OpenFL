package views.components.characters;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Tilesheet;
import openfl.geom.Point;
import openfl.geom.Rectangle;

class Walker extends Character
{
	private var spriteList:Tilesheet;
	
	private var count:Int = 0;
	private var frame:Int = 0;
	private var tileData:Array<Float>;
	
	private var flags:Int;
	private var oblong:Rectangle;
	private var centre:Point;
	
	public function new() 
	{
		//var spriteSheet:BitmapData = ;
		spriteList = new Tilesheet( Assets.getBitmapData( "image/sprites/ZombieBrain.png" ) );
		
		oblong = new Rectangle();
		centre = new Point();
		
		// frame 0 :
		var frameStill:Int = addFrame( oblong, centre );
		
		tileData = new Array<Float>();
		
		paintFrame( frameStill, 0, 0 );
		super();
	}
	
	public function addFrame( rectangle:Rectangle, centerPoint:Point = null, name:String = '' ):Int
	{
		// if there is a name, save this in our hash!
		spriteList.addTileRect( oblong, centre );
		return count++;
	}
	
	public function clear():Void
	{
		tileData = [];
	}
	
	// scale, rotation, red, green, blue, alpha
	public function paintFrame( id:Int, x:Int, y:Int ):Array<Float>
	{
		flags = 3;// arguments.length;
		// add as many tiles to draw at once (you can even overlay them!)
		// [ x, y, tile ID, scale, rotation, red, green, blue, alpha
		return tileData = tileData.concat( [ x, y, id ] );	// x, y, frame
	}
	
	// update the animation ( called from single loop )
	override public function update():Bool
	{
		graphics.clear();
		spriteList.drawTiles( graphics, tileData, false, flags );
		frame = ( frame+1 > count ) ? 0 : frame+1;
	}
	
}