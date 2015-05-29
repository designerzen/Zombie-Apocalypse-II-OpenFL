package views.components.characters;

import openfl.Assets;
import openfl.geom.Rectangle;
import openfl.media.Sound;
import views.sprites.tools.SpriteSheetCreator;
import views.components.characters.ICharacter;

class NudeZombie extends Character implements ICharacter
{
	static public inline var TYPE:String = "Nudie";

	private var directionFromLeft:Bool;
	private var sounds:Sound;
	
	public function new( viewPort:Rectangle = null, fromLeft:Bool=true ) 
	{
		var shc:SpriteSheetCreator = new SpriteSheetCreator();
	
		// make some noise!
		sounds = Assets.getSound ( "sfx/DIE2.mp3" );
		
		for ( i in 230...234 ) 
		{
			shc.addFrame( Assets.getBitmapData( "image/sprites/Zombies.SHP." + i + ".png" ), i+"_frame" );
		} 
		super( shc.exportBitmapData(), viewPort, TYPE );
		shc.destroy();
		directionFromLeft = fromLeft;
		this.x = 50;// ( directionFromLeft ) ? -45 + 1 : viewPort.width - 1;
		this.y = viewPort.height - 100;
	}
	
	override public function setUpFrames():Void 
	{
		//var frames:SpriteSequence = getSequence();
		var oblong:Rectangle = new Rectangle( 0, 0, 45, 76 );
		// here we add our frames and sequences to X
		for ( row in 0...1 )
		{
			for ( column in 0...4 )
			{
				oblong.x = column * oblong.width;
				oblong.y = row * oblong.height;
				addFrame( oblong, "facing_"+row+":"+column );
			}
		}
	}
	
	override public function damage(power:Float = 0.2):Int 
	{
		sounds.play();
		super.damage(power);
		return 4;
	}
	
	//
	override public function update( timeCode:Int ):Bool 
	{
		if (directionFromLeft) this.x += ((Math.random() * 3) - 1);
		else this.x += ((Math.random() * 3) - 1);
		
		
		// lurch left or right!
		if ( frameCheck( timeCode ) ) 
		{
			getSequence().next();
			return true;
		}
		
		return false;
	}
}