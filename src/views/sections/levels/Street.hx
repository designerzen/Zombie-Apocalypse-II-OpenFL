package views.sections.levels;

import openfl.Assets;
import openfl.geom.Rectangle;
import views.sections.FPSZombieSection;

class Street extends FPSZombieSection
{
	static public inline var TYPE:String = "Street";
	
	public function new() 
	{
		super( Assets.getBitmapData( "image/BACKDROP3.png", false ), TYPE, new Rectangle(0,0,320,200), 60 );
	}
}