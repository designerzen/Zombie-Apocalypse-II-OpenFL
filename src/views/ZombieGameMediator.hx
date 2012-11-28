package views;

import controllers.input.GlobalInput;
import models.events.PlayerEvent;
import nme.events.KeyboardEvent;
import nme.events.MouseEvent;

import models.Player;

import views.components.widgets.HealthMeter;
import views.components.widgets.Cursor;
import views.sections.TitleScreen;
import views.sections.Credits;

import views.sections.Section;
import views.sections.levels.Street;
import views.sections.levels.Reactor;
import views.sections.levels.JunkYard;

class ZombieGameMediator extends GameMediator
{
	private var sections:Array<String>;
	private var screen:Int = -1;
	
	private var healthBar:HealthMeter;
	
	// private var health:HealthIndicator
	
	public function new() 
	{
		healthBar = new HealthMeter( 10, 40 );
		player = new Player();
		sections = [ TitleScreen.TYPE, Credits.TYPE, JunkYard.TYPE, Street.TYPE, Reactor.TYPE ];
		super();
	}
	
	override private function added():Dynamic 
	{
		//stage.frameRate = 24;
		
		// listen for user events
		GlobalInput.start( true, true );
		//stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		
		GlobalInput.keyboard.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		//GlobalInput.mouse.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		
		// 
		player.addEventListener( PlayerEvent.DEAD, onPlayerDead );
		player.addEventListener( PlayerEvent.GAME_OVER, onGameOver );
		
		layout();
		
		gotoNextScreen(); 
		
		addChild( healthBar );
	}
	
	private function layout():Void
	{
		healthBar.x = stage.stageWidth - healthBar.width - 10;
		healthBar.y = 5;
	}
	
	// Game Over Man!
	private function onGameOver(e:PlayerEvent):Void 
	{
		//changeSection( new GameOver() );
	}
	
	private function onPlayerDead(e:PlayerEvent):Void 
	{
		
	}
	
	private function gotoNextScreen():Void
	{
		screen = ( screen + 1 >= sections.length ) ? 0 : screen + 1; 
		var next:Section;
		switch ( sections[ screen ] )
		{
			case TitleScreen.TYPE:
				return changeSection( new TitleScreen() );
			case Credits.TYPE:
				return changeSection( new Credits() );
			case JunkYard.TYPE:
				return changeSection( new JunkYard() );
			case Street.TYPE:
				return changeSection( new Street() );
			case Reactor.TYPE:
				return changeSection( new Reactor() );		
		}
		return;
	}
	
	override private function changeState( fromSection:Section ):Void 
	{
		// first discover the position in our list
		for ( i in 0...sections.length )
		{
			var type:String = sections[ i ];
			if ( type == fromSection.type ) 
			{
				screen = i; 
				gotoNextScreen();
				return;
			}
		}
	}
	
	private function onMouseDown( event:MouseEvent ):Void 
	{
		
	}
	
	
	private function onKeyDown(e:KeyboardEvent):Void 
	{
		switch( GlobalInput.keyboard.held )
		{
			case 32:
				gotoNextScreen();
			default: trace( GlobalInput.keyboard.held );
		}
	}
}