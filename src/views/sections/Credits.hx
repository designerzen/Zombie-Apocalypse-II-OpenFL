package views.sections;

import models.events.SectionEvent;
import nme.Assets;
import nme.display.BitmapData;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.media.Sound;
import nme.media.SoundChannel;
import views.components.widgets.Sentence;
import views.sections.Section;

class Credits extends Section
{
	private var soundTrack:Sound;
	private var soundChannel:SoundChannel;

	static public inline var TYPE:String = "Credits";
	
	public function new() 
	{
		soundTrack = Assets.getSound( "music/zombie2.mp3" );
		super( new BitmapData( 320, 256, false, 0xff0000 ), TYPE );
	}
	
	override private function added():Void 
	{
		this.alpha = 0;
		// add our text in our reveal animation
		
		soundChannel = soundTrack.play( 13000, 0 );
		addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		drawTitles();
	}
	
	private function drawTitles():Void
	{
		var paragraph:String = Assets.getText( "xml/credits.txt" );
		// make sure  we swap out \r for \n
		
		// split into lines. stupid lookinh but with no regexp :/
		var lines:Array<String> = paragraph.split("\n").join("\r").split("\r");
		//var row:Int 
		for ( l in 0...lines.length)
		{
			var title:Sentence = new Sentence( lines[l] );
			title.y = l * title.height;
			addChild( title );
		}
	}
	
	private function onMouseDown(e:MouseEvent):Void 
	{
		removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		onDurationComplete();
	}
	
	override private function removed():Dynamic 
	{
		removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		
		soundChannel.stop();
		soundTrack = null;
		
		super.removed();
	}
	override private function update(elapsed:Int):Void 
	{
		//trace( elapsed );
		// now wait forr the time to expire
		if ( elapsed < 3000 ) 
		{
			if ( this.alpha < 1 ) this.alpha += 0.01;
		}else if ( elapsed > 15000 ){
			if ( this.alpha > 0 ) this.alpha -= 0.01;
			else onDurationComplete();
		}
	}
	
	private function onDurationComplete() 
	{
		dispatchEvent( new SectionEvent( SectionEvent.REQUEST_REMOVAL ) );
	}
}