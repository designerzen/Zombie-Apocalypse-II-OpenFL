package views.components.widgets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import views.components.characters.FontLetter;

/*

A simple score setter and view

 */

class Score extends Sentence
{
	public var score ( get_score, set_score ):Int;
	
	private var value:Int = 0;
	
	public function set_score( points:Int ):Int
	{
		value = points;
		set_text( points + "" );
		return value;
	}
	
	public function get_score():Int
	{
		return value;
	}
	
	public function new( startingScore:Int=0 ) 
	{
		super();
		set_score( startingScore );
	}
}