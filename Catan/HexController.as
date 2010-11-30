package {

import flash.geom.Point;
import com.cshmt.coffeetable.Die;

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
			retArr.push(new Point(p.x - Math.round(BoardPiece.SIZE/2), p.y - Math.round(BoardPiece.SIDE/2)));
			retArr.push(new Point(p.x, p.y - BoardPiece.SIDE));
			retArr.push(new Point(p.x + Math.round(BoardPiece.SIZE/2), p.y - Math.round(BoardPiece.SIDE/2)));
			retArr.push(new Point(p.x + Math.round(BoardPiece.SIZE/2), p.y + Math.round(BoardPiece.SIDE/2)));
			retArr.push(new Point(p.x, p.y + BoardPiece.SIDE));
			retArr.push(new Point(p.x - Math.round(BoardPiece.SIZE/2), p.y + Math.round(BoardPiece.SIDE/2)));
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
			retArr.push(new Point(p.x - Math.round(BoardPiece.SIZE/4), p.y - Math.round(BoardPiece.SIDE/4)));
			retArr.push(new Point(p.x, p.y - Math.round(BoardPiece.SIDE/2)));
			retArr.push(new Point(p.x + Math.round(BoardPiece.SIZE/4), p.y - Math.round(BoardPiece.SIDE/4)));
			retArr.push(new Point(p.x + Math.round(BoardPiece.SIZE/4), p.y + Math.round(BoardPiece.SIDE/4)));
			retArr.push(new Point(p.x, p.y + Math.round(BoardPiece.SIDE/2)));
			retArr.push(new Point(p.x - Math.round(BoardPiece.SIZE/4), p.y + Math.round(BoardPiece.SIDE/4)));
			return retArr;
		}
		
		//given a settlement, determines if the road spread is straight up or straight down, then left and right
		//returns true if there is a valid road location straight up (or would be if the board did not end)
		public function isRoadAbove(p:Point) {
			
			var radiusPoints:Array = this.hexRadius(p);
			var currPoint:Point;
			var count:Number = 0;
			while (currPoint = radiusPoints.pop()) {
				if (getHexByPoint(currPoint)) {
					if ((count % 2) == 1) {
						return true;
					} else {
						return false;
					}
				}
				count++;
			}
			trace("HexController.isRoadAbove Error: No Hexes Found.");
		}
		
		public function generateHexes() {
			var numP:Object = BoardPiece.numPieces;
			var oceanhexes:Array = new Array();
			var desertnum:Number;
			var die1:Die = new Die(6);
			var die2:Die = new Die(6);
			for (var i:Number=0; i<19; i++) {
				var rand:Number = Math.floor(Math.random()*6);
				var piece:BoardPiece;
				var resource:String;
				switch (rand) {
					case 0:
						resource = "wheat";
						break;
					case 1:
						resource = "sheep";
						break;
					case 2:
						resource = "wood";
						break;
					case 3:
						resource = "brick";
						break;
					case 4:
						resource = "ore";
						break;
					case 5:
						resource = "desert";
						break;
				}		
				//trace (resource + ": " + numP[resource] + "left. ");
				if (numP[resource] > 0) {
					piece = new BoardPiece(i, resource);
					numP[resource]--;
					this.push(piece);
					if (resource == "desert") {
						desertnum = i;
					}
				} else {
					i--;
				}
			}
			//generate the list of ocean hexes
			for (i=0; i<18; i++) {
				rand = Math.floor(Math.random()*2);
			}
			
			
			//calculate the piece to start numbertoken A
			var startpiece:Number;
			if (desertnum < 10) {
				//on the outside, but not the last one
				startpiece = desertnum + 1;
			} else if (desertnum == 11) {
				//last outside piece, we wrap to 0
				startpiece = 0;
			} else if (desertnum > 11 && desertnum != 18) {
				//inside but not the middle
				startpiece = (desertnum - 12)*2;
			} else {
				//center
				startpiece = die1.roll() + die2.roll() - 1;
			}
			trace ("startpiece: " + startpiece);
			startpiece += die1.roll() + die2.roll();
			if (startpiece > 11) {
				//wrap around instead of going into the center
				startpiece = startpiece - 12;
			}
			
			for each ( var hex:BoardPiece in this) {
					trace (hex.num + ": " + hex.resource);
			}
			trace ("startpiece: " + startpiece);
			
			//assign number tokens
			var currentPiece:Number = startpiece;
			for (var j:Number = 0; j<18; j++){
				if (this[currentPiece].resource != "desert") {
					//assign token
					trace(currentPiece);
					this[currentPiece].addToken(new NumberToken(String.fromCharCode(j+65)));
					trace(String.fromCharCode(j+65) + NumberToken.mappings[String.fromCharCode(j+65)]);
				} else {
					j--;
				}
				if (currentPiece == 11 && startpiece != 0) {
					//circle around, continue on outside
					currentPiece = 0;
				}
				else if (currentPiece == (startpiece - 1)) {
					//we've finished the outside, drop inside
					currentPiece = Math.floor(startpiece/2)+12;
				} 
				else if (currentPiece == 17 && (Math.floor(startpiece/2) != 0)) {
					//circle around the inside
					currentPiece = 12;
				}
				else if (currentPiece == Math.floor(startpiece/2)+11 && startpiece != 0) {
					//we've reached the end of the inside, drop to the center
					currentPiece = 18;
				} else {
					currentPiece++;
				}
			}
			
			//now we've generated all the hexes, give 'em places on the board.
			placeHexes();
		}
		public function placeHexes() {
			for each ( var hex:BoardPiece in this) {
				if (hex.resource != "desert") {
					trace (hex.num + ": " + hex.resource + " at " + hex.numtoken.letter + " for " + hex.numtoken.myNumber);
				} else {
					trace (hex.num + ": desert");
				}
				var basex:Number = 512;
				var basey:int = 364;
				switch(hex.num) {
					case 0:
					case 8:
					case 17:
						hex.x = basex - BoardPiece.SIZE;
						break;
					case 1:
					case 7:
					case 18:
						hex.x = basex;
						break;
					case 2:
					case 6:
					case 14:
						hex.x = basex + BoardPiece.SIZE;
						break;
					case 3:
					case 5:
						hex.x = basex + Math.round((BoardPiece.SIZE*1.5));
						break;
					case 9:
					case 11:
						hex.x = basex - Math.round((BoardPiece.SIZE*1.5));
						break;
					case 12:
					case 16:
						hex.x = basex - Math.round((BoardPiece.SIZE*.5));
						break;
					case 13:
					case 15:
						hex.x = basex + Math.round((BoardPiece.SIZE*.5));
						break;
					case 4:
						hex.x = basex + (BoardPiece.SIZE*2);
						break;
					case 10:
						hex.x = basex - (BoardPiece.SIZE*2);
						break;
				}
				switch(hex.num) {
					case 0:
					case 1:
					case 2:
						hex.y = basey - Math.round((BoardPiece.LONGSIZE*.75*2));
						break;
					case 11:
					case 12:
					case 13:
					case 3:
						hex.y = basey - Math.round((BoardPiece.LONGSIZE*.75));
						break;
					case 10:
					case 17:
					case 18:
					case 14:
					case 4:
						hex.y = basey;
						break;
					case 9:
					case 16:
					case 15:
					case 5:
						hex.y = basey + Math.round((BoardPiece.LONGSIZE*.75));
						break;
					case 8:
					case 7:
					case 6:
						hex.y = basey + Math.round((BoardPiece.LONGSIZE*.75*2));
						break;
				}
			}
		}
	}
}