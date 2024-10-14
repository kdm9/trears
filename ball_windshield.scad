include <BOSL2/std.scad>
include <BOSL2/polyhedra.scad>

$fn=96;
eps=0.001;

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
module toroid_slot(id=20, od=25, recess=0, ) {
    d=(od-id)/2;

    rotate_extrude()
    translate([(od-d)/2, 0,0]) 
    rotate([0, 0, 90])
    union() {
        translate([-d/2, 0, 0]) square([d, recess+d/2]);
        circle(d=d);
    };
}


//hexsphere(r=45, wall=4.5, shape="truncated icosahedron");

module support1() {
    translate([0, -16, 27])
        rotate([139, 0, 0])  
        cylinder(h=40.5, d=5);
}
rotate([0, 0, 20]) support1();
rotate([0, 0, 140]) support1();
rotate([0, 0, 260]) support1();

module support2() {
    translate([0, -16, 27])
        rotate([131, 0, 0])  
        cylinder(h=35, d=5);
}
rotate([0, 0, 80]) support2();
rotate([0, 0, 200]) support2();
rotate([0, 0, 320]) support2();

// Mic holder
translate([0, 0, 20])
    difference() {
        union() {
            translate([0, 0, -20]) 
                hexsphere(r=45, wall=4.5, shape="truncated icosahedron");
            cylinder(h=22, d=35);
        }
        translate([0, 0, -0.5])  cylinder(h=23, d=23.5);
        translate([0, 0, 5])  toroid_slot(od=28.1, id=22, recess=-0.5);
        translate([0, 0, 17]) toroid_slot(od=28.1, id=22, recess=-0.5);
    }

//color("#666666")  cylinder(h=125, d=23.1);


    