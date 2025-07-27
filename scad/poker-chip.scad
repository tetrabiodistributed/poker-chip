// Standard poker chips are 39, 43, 47, or 49mm.
size = 39; // [30:60]

// Standard poker chips are 3.5mm thick.
thickness = 3.5;  // [2:.5:6]
t_emboss = 0.6;

// Width of the outer rim, used to imprint text
rim = 3; // [4:10]

quality = 100; // [20:Draft, 40:Standard, 100:High]

bevel_style = "n"; // [a:Angled, r:Rounded, n:None]
bevel = bevel_style == "n" ? 0 : .25;
bevel_facets = bevel_style == "a" ? 4 : 16;

rim_symbol = "\u2588"; // [\u25CF:Circle, \u25A0:Square, \u25B2:Triangle, \u2660:Spade, \u2663:Club, \u2665:Heart, \u2666:Diamond, \u2588:Cut Edge, none:None]

makeToken();

module makeToken() {
  rotate([180])makeTop();
  makeBottom();
}

module circle() {
    //stick a circle on it 
    rotate_extrude($fn = quality) translate([size/2 - rim -.5,0]) square(t_emboss); 
    //make pattern around the circle
        for (i = [0:20:360]) {
      rotate([0,0,i]) translate([0,size/2 - rim/2]) linear_extrude(height=t_emboss) {
        text(rim_symbol, $fn = quality, size=rim/1.7, valign="center", halign="center");
      }
    }
}

module makeTop() {
  union() {
    color("Blue",0.5)cylinder(h=thickness/2 - t_emboss, d=size, $fn=quality);
    translate([0,0,thickness/2 - t_emboss]) {
      circle();

      // Add a symbol in the center
      scale([1,1]) tetraqr(1);
    }
  }
}

module makeBottom() {
  union() {
    color("Blue",0.5)cylinder(h=thickness/2 - t_emboss, d=size, $fn=quality);
    
    translate([0,0,thickness/2 - t_emboss]) {
      circle();
    
      // Add a symbol in the center
      scale([.9,.9]) tetralogo();
    }
  }
}

/* Standard tetraqr logo stamp */
module tetraqr() {
  translate([-20,-18.5,0])linear_extrude(t_emboss) import("../image/qr.svg");
}

module tetralogo() {
   translate([-18,-20,0])linear_extrude(t_emboss) import("../image/tetra_logo2.svg",convexity=30);
}