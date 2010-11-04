package {

import flash.geom.Point;
import fl.motion.Color;
import com.cshmt.coffeetable.*;

	public dynamic class SettlementController {
		var hc:HexController;
		public var settlements:Array;
		
		public function SettlementController(hc:HexController) {
			this.hc = hc;
			this.settlements = new Array();
		}
		
		public function addSettlement(p:Point, myname:String, player:CatanPlayer) {
			trace(isValidLocation(p, myname)); 
			if (isValidLocation(p, myname)) {
				settlements.push(new Settlement(p, myname, player));
			}
		}
		
		//look at point and in neighboring locations and see if there's already any settlements there
		//(enforce settlement spacing rule)
		public function isValidLocation(p:Point, n:String) {
			//check if there's already a settlement at the point you're trying to add
			if (getSettlementByPoint(p) != null){
				return false;
			}
			//okay your place is clear, now is there any neighboring areas with settlements
			var arr:Array = hc.hexRadius(p);
			for each (var p2:Point in arr) {
				if (getSettlementByPoint(p2) != null) {
					trace("Settlement " + n + " at (" + p.x + ", " + p.y + ") conflicts with settlement " + getSettlementByPoint(p2).myname + "at point " + getSettlementByPoint(p2).x + ", " + getSettlementByPoint(p2).y);
					return false;
				}
			}
			return true;
		}
		
		
		//find the settlement within 5 pixels of point p, else return null
		public function getSettlementByPoint(p:Point) {
			for each ( var s:Settlement in settlements) {
				if ((s.x-p.x<5 && s.x-p.x>-5) && (s.y-p.y<5 && s.y-p.y>-5)) {
					return s;
				}
			}
			return null;
		}
		
		public function getSettlementsByHex(h:BoardPiece) {
			var retArr:Array = new Array();
			//for every valid settlement point around the hex, see if there's a settlement there
			for each(var p:Point in hc.hexRadius(new Point(h.x, h.y))) {
				var s:Settlement = getSettlementByPoint(p);
				if (s != null) {
					retArr.push(s);
				}
			}
			return retArr;
		}
		
	}
}