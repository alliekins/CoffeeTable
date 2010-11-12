package {

import flash.geom.Point;
import fl.motion.Color;
import com.cshmt.coffeetable.*;

	public dynamic class PieceController {
		var hc:HexController;
		public var settlements:Array;
		public var roads:Array;
		
		public function PieceController(hc:HexController) {
			this.hc = hc;
			this.settlements = new Array();
			this.roads = new Array();
		}
		
		public function addSettlement(p:Point, myname:String, player:CatanPlayer) {
			//trace(isValidSettlementLocation(p, myname, true)); 
			if (isValidSettlementLocation(p, player, myname, true)) {
				settlements.push(new Settlement(p, myname, player));
			} else {
				trace("Can't place settlement " + myname + " for " + player.playerName + " but I don't know why, write better error handling geez");
			}
		}
		
		public function addRoad(p:Point, r:Number, myname:String, player:CatanPlayer) {
			roads.push(new Road(p, r, myname, player));
		}
		
		//look at point and in neighboring locations and see if there's already any settlements there
		//(enforce settlement spacing rule)
		//p = placement point; n = settlement identifier name
		public function isValidSettlementLocation(p:Point, player:CatanPlayer, n:String, isSetup:Boolean) {
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
			//if this is setup we don't care about roads, so we're okay now
			if (isSetup) {
				return true;
			}
			//if this isn't setup, we need to make sure roads are in order
			arr = hc.hexRoads(p);
			var r:Road;
			for each (p2 in arr) {
				//is there a road that's ours here?
				if ((r = getRoadByPoint(p2)) != null && r.player == this.player) {
					//yeahhhhh muffins
					return true;
				}
			}
			//get the fuck outta here, don't you make fun of him!
			return false;
		}
		
		public function isValidRoadLocation(p:Point, player:CatanPlayer, isSetup:Boolean) {
			//check if there's a road there already
			if (getRoadByPoint(p) != null) {
				return false;
			}
			//is there a settlement ajacent?
			var arr:Array = hc.hexHalfRadius(p);
			var s:Settlement;
			for each (var p2:Point in arr) {
				if (((s = getSettlementByPoint(p2)) != null) && (s.player == this.player)) {
					//there is a settlement nearby and it's ours!
					return true;
				}
			}
			//okay so there's no nearby settlements. If this is setup, that's no good
			if (isSetup) {
				return false;
			}
			//if we're big boys playing a big boy real game, we can connect to roads too
			arr = hc.hexRoads(p);
			var r:Road;
			for each (p2 in arr) {
				if (((r = getRoadByPoint(p2)) != null) && (r.player == this.player)) {
					//there's a road ajacent and it's ours!
					return true;
				}
			}
			//so there's no roads or settlements nearby... what are you doing, dude?
			return false;
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
		//find the road within 5 pixels of point p, else return null
		public function getRoadByPoint(p:Point) {
			for each ( var r:Road in roads) {
				if ((r.x-p.x<5 && r.x-p.x>-5) && (r.y-p.y<5 && r.y-p.y>-5)) {
					return r;
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