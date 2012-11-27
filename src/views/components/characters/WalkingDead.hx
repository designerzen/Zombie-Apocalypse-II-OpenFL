package views.components.characters;

/**
 * ...
 * @author zen
 */

class WalkingDead 
{

	public function new() 
	{
		
		var shc:SpriteSheetCreator = new SpriteSheetCreator();
		for ( i in 210...219 ) 
		{
			var bitmap:BitmapData = Assets.getBitmapData( "image/sprites/Zombies.SHP." + i + ".png" );
			shc.addFrame( bitmap, i+"_frame" );
		}
		shc.exportBitmapData();
	}
	
}