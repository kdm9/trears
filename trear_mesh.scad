include <BOSL2/std.scad>
include <BOSL2/polyhedra.scad>



module clip(diam=13, length=20, wall=2, open=0.95, offset=0) {
    openm = open*diam;
    dwall=diam+wall;
    $fn=72;
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

translate([40,50, 0])
scale([0.8, 1, 1.2])
rotate([0, 0, 198.5])
minkowski() {
    intersection() {
        hexsphere(r=50, wall=2, shape="dodecahedron");
        translate([0, 0, 50]) cube(100, center=true);
    }
    sphere(r=2);
};


linear_extrude(2)
difference() {
    $fn=72;
    minkowski() {
        union() {
            translate([40,50, 0])
                scale([0.8, 1, 1]) 
                circle(r=48);
            translate([20,50, 0])
                square([40, 90]);
        };
        circle(r=1);
    };
    translate([25,105, 0]) square([3, 28]);
    translate([52,105, 0]) square([3, 28]);

};
translate([40, 65, 9]) rotate([90, 0, 0]) clip(diam=12, length=8, offset=5);