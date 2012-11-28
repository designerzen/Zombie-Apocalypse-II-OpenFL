package views.sections.levels;

import nme.Assets;
import nme.geom.Rectangle;
import views.sections.FPSZombieSection;

class Reactor extends FPSZombieSection
{

	static public inline var TYPE:String = "Reactor";
	
	public function new() 
	{
		super( Assets.getBitmapData( "image/BACKDROP4.png", false ),TYPE, new Rectangle(0,0,320,200), 60 );
	}
	
}