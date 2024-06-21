$fn=200;
difference() {
    translate([30, 30, 0])
        linear_extrude(height=70)
        hull() {
            rotate([0, 0, 55]) square([33, 53], center=true);
            rotate([0, 0, 125]) square([33, 53], center=true);
        };
    translate([30, 30, 20])
        rotate([90, 0, 55])
        cylinder(h=120, d=23.5, center=true);
    translate([30, 30, 50])
        rotate([90, 0, -55])
        cylinder(h=120, d=23.5, center=true);
    translate([22, 6, -1])
        cylinder(h=80, d=3, center=false);
    translate([36, 6, -1])
        cylinder(h=80, d=3, center=false);
    translate([22, 54, -1])
        cylinder(h=80, d=3, center=false);
    translate([36, 54, -1])
        cylinder(h=80, d=3, center=false);
    translate([3, 30, -1])
        cylinder(h=80, d=3, center=false);
    translate([57, 30, -1])
        cylinder(h=80, d=3, center=false);
}

translate([100, 0, 0]) {
    difference() {
        translate([30, 30, 0])
            linear_extrude(height=5)
            hull() {
                rotate([0, 0, 55]) square([35, 60], center=true);
                rotate([0, 0, 125]) square([35, 60], center=true);
            };
        translate([22, 6, -1])
            cylinder(h=70, d=3, center=false);
        translate([36, 6, -1])
            cylinder(h=70, d=3, center=false);
        translate([22, 54, -1])
            cylinder(h=70, d=3, center=false);
        translate([36, 54, -1])
            cylinder(h=70, d=3, center=false);
        translate([3, 30, -1])
            cylinder(h=70, d=3, center=false);
        translate([57, 30, -1])
            cylinder(h=70, d=3, center=false);
        translate([30, 30, -1])
            cylinder(h=7, d=6, center=false);
    }
}

/*
translate([30, 30, 20])
    rotate([90, 0, 55])
    cylinder(h=120, d=23.5, center=true);
translate([30, 30, 42])
    rotate([90, 0, -55])
    cylinder(h=120, d=23.5, center=true);
*/
