include <BOSL2/std.scad>
include <BOSL2/polyhedra.scad>

$fn=96;

             
module clip(diam=13, length=20, wall=2, open=0.95, offset=0) {
    openm = open*diam;
    dwall=diam+wall;
    translate([0, offset, ]) minkowski() {
        difference() {
            cylinder(h=length-2, d=diam+wall/2+0.01);
            translate([0, 0, -1]) cylinder(h=length, d=diam+wall/2);
            translate([-openm/2, 0, -1]) cube([openm, openm, length]);
        }
        cylinder(h=2, d=wall/2);
    }
    difference() {
        translate([-diam/2, -(dwall/2), 0]) cube([diam, offset+(dwall/2), length]);
        translate([0, offset, -1])  cylinder(h=length+2, d=diam);
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
    hexsphere(r=48, wall=4, shape="icosidodecahedron");
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
    translate([-15, -11, -6])
    union() {
        translate([0, 0, 0])
        cube([30, 11,3]);
         translate([15, 11, 0])
        cylinder(3, 15, 15, $fn=10);
    }
    translate([-1.5, 11, -6])
    cube([3, 3,4.5]);
    translate([-15, -16, -6])
    cube([30, 5,6]);
}
translate([0, 20, 9]) rotate([90, 0, 0]) clip(diam=15, length=20, offset=5);
