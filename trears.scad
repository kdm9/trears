RAINCOV_W=32;
RAINCOV_D=30;
RAINCOV_H=10;
INCLUDE_RAINCOV=true;
MICSECTION_H=35;
STRAPSECTION_H=30;
STRAPSECTION_W=25;
CLIP_DIAM=12;


/////
X=RAINCOV_W/2;
Y=RAINCOV_D;
Z=RAINCOV_H;


if (INCLUDE_RAINCOV) {
    // Back plate
    rotate([90, 0, 0]) {
        linear_extrude(2){
            polygon(points=[
                [0, 0],
                [STRAPSECTION_W/2, 0] ,
                [STRAPSECTION_W/2, STRAPSECTION_H],
                [RAINCOV_W/2, STRAPSECTION_H+MICSECTION_H],
                [0, STRAPSECTION_H+MICSECTION_H+RAINCOV_H],
                [-RAINCOV_W/2, STRAPSECTION_H+MICSECTION_H],
                [-STRAPSECTION_W/2, STRAPSECTION_H],
                [-STRAPSECTION_W/2, 0],
            ]);
            translate([0, STRAPSECTION_H+MICSECTION_H, 0]) {
                intersection() {
                     scale([RAINCOV_W/200, RAINCOV_H/100, RAINCOV_H/100]) circle(100);
                     translate([-50, 0, 0]) square(100);
                }
            }
        }
    };



    // Cone section
    difference() {
        translate([0, 0, STRAPSECTION_H+MICSECTION_H]) difference() {
            inner();
            translate([0, -0.01, -0.01]) scale([.96, .96, .96]) inner();
        }
        translate([-1.5, 1, STRAPSECTION_H+MICSECTION_H]) baffle(3);
    }

    // Braces for the cone
    intersection() {
        translate([0, 0, STRAPSECTION_H+MICSECTION_H]) inner();
        translate([5, 0, STRAPSECTION_H+MICSECTION_H]) color("green") baffle(angle=90, width=1.5);
    }
    intersection() {
        translate([0, 0, STRAPSECTION_H+MICSECTION_H]) inner();
        translate([-5, 0, STRAPSECTION_H+MICSECTION_H]) color("green")  baffle(angle=90, width=1.5);
    }

    // Belt loop
    translate([-10, 0, 0]) linear_extrude(2) square([20, 4]);
    translate([-10, 2, 2]) linear_extrude(25) square([20, 2]);
    translate([-10, 0, 27]) linear_extrude(2) square([20, 4]);

    // Mic clip
    translate([0, 5, STRAPSECTION_H+MICSECTION_H/2-4])  clip(length=8, offset=5);
} else {
    // Back plate
    clipw = CLIP_DIAM+4;
    rotate([90, 0, 0]) {
        linear_extrude(2){
            polygon(points=[
                [0, 0],
                [STRAPSECTION_W/2, 0] ,
                [STRAPSECTION_W/2, STRAPSECTION_H],
                [clipw/2, STRAPSECTION_H+MICSECTION_H],
                [-clipw/2, STRAPSECTION_H+MICSECTION_H],
                [-STRAPSECTION_W/2, STRAPSECTION_H],
                [-STRAPSECTION_W/2, 0],
            ]);
        }
    };
    
    // Belt loop
    translate([-10, 0, 0]) linear_extrude(2) square([20, 4]);
    translate([-10, 2, 2]) linear_extrude(25) square([20, 2]);
    translate([-10, 0, 27]) linear_extrude(2) square([20, 4]);

    // Mic clip
    translate([0, 5, STRAPSECTION_H+MICSECTION_H/2-4])  clip(length=8, offset=5);
}

module clip(diam=CLIP_DIAM, length=20, wall=2, open=0.95, offset=0) {
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

module inner() {
    scale([X/100, Y/100, Z/100]) {
        rotate_extrude(angle=180, convexity=10){
            intersection() {
                square([100,100]);
                circle(100);
            }
        }
    }
}


module baffle(width=2, angle=90) {
    rotate([angle, 90, 90])
    linear_extrude(width)
    intersection(){
        scale([X/100, Y/100, Z/100]) circle(100);
        translate([-50, 0, 0]) square(100);
    }
}