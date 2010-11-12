package {

import flash.geom.Point;

	public dynamic class HexController extends Array {
		
		public function HexController() {
			
		}
		
		public function getHexByPoint(p:Point) {
			for each ( var h:BoardPiece in this) {
				if ((h.x-p.x<5 && h.x-p.x>-5) && (h.y-p.y<5 && h.y-p.y>-5)) {
					return h;
				}
			}
			return null;
		}
		
		//get the hexes with the corresponding roll number
		public function getHexesByRoll(roll:Number) {
			var retArr:Array = new Array();
			for each (var h:BoardPiece in this) {
				if (h.numtoken != null && h.numtoken.myNumber == roll) {
					retArr.push(h);
				}
			}
			return retArr;
		}
		
		//given a hex center, returns the valid settlement locations around the rim
		//given a settlement center, returns all the settlement locations one hop away
		public function hexRadius(p:Point) {
			var retArr:Array = new Array();
			retArr.push(new Point(p.x + Math.round(BoardPiece.SIZE/2), p.y + Math.round(BoardPiece.SIDE/2)));
			retArr.push(new Point(p.x + Math.round(BoardPiece.SIZE/2), p.y - Math.round(BoardPiece.SIDE/2)));
			retArr.push(new Point(p.x - Math.round(BoardPiece.SIZE/2), p.y + Math.round(BoardPiece.SIDE/2)));
			retArr.push(new Point(p.x - Math.round(BoardPiece.SIZE/2), p.y - Math.round(BoardPiece.SIDE/2)));
			retArr.push(new Point(p.x, p.y + BoardPiece.SIDE));
			retArr.push(new Point(p.x, p.y - BoardPiece.SIDE));
			return retArr;
		}
		
		//given a hex center, returns the center of each edge- the road locations
		//given a road center, returns all ajacent road centers.
		public function hexRoads(p:Point) {
			var retArr:Array = new Array();
			retArr.push(new Point(p.x - (BoardPiece.SIDE*Math.sqrt(3)/4), p.y - (BoardPiece.SIDE*3/4)));
			retArr.push(new Point(p.x + (BoardPiece.SIDE*Math.sqrt(3)/4), p.y - (BoardPiece.SIDE*3/4)));
			retArr.push(new Point(p.x + BoardPiece.SIZE/2, p.y));
			retArr.push(new Point(p.x + (BoardPiece.SIDE*Math.sqrt(3)/4), p.y + (BoardPiece.SIDE*3/4)));
			retArr.push(new Point(p.x - (BoardPiece.SIDE*Math.sqrt(3)/4), p.y + (BoardPiece.SIDE*3/4)));
			retArr.push(new Point(p.x - BoardPiece.SIZE/2, p.y));
			return retArr;
		}
		
		//given a point, returns al points a half-step away.
		//used for detecting ajacent roads and settlements.
		public function hexHalfRadius(p:Point) {
			var retArr:Array = new Array();
			retArr.push(new Point(p.x + Math.round(BoardPiece.SIZE/4), p.y + Math.round(BoardPiece.SIDE/4)));
			retArr.push(new Point(p.x + Math.round(BoardPiece.SIZE/4), p.y - Math.round(BoardPiece.SIDE/4)));
			retArr.push(new Point(p.x - Math.round(BoardPiece.SIZE/4), p.y + Math.round(BoardPiece.SIDE/4)));
			retArr.push(new Point(p.x - Math.round(BoardPiece.SIZE/4), p.y - Math.round(BoardPiece.SIDE/4)));
			retArr.push(new Point(p.x, p.y + Math.round(BoardPiece.SIDE/2)));
			retArr.push(new Point(p.x, p.y - Math.round(BoardPiece.SIDE/2)));
			return retArr;
		}
	}
}