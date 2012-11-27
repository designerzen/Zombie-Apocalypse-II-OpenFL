package views.components.widgets;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.geom.Rectangle;
import views.components.characters.FontLetter;

/*

A simple score setter and view

 */

class Score extends Sentence
{
	public var score ( getScore, setScore ):Int;
	
	private var value:Int = 0;
	
	public function setScore( points:Int ):Int
	{
		value = points;
		setText( points + "" );
		return value;
	}
	
	public function getScore():Int
	{
		return value;
	}
	
	public function new( startingScore:Int=0 ) 
	{
		super();
		setScore( startingScore );
	}
}