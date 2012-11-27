package utils;

class StringPlus 
{

	// http://haxe.org/doc/snip/hiscore
	public static inline function comma(num:Float)
	{
		var arr = Std.string(num).split(".");
		var str = "";
		while(arr[0].length > 3) 
		{
			str = "," + arr[0].substr(-3) + str;
			arr[0] = arr[0].substr(0, arr[0].length - 3);
		}
		return arr[0] + str + if(arr.length > 1) "." + arr[1];
	}
	
}