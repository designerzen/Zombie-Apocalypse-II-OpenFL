package controllers;
import views.components.characters.Character;

/**
 * ...
 * @author zen
 */

class Factory 
{
	public var killCount:Int = 0;
	
	public var quantity:Int = 0;
	
	public var first:Character;
	public var last:Character;
	
	public var isLast ( lastCharacterTest, null ) :Bool;
	
	public function new() 
	{

	}
	
	private function lastCharacterTest( ):Bool
	{
		return ( first == last );
	}
	
	// Characters are linked lists!
	public function add( character:Character ):Void
	{
		// first baddy!
		if ( first == null )
		{
			// save head & tail
			first = character;
			last = character;
		}else {
			// current is tail, so set next
			last.nextCharacter = character;
			// save a reference to the previous
			character.previousCharacter = last;
			// then overwrite tail
			last = character;
		}
		//character.
		quantity++;
	}
	
	public function remove( character:Character, kill:Bool=false ):Void
	{
		if ( first == character )
		{
			first = character.nextCharacter;
		}
		if ( last == character )
		{
			last = character.previousCharacter;
			// make sure that we nullify the head and tail if they are the last and first
			// baddiesFirst = baddiesLast = character = null;
			//baddiesQuantity = 0;
		}
	
		if ( kill ) killCount++;
		
		character.unlink();
		character = null;
		quantity--;	
	}
	
}