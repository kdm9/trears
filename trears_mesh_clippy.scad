include <BOSL2/std.scad>
include <BOSL2/polyhedra.scad>

$fn=96;
eps=0.001;


module clip(din=23, wall=4, open=18, h=30, stemw=12, stemh=10) {

    _off = sqrt((din/2)^2 - (open/2) ^2 );
    _dout = din + 2*wall;
    rotate([90, 0, 0])
    translate([0, 0, -h/2]) 
        difference() {
            union() {
                cylinder(h=h, d=_dout);
                translate([0, -(stemh+wall+din/2)/2, h/2])
                    cube([stemw, stemh+wall+din/2,  h], center=true);
            }
            translate([0, 0, -eps]) 
                cylinder(h=h+2*eps, d=din);
            translate([-_dout/2, _off, -eps]) 
                cube([_dout, _dout, h+2*eps]);
        }
}


module hexsphere(r=100, wall=2, shape=undef, faces=undef, hole_ratio=0.9) {
    difference() {
        regular_polyhedron(name=shape,faces=faces, r=r);
        regular_polyhedron(name=shape,faces=faces,  r=r-wall, draw=false, rotate_children=true)
            linear_extrude(height=wall)
              polygon(
              [
                for(i=[0:len($face)-1]) let(
                  p0=select($face,i)*(r-wall)/r,
                  p1=select($face,i+1)*(r-wall)/r
                ) each [p0, p1]
              ]
            );
        regular_polyhedron(name=shape,faces=faces, r=r-wall+0.01);
    }
}

//translate([60,80, 0])
scale([0.7, 1, .9])
rotate([0, 0, 198.5])
intersection() {
    //hexsphere(r=55, wall=3, shape="icosidodecahedron");
    hexsphere(r=48, wall=5.5, shape="icosidodecahedron");
    /*minkowski() {
        hexsphere(r=80, wall=0.1, shape="dodecahedron");
        sphere(r=2);
    }*/
    translate([0, 0, 100]) cube(200, center=true);
};
//translate([60,80, 0])
scale([0.7, 1, 1]) 
linear_extrude(4)
circle(r=48);

//belt strap
rotate([0, 0, 90])
union() {
    translate([-15, -15, -6])
    union() {
        translate([0, 0, 0])
            cube([30, 25,3]);
        translate([15, 25, 0])
            cylinder(3, 15, 15, $fn=35);
        translate([13.5, 36, 0])
            cube([3, 3,4.5]); // knob"
        translate([0, -5, 0])
            cube([30, 5,6]); // "stem"
    }

}
translate([0, 0, 11.9/2+2+0.5+4-eps])
    clip(din=11.9, h=10, wall=2, open=10, stemw=14, stemh=0.5);