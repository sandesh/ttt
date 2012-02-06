var ttt;

ttt = function() {
  var currentMark,
      setCurrentMark,
      mouseOverTile,
      mouseOutTile;

  currentMark = "";

  return {
    setCurrentMark : function(player) {
      currentMark = player;
    },
    mouseOverTile : function(element) {
      if (element.src.match(/empty_tile/) && currentMark) {
        element.src = "/assets/" + currentMark + "_dim.png";
      }
    },
    mouseOutTile : function(element) {
      if (element.src.match(/_dim/)) {
        element.src = "/assets/empty_tile.png";
      }
    }
  };
}();
