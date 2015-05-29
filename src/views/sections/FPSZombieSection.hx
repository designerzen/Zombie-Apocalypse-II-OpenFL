package views.sections;
import controllers.PowerUpFactory;
import controllers.ZombieFactory;
import models.events.SectionEvent;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import views.components.characters.Character;
import views.components.characters.NudeZombie;
import views.components.characters.PriestZombie;
import views.components.characters.Torso;
import views.components.widgets.Score;

/**
 * ...
 * @author zen
 */

class FPSZombieSection extends FPSSection
{

	private var killLimit:Int;
	private var scoreBoard:Score;
	private var factory:ZombieFactory;
	private var powerUps:PowerUpFactory;
	
	public var isComplete:Bool = false;
	
	public function new( bitmapData:BitmapData, sectionID:String="FPSSection" , mask:Rectangle=null, quantityToKill:Int=10 ) 
	{
		killLimit = quantityToKill;
		super( bitmapData, sectionID, mask );
	}
	
	override private function added():Void 
	{
		// make some baddies...
		powerUps = new PowerUpFactory( viewPort );
		factory = new ZombieFactory( viewPort );
		factory.spawn( 5 );
		
		factory.add( new PriestZombie( viewPort ) );
		factory.add( new Torso( viewPort ) );
		factory.add( new NudeZombie( viewPort ) );
		//factory.add( new NudeZombie( viewPort ) );
		//factory.add( new NudeZombie( viewPort ) );
		/*addBaddy( new PriestZombie( viewPort ) );*/
		//addChild( new PriestZombie( viewPort ) );
		super.added();
		
		scoreBoard = new Score( player.score.score );
		scoreBoard.x = 10;
		scoreBoard.y = 10;
		addChild( scoreBoard );
	}
		
	override private function update(elapsed:Int):Void 
	{
		super.update( elapsed );
		
		// prevent events from firing
		background.lock();
		
		// reset
		background.copyPixels( backgroundOriginal, viewPort, origin );
		
		var baddy:Character = factory.first;
		
		// loop through baddies and update each one!
		//for ( baddy in baddies )
		while ( baddy != null )
		{
			// check to see if baddy has moved offscreen
			if (( baddy.x > background.width + 1 )||( baddy.x < - baddy.width + 1 ))
			{
				// remove baddy & skip the rest...
				factory.remove( baddy );
				trace( "removing  "+baddy );
				
				// damage player
				
			}else {
				// Draw it to the canvas
				
				// work out our co-ordinates for our local
				var newX:Int = Std.int( stage.mouseX - baddy.x ); //-Std.int(this.y) );
				var newY:Int = Std.int( stage.mouseY - baddy.y );
				
				// see if we are shooting
				var isShooting:Bool = mouse.pressed;
				
				if (isShooting )
				{
					// check to see if we are hitting the baddy...
					var isHit:Bool = baddy.collisionTest( newX, newY );
					
					// do something here with the baddy!
					if ( isHit )
					{
						// increase points
						
						// damage zombie
						var points:Int = baddy.damage();
						var cp:Int = scoreBoard.score+points;
						scoreBoard.score = cp;
						
						//trace( "damage! "+baddy.energy );
						factory.remove( baddy, true );
						
						// expend bullets
						
						// Spawn a new baddy if we haven't had enough!
						if ( factory.killCount < killLimit ) 
						{
							// update baddy
							switch ( baddy.type )
							{
								//case PriestZombie.TYPE:
									// update baddy position
									//baddy.x += ((Math.random() * 5) - 1);
								//case NudeZombie.TYPE:
									//baddy.x += 1;
								default:
							}
							factory.spawn();
						}
					}else {
						// you shot... and missed!
						// paint a bullet onto the ORIGINAL bitmap
						backgroundOriginal.setPixel( Std.int(stage.mouseX), Std.int(stage.mouseY), 0x555555 );
					}
				}
				
				// baddy.update( elapsed );
				// baddy.copySequencePixels( background, baddy.x, 256-77 );
				// or
				baddy.render( elapsed, background );
			}
			baddy = baddy.nextCharacter;
		}
		background.unlock();
		
		// check too see if level is complete
		if (( factory.killCount > killLimit ) && factory.isLast )
		{
			if (!isComplete) 
			{
				onComplete();
				return ;
			}else {
				// wait for x seconds...
			}
			
		}
	}
	
	// Yeah!!! you killed everything! 
	// Wait a short second for the body parts to finish falling, 
	// Then drop a powerup .. and briefly after request removal
	private function onLevelComplete():Void
	{
		isComplete = true;
		
		powerUps.spawn();
		
		dispatchEvent( new SectionEvent( SectionEvent.REQUEST_REMOVAL ) );
	}
}