package views.components.widgets;

import openfl.display.Shape;

class HealthMeter extends Shape
{
	private var barWidth:Float;
	private var barHeight:Float;
	private var percentage:Float = 1;
	
	public function new( frameWidth:Float, frameHeight:Float ) 
	{
		super();
		barWidth = frameWidth;
		barHeight = frameHeight;
		draw();
	}
	
	private function draw() 
	{
		// clear
		graphics.clear();
		
		// frame
		graphics.lineStyle( 1, 0xffffff, 0.9 );
		graphics.drawRect( 0, 0, barWidth, barHeight);
		graphics.endFill();
		
		// bar
		graphics.lineStyle( 0, 0xff0000, 0 );
		graphics.beginFill( 0xff0000, 0.9 );
		graphics.drawRect( 2, 2, barWidth-4, (barHeight-4)*percentage );
		graphics.endFill();
	}
	
	public function setPercentage( percent:Float ):Void
	{
		percentage = percent;
		draw();
	}
	
}