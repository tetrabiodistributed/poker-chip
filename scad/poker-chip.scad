// Standard poker chips are 39, 43, 47, or 49mm.
size = 39; // [30:60]

// Standard poker chips are 3.5mm thick.
thickness = 3.5;  // [2:.5:6]

// Width of the outer rim, used to imprint text
rim = 3; // [4:10]

quality = 40; // [20:Draft, 40:Standard, 100:High]

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
    rotate_extrude($fn = quality) translate([size/2 - rim -.5,0]) square(1); 
    //make pattern around the circle
        for (i = [0:20:360]) {
      rotate([0,0,i]) translate([0,size/2 - rim/2]) linear_extrude(height=1) {
        text(rim_symbol, $fn = quality, size=rim/1.7, valign="center", halign="center");
      }
    }
}

module makeTop() {
  difference() {
    color("Blue",0.5)cylinder(h=thickness/2, d=size, $fn=quality);
    makePattern();
  }
}

module makePattern() {
  translate([0,0,thickness/2 - .6]) {
    circle();

    // Add a symbol in the center
    scale([1,1]) tetraqr(1);
  }
}

module makeBottom() {
  difference() {
    color("Blue",0.5)cylinder(h=thickness/2, d=size, $fn=quality);
    makePattern2();
  }
}

module makePattern2() {
  translate([0,0,thickness/2 - .6]) {
    circle();
    
    // Add a symbol in the center
    scale([.9,.9]) tetralogo(1);
  }
}

/* Standard tetraqr logo stamp */
module tetraqr(h = 1) {
  translate([-20,-18.5,0])linear_extrude(h) import("../image/qr.svg");
}

module tetralogo(h = 1) {
 import("../image/tetralogo.stl");
}