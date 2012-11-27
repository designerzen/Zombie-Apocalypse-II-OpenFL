package views.components.widgets;

/**
 * ...
 * @author zen
 */
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.geom.Rectangle;
import views.components.characters.FontLetter;

class Sentence  extends Bitmap
{
	private var letter:FontLetter;

	private var sentence:String = '';
	private var kerning:Int = 1;
	private var compositeWidth:Int = 0;
	public var text ( getText, setText ):String;
	
	public function setText( string:String ):String
	{
		if ( string == "" ) return sentence = '';
		
		// clear bitmap
		//bitmapData.fillRect( 
		// split sentence into characters
		var characters:Array<String> = string.toLowerCase().split('');
		var index:Int = 0;
		sentence = string;
		compositeWidth = 0;
		for ( c in 0...characters.length )
		{
			// compensate for spaces
			var character:String = characters[c];
			if ( character == ' ' ) index += 2;
			else setCharacter( index++, character );
		}
		return sentence;
	}
	
	public function getText():String
	{
		return sentence;
	}
	
	public function new( defaultText:String='' ) 
	{
		letter = new FontLetter( );
		super( new BitmapData( Std.int(25 * letter.dimensions.width) , Std.int(letter.dimensions.height), true, 0 ) );
		setText( defaultText );
	}
	
	public function setCharacter( position:Int, character:String ):Void
	{
		// goto position * width of letter
		bitmapData.lock();
		var letter:Rectangle = letter.copyFramePixels( bitmapData, character, compositeWidth , 0 );
		compositeWidth += Std.int( letter.width + kerning );
		bitmapData.unlock();
	}
	
}