package views.components.characters;
import nme.Assets;
import nme.display.BitmapData;
import nme.geom.Rectangle;
import nme.media.Sound;
import views.sprites.SpriteSequence;
import views.sprites.tools.SpriteSheetCreator;

class PriestZombie extends Character
{
	static public inline var TYPE:String = "Priest";

	private var sounds:Sound;
	
	public function new( viewPort:Rectangle ) 
	{
		var shc:SpriteSheetCreator = new SpriteSheetCreator();
		
		// make some noise!
		sounds = Assets.getSound ( "sfx/DIE1.mp3" );
		
		// create frame sequences :
		for ( i in 200...207 ) 
		{
			shc.addFrame( Assets.getBitmapData( "image/sprites/Zombies.SHP." + i + ".png" ), i+"_frame" );
		}
		super( shc.exportBitmapData(), viewPort, TYPE );
		shc.destroy();
		
		this.y = viewPort.height - 77;
		this.x = Std.int(Math.random() * (viewPort.width - 53) );
		
	}
	
	override public function setUpFrames():Void 
	{
		//var frames:SpriteSequence = getSequence();
		var oblong:Rectangle = new Rectangle( 0, 0, 53, 77 );
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
	
	// Returns the amount of points that this character is worth
	override public function damage(power:Float = 1):Int 
	{
		if ( sounds != null ) sounds.play ();
		
		super.damage(power);
		return 1;
	}
	
	override public function update( timeCode:Int ):Bool 
	{
		//this.x += 1;
		if ( frameCheck( timeCode ) ) 
		{
			getSequence().next();
			return true;
		}
		
		return false;
	}
}