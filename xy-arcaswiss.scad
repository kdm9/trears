include <BOSL2/std.scad>
use <threadlib/threadlib.scad>
eps=0.01;
$fn=128;

module clip(din = 23, wall=4, open=18, h=30) {
    _off = sqrt((din/2)^2 - (open/2) ^2 );
    _dout = din + 2*wall;
    translate([0, 0,-h/2]) 
        difference() {
            cylinder(h=h, d=_dout);
            translate([0, 0, -eps]) cylinder(h=h+2*eps, d=din);
            translate([-_dout/2, _off, -eps]) cube([_dout, _dout, h+2*eps]);
        }
}

    
module arcaswiss(l=100, w=38, h=12, recess=4) {
    difference() {
        cube([l, w, h]);
        translate([l/2-eps, -eps, 2.5])
            rotate([0, 0, 90])
            prismoid([0, l+5], [recess, l+5], h=recess, shift=recess/2);
        translate([l/2-eps, eps+w, 2.5])
            rotate([0, 0, -90])
            prismoid([0, l+5], [recess, l+5], h=recess, shift=recess/2); 
    } 
}

module clipwithstem(din=23, wall=4, open=18, h=30, stemw=12, stemh=10) {
    translate([0, -din/2-(stemh+wall)/2, 0])
    cube([stemw, stemh+wall, h], center=true);
        clip(din, wall, open, h);
}


union() {
    difference() {
        arcaswiss(l=100);                
        translate([50, 19, 0])
            tap("UNC-3/8", turns=7.5);
    }
    
    // left clip
    translate([25, 38/2, 27/2+12+10])
        rotate([90, 0, 35])
        clipwithstem(stemw=17, stemh=10, h=35);
 
    //right clip
    translate([75, 38/2, 27/2+12+10+27])
        rotate([90, 0, 145])
        clipwithstem(stemw=17, stemh=10+27, h=35);
    
    translate([10, 38/2, -2])
        cylinder(h=2, d=7);
    
    translate([90, 38/2, -2])
        cylinder(h=2, d=7);
    
    translate([34, 30, 12])
        linear_extrude(0.7)
        text("ORTF", size=7);
}

