package views.components.characters;
import nme.Assets;
import nme.display.BitmapData;
import nme.geom.Rectangle;
import views.sprites.SpriteSequence;
import views.sprites.tools.SpriteSheetCreator;

class Torso extends Character
{
	static public inline var TYPE:String = "Torso";

	public function new( viewPort:Rectangle ) 
	{
		var shc:SpriteSheetCreator = new SpriteSheetCreator();
		
		for ( i in 220...227 ) 
		{
			shc.addFrame( Assets.getBitmapData( "image/sprites/Zombies.SHP." + i + ".png" ), i+"_frame" );
		}
		super( shc.exportBitmapData(), viewPort, TYPE );
		
		// set the default sequence here
		setSequence( shc.exportSequence() );
		
		
		shc.destroy();
		this.y = viewPort.height - 100;
		this.x = -69 + 1 + 70;
	}
	
	/*
	override public function setUpFrames():Void 
	{
		//var frames:SpriteSequence = getSequence();
		var oblong:Rectangle = new Rectangle( 0, 0, 69, 47 );
		// here we add our frames and sequences to X
		for ( row in 0...3 )
		{
			for ( column in 0...4 )
			{
				oblong.x = column * oblong.width;
				oblong.y = row * oblong.height;
				addFrame( oblong, "facing_"+row+":"+column );
			}
		}
	}
	*/
	// Returns the amount of points that this character is worth
	override public function damage(power:Float = 1):Int 
	{
		super.damage(power);
		return 1;
	}
	
	override public function update( timeCode:Int ):Bool 
	{
		this.x += 1;
		if ( frameCheck( timeCode ) ) 
		{
			getSequence().next();
			return true;
		}
		
		return false;
	}
}