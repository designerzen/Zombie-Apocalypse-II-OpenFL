package views.sections.levels;

import nme.Assets;
import nme.geom.Rectangle;


class JunkYard extends FPSZombieSection
{

	static public inline var TYPE:String = "Junkyard";
	
	public function new() 
	{
		super( Assets.getBitmapData( "image/BACKDROP2.png", false ), TYPE, new Rectangle(0,0,320,200), 40 );	
	}
}