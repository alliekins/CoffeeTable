package {

import com.cshmt.coffeetable.Player;

	public class CatanPlayer extends Player {
		public var hand:Array;
		
		public function CatanPlayer(pn:String, color:String) {
			super(pn, color);
			hand = new Array();
		}
	}
}