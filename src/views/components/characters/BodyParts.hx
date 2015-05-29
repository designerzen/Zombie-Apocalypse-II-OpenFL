package views.components.characters;
import models.PhysicalProperties;
import openfl.Assets;
import views.sprites.tools.SpriteSheetCreator;

/**
 * ...
 * @author zen
 */

class BodyParts extends Character
{


	static public inline var TYPE:String = "BodyParts";
	
	private var physics:PhysicalProperties;
	
	public function new() 
	{
		var shc:SpriteSheetCreator = new SpriteSheetCreator();
		
		for ( i in 200...205 ) 
		{
			shc.addFrame( Assets.getBitmapData( "image/sprites/BODYPARTS.SHP." + i + ".png" ), i+"_frame" );
		}
		super( shc.exportBitmapData(), viewPort, TYPE );
		
		// set the default sequence here
		setSequence( shc.exportSequence() );
		
		
		shc.destroy();
	}
	
	override public function update():Void 
	{
		// fall in an arc away from the shot
		this.x += physics.inertiaX;
		this.y += physics.inertiaY;
		
		//activeFrame
		physics.update();
		super.update();
	}
	
}