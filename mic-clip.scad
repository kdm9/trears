eps=0.01;
$fn=128;

module clip(din = 23, wall=4, open=18, h=30) {
    _off = sqrt((din/2)^2 - (open/2) ^2 );
    _dout = din + 2*wall;
    echo(_off, _dout);
    difference() {
        cylinder(h=h, d=_dout);
        translate([0, 0, -eps]) cylinder(h=h+2*eps, d=din);
        translate([-_dout/2, _off, -eps]) cube([_dout, _dout, h+2*eps]);
        
    }
}
union() {
    clip(din=23, wall=3.5, open=18, h=40);
    translate([0, -50, 0])
        rotate([0, 0, 180])
        clip(din=23, wall=3.5, open=18, h=40);
    translate([-5, -37, 5])
        cube([10, 24, 30]);
}