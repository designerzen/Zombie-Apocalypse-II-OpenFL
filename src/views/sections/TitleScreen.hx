package views.sections;

import flash.events.Event;
import models.events.SectionEvent;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.media.Sound;
import openfl.media.SoundChannel;
import views.components.animations.BloodDripping;
import views.components.characters.PriestZombie;
import views.components.characters.Torso;
import views.sprites.tools.SpriteSheetCreator;


class TitleScreen extends Section
{
	
	private var blood:BloodDripping;
	
	private var fadingOut:Bool = false;
	
	private var soundTrack:Sound;
	private var soundChannel:SoundChannel;
	
	static public inline var TYPE:String = "TitleScreen";
	
	public function new() 
	{
		// we need a transparent bitmap for the blood effect to be translucent
		var image:BitmapData = Assets.getBitmapData( "image/TITLESCREEN.png", false );
		super( image, TYPE );
		blood = new BloodDripping( );
		blood.addEventListener( BloodDripping.COMPLETE, onBloodDrippingCompleted );
		#if flash
		soundTrack = Assets.getSound( "music/zombie2.mp3" );
		#else
		soundTrack = Assets.getSound( "music/zombie2.ogg" );
		#end
	}
	
	override private function added():Void 
	{
		blood.registerBitmap( background );
		// start music
		soundChannel = soundTrack.play( 0, 0 );
		
		// test
		addChild( new PriestZombie( new Rectangle() ) );
	}
	
	override private function removed():Void 
	{
		soundChannel.stop();
		soundTrack = null;
		super.removed();
	}
	
	private function onBloodDrippingCompleted(e:Event):Void 
	{
		fadingOut = true;
	}
	
	private function onFadeComplete() 
	{
		
	}
	
	override private function update(elapsed:Int):Void 
	{
		//trace( elapsed );
		if ( elapsed > 13000 )
		{
			dispatchEvent( new SectionEvent( SectionEvent.REQUEST_REMOVAL ) );
			return ;
		}
		
		if ( fadingOut )
		{
			// fade out
			this.alpha -= 0.01;
			if ( this.alpha <= 0 ) onFadeComplete();
		}else {
			background.lock();
			
			// unrolled for speed
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
					
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			
			
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			
			
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			
			
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			
			
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			blood.update();
			
			background.unlock();
		}
		
	}
}