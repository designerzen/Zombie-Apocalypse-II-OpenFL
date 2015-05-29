package views.components.characters;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import views.sprites.SpriteSequence;
import views.sprites.tools.SpriteSheetCreator;

/**
 * This is each letter of the zombie font in one EM
 * 
 * @author zen
 */

class FontLetter extends Character
{
	static public inline var TYPE:String = "Letter";

	private static var creator:SpriteSheetCreator;
	
	private function getCreator():SpriteSheetCreator
	{
		if ( creator == null )
		{
			creator = new SpriteSheetCreator();
			var frameLabels:Array<String> = [ 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9' ];
			var beginAt:Int = 200;
			var endAt:Int = frameLabels.length+beginAt;
			for ( i in beginAt...endAt ) creator.addFrame( Assets.getBitmapData( "font/FONT16.SHP." + i + ".png" ), frameLabels[i-beginAt] );
			
		}
		return creator;
	}
	
	public function new()
	{
		// first check to see if we have a cached copy
		var shc:SpriteSheetCreator = getCreator();
		var viewPort:Rectangle = new Rectangle(0, 0, 17, 19);
		var bitmap:BitmapData = shc.exportBitmapData();
		
		super( bitmap, viewPort, TYPE );
		
		var fontSequence:SpriteSequence = shc.exportSequence();
		
		// set the default sequence here
		setSequence( fontSequence );
		//shc.destroy();
	}
	

}