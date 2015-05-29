package views.sections.levels;

import openfl.geom.Point;
import openfl.Assets;
import openfl.events.MouseEvent;
import views.sections.Section;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import views.sections.Section;
import views.sprites.BitmapMovieClip;
import views.sprites.SpriteSequence;
import views.sprites.SpriteSheet;

class JunkYard extends Section
{

	
	private var version:Bitmap;
	private var sprites:SpriteSheet;
	private var sequenceTitle:String;
	private var sprite:BitmapMovieClip;
	private var sequence:SpriteSequence;

	static public inline var TYPE:String = "Junkyard";
	
	public function new() 
	{
		super( Assets.getBitmapData( "image/BACKDROP2.png", false ), TYPE );
		
	}
		
	override private function added():Dynamic 
	{

		addSprites();
		addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
	}
	
	private function onMouseMove(event:MouseEvent):Void 
	{
		//sprite.x = event.localX;
		//sprite.y = event.localY;
		
		sprite.x = this.mouseX;
		sprite.y = this.mouseY;
	}
	
	private function addSprites():Void
	{
		var bitmap:BitmapData = Assets.getBitmapData( "image/sprites/ZombieBrain.png" );
		var oblong:Rectangle = new Rectangle( 0, 0, 40, 50);
		
		//Actuate
		//addChild( new Walker() );
		sprites = new SpriteSheet( bitmap );
		// create a sequence
		sequenceTitle = "titles";
		
		sequence = sprites.createSequence( sequenceTitle );
		//
		sprite = new BitmapMovieClip( bitmap, Std.int( oblong.width ), Std.int( oblong.height ) );
		/*
		sprite.addFrame( 0, 0, 'face');
		sprite.addFrame( 50, 0, 'right');
		sprite.addFrame( 150, 0, 'right2');
		sprite.addFrame( 200, 0, 'righthh');
		sprite.addFrame( 300, 0, 'bnbthh');
		*/
		
		// trace the sprites in the sheet
		var gap:Int = 0;
		var xOffset:Int = 16;
		var yOffset:Int = 50;
		for ( rows in 2...3 )
		{
			for ( columns in 0...15 )
			{
				var newX:Int = xOffset + Std.int( columns * oblong.width + gap );
				var newY:Int = yOffset + Std.int( rows * oblong.height + gap );
				var newName:String = "" + columns;
				sprite.addFrame( newX, newY, newName);
				
				oblong.x = newX;
				oblong.y = newY;
				sprites.addFrame( oblong, newName, sequenceTitle );
			}
		}
		
		
		sprite.x = stage.stageWidth * 0.5;
		sprite.y = stage.stageHeight * 0.5;
		addChild( sprite );
	}
	
	// Runs on every frame that we are on stage
	override private function update(  elapsed:Int  ):Void 
	{
		// redraw sprites : 
		//sprites.copyFramePixels( , "left", 0, 0, sequenceTitle );
		
		background.lock();
		background.copyPixels( backgroundOriginal, viewPort, origin );
		sprites.copySequencePixels( background, Std.int(sprite.x) , 0, sequenceTitle, false );
		sprites.copySequencePixels( background, Std.int(sprite.x-60) , 20, sequenceTitle, false );
		sprites.copySequencePixels( background, Std.int(sprite.x+60) , 40, sequenceTitle, false );
		
		background.unlock();
		sequence.next();
		//sprite.x += (Math.random()*2)-1;
		
		// check for hit tests
		
	}
}