package {
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class NumberToken extends MovieClip {
		
		public static var mappings:Object = {
			A:5,
			B:2,
			C:6,
			D:3,
			E:8,
			F:10,
			G:9,
			H:12,
			I:11,
			J:4,
			K:8,
			L:10,
			M:9,
			N:4,
			O:5,
			P:6,
			Q:3,
			R:11
		};
		
		public var letter:String;
		public var myNumber:Number;
		
		public function NumberToken(letter:String) {
			this.letter = letter;
			this.myNumber = NumberToken.mappings[letter];
			numvalue.text = this.myNumber.toString();
			lettertext.text = this.letter;
			if (this.myNumber == 6 || this.myNumber == 8) {
				var redtext:TextFormat = new TextFormat();
				redtext.color = 0xFF0000;
				numvalue.setTextFormat(redtext);
				lettertext.setTextFormat(redtext);
			}
		}
		
		public function numDots() {
			if (myNumber < 7) {
				return myNumber - 1;
			} else {
				return 13 - myNumber;
			}
		}
		
	}
}