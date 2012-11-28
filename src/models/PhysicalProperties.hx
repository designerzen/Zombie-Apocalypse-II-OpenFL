package models;

/*

Collect some information about the physical properties of our environment

 */

class PhysicalProperties 
{
	//
	public var accelerationX:Float  = 0;
	// gravity
	public var accelerationY:Float  = 0;	// o.8 is real world
	
	// initial speed
	public var inertiaX:Float  = 0;
	public var inertiaY:Float  = 0;	
	
	// resistance to inertia
	public var frictionX:Float  = 0.1;
	public var frictionY:Float  = 0.1;
	
	// maximum speed
	public var maximumVelocityX:Float = 8;
	public var maximumVelocityY:Float = 8;
	
	public function new( gravity:Float=0.8, wind:Float=0, velocityX:Float=0, velocityY:Float=0 ) 
	{
		accelerationX = wind;
		accelerationY = -gravity;
		
		inertiaX = velocityX;
		inertiaY = velocityY;
	}
	
	public function update( x , y ):Void
	{
		//  velocity += acceleration - friction*velocity*velocity
		if ( inertiaX < maximumVelocityX ) inertiaX += accelerationX - frictionX * inertiaX;
		if ( inertiaY < maximumVelocityY ) inertiaY += accelerationY - frictionY * inertiaX;
	}
	
	// Stokes' drag: velocity = (a/f) - (a/f)*exp(-f*t)
	public function easeX( time:Float ):Float
	{
		return (accelerationX / frictionX) - (accelerationX / frictionX) * Math.exp( -frictionX * time );
	}
	public function easeY( time:Float ):Float
	{
		return (accelerationY / frictionY ) - (accelerationY / frictionY ) * Math.exp( -frictionY * time );
	}
	
	// Quadratic Drag : 
	public function easeX( time:Float ):Float
	{
		// v = sqrt(a/f)*(exp(2*sqrt(a*f)*t) - 1)/(exp(2*sqrt(a*f)*t) + 1)
		return (accelerationX / frictionX) - (accelerationX / frictionX) * Math.exp( -frictionX * time );
	}
	public function easeY( time:Float ):Float
	{
		return (accelerationY / frictionY ) - (accelerationY / frictionY ) * Math.exp( -frictionY * time );
	}
}