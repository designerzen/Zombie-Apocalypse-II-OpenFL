package views.sprites;
import openfl.geom.Rectangle;


// A simple model sub class to hold individual frame data
class SpriteFrame
{
	public var mask:Rectangle;
	
	public var name:String;
	public var id:Int;
	public var x:Int;
	public var y:Int;
	public var width:Int;
	public var height:Int;
	
	public function new( oblong:Rectangle, title:String='none' )
	{
		name = title;
		mask = oblong.clone();
		x = Std.int( oblong.x );
		y = Std.int( oblong.y );
		width = Std.int( oblong.width );
		height = Std.int( oblong.height );
	}

	public function toString():String
	{
		return "Name : "+name+" x:"+x+" y:"+y + " width:"+width+" height:"+height;
	}
}

