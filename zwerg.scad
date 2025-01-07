$fn=100;

KEY_UNIT = 19.05;
KEY_HOLE = 14;
KEY_SPACING_CASE = 0.525;
SPACING_INSIDE = 9;
KEY_SPACING = (KEY_UNIT-KEY_HOLE)/2;
ANGLE = 30;
HALF_SPACING = 40;
PLATE_THICKNESS = 1.4;

// case
CASE_CHAMFER = 1;
CASE_RIM_HEIGHT = 6; // 7.8
CASE_RIM_WIDTH = 5;
CASE_BOTTOM_RIM_WIDTH = -10;
CASE_ANGLE = [-2,5,0];    // test with case_height
CASE_HEIGHT = 45;   // test with case_angle

PCB_THICKNESS = 1.6;
PCB_OFFSET = 1;
PCB_HEIGHT_OFFSET = -5;
PCB_CLEARANCE = 2.4;
PCB_PIN = 4;
PCB_PIN_3DP = 4;
PCB_SCREW = 2.2;
PCB_SCREW_3DP = 2.9;
ORING_THICKNESS = 1.9;  // 2.4


BOTTOM_OFFSET = 5;

// for pcb outline and positions
// projection() translate([0,0,-PLATE_THICKNESS]) plate();
// projection() translate([0,0,-PLATE_THICKNESS-5]) pcb();

// translate([0,0,-PLATE_THICKNESS]) plate();
// translate([0,0,-PCB_THICKNESS-5]) color("green") pcb(true);

case();

module case() {
    difference() {
        union() {
            hull() {
                translate([0,0,-SPACING_INSIDE]) linear_extrude(CASE_RIM_HEIGHT+SPACING_INSIDE) offset(CASE_RIM_WIDTH-CASE_CHAMFER) projection() plate_main(solid=true);
                translate([0,0,-SPACING_INSIDE-CASE_CHAMFER]) linear_extrude(CASE_RIM_HEIGHT+SPACING_INSIDE-CASE_CHAMFER) offset(CASE_RIM_WIDTH) projection() plate_main(solid=true);
                translate([0,0,-CASE_HEIGHT]) linear_extrude(0.2) offset(CASE_BOTTOM_RIM_WIDTH) projection() plate_main(solid=true);
            }
            hull() {
                translate([0,0,-SPACING_INSIDE]) linear_extrude(CASE_RIM_HEIGHT+SPACING_INSIDE) offset(CASE_RIM_WIDTH-CASE_CHAMFER) projection() plate_thumbs(solid=true);
                translate([0,0,-SPACING_INSIDE-CASE_CHAMFER]) linear_extrude(CASE_RIM_HEIGHT+SPACING_INSIDE-CASE_CHAMFER) offset(CASE_RIM_WIDTH) projection() plate_thumbs(solid=true);
                translate([0,0,-CASE_HEIGHT]) linear_extrude(0.2) offset(CASE_BOTTOM_RIM_WIDTH) projection() plate_thumbs(solid=true);
            }
        }
        translate([-CASE_RIM_WIDTH,0,-SPACING_INSIDE]) rotate(CASE_ANGLE) translate(v = [0,-200,-200]) cube([400,400,200]);
        translate([0,0,-SPACING_INSIDE]) linear_extrude(20) offset() projection() plate_main(solid=true);
        translate([0,0,-SPACING_INSIDE]) linear_extrude(20) offset() projection() plate_thumbs(solid=true);
        translate([0,0,PCB_HEIGHT_OFFSET-PCB_THICKNESS-PCB_CLEARANCE]) translate([4*KEY_UNIT, 2*KEY_UNIT, -2]) cylinder(h=20,r=(PCB_SCREW_3DP)/2);

        // trrs
        translate([6*KEY_UNIT, 0.75*KEY_UNIT, 0]) rotate([0,0,-ANGLE]) translate([1*KEY_UNIT,-0.5*KEY_UNIT,0])
        translate([0,0,-(PCB_CLEARANCE+PCB_THICKNESS-PCB_HEIGHT_OFFSET)]) rotate([-90,0,0]) translate([-1,0,-4.2]) union() {
            hull() {
                cylinder(h = 30, r = 3);
                translate([2,0,0]) cylinder(h = 30, r = 3);
            }
            hull() {
                cylinder(h = 14.7, r = 4);
                translate([2,0,0]) cylinder(h = 14.7, r = 4);
            }
            translate(v = [0,0,16]) hull() {
                cylinder(h = 30, r = 4.5);
                translate([2,0,0]) cylinder(h = 30, r = 4.5);
            }
        }

        // rp2040
        translate([6*KEY_UNIT, 0.75*KEY_UNIT, 0]) rotate([0,0,-ANGLE]) translate([-6,-0.5*KEY_UNIT,0])
        translate([0,0,-(PCB_CLEARANCE+PCB_THICKNESS-PCB_HEIGHT_OFFSET)]) rotate([-90,0,0]) union() {
            translate([1.5,-1,-3]) cube_rounded([20,5,25],r=1,center=true);
            translate([-1,0.5,-3]) hull() {
                cylinder(h = 100, r = 3.5);
                translate([5.5,0,0]) cylinder(h = 100, r = 3.5);
            }
        }

        // feet
        translate([0,0,-SPACING_INSIDE]) rotate(CASE_ANGLE) translate(v = [0,0,-4.5]) union() {
            translate(v = [7,7,0]) cylinder(h = 5, r = 3.5);
            translate(v = [7,3.6*KEY_UNIT,0]) cylinder(h = 5, r = 3.5);
            translate(v = [6.5*KEY_UNIT,-11,0]) cylinder(h = 5, r = 3.5);
            translate(v = [5.5*KEY_UNIT,3.5*KEY_UNIT,0]) cylinder(h = 5, r = 3.5);
        }
    }
    // pins
    translate([0,0,PCB_HEIGHT_OFFSET-PCB_THICKNESS-PCB_CLEARANCE]) union() {
        translate([1*KEY_UNIT, 1*KEY_UNIT, 0]) union() {
            cylinder(h=PCB_CLEARANCE-ORING_THICKNESS,r=PCB_PIN/2+ORING_THICKNESS/2);
            cylinder(h=PCB_THICKNESS+PCB_CLEARANCE,r=PCB_PIN_3DP/2);
        }
        translate([1*KEY_UNIT, 3*KEY_UNIT, 0]) union() {
            cylinder(h=PCB_CLEARANCE-ORING_THICKNESS,r=PCB_PIN/2+ORING_THICKNESS/2);
            cylinder(h=PCB_THICKNESS+PCB_CLEARANCE,r=PCB_PIN_3DP/2);
        }
        translate([5*KEY_UNIT, 1*KEY_UNIT, 0]) union() {
            cylinder(h=PCB_CLEARANCE-ORING_THICKNESS,r=PCB_PIN/2+ORING_THICKNESS/2);
            cylinder(h=PCB_THICKNESS+PCB_CLEARANCE,r=PCB_PIN_3DP/2);
        }
        translate([5*KEY_UNIT, 3*KEY_UNIT, 0]) union() {
            cylinder(h=PCB_CLEARANCE-ORING_THICKNESS,r=PCB_PIN/2+ORING_THICKNESS/2);
            cylinder(h=PCB_THICKNESS+PCB_CLEARANCE,r=PCB_PIN_3DP/2);
        }

        translate([6*KEY_UNIT, 0.75*KEY_UNIT, 0])
        rotate([0,0,-ANGLE]) translate([-2*KEY_UNIT,-1.75*KEY_UNIT,0]) union() {
            translate([3*KEY_UNIT, 1.75*KEY_UNIT/2, 0]) union() {
                cylinder(h=PCB_CLEARANCE-ORING_THICKNESS,r=PCB_PIN/2+ORING_THICKNESS/2);
                cylinder(h=PCB_THICKNESS+PCB_CLEARANCE,r=PCB_PIN_3DP/2);
            }
        }

        difference() {
            translate([4*KEY_UNIT, 2*KEY_UNIT, 0]) cylinder(h=PCB_CLEARANCE-1,r=(PCB_SCREW_3DP+2)/2);
            translate([4*KEY_UNIT, 2*KEY_UNIT, -2]) cylinder(h=20,r=(PCB_SCREW_3DP)/2);
        }
    }
}

module plate_main(solid=false) {
    difference() {
        cube([6*KEY_UNIT,4*KEY_UNIT,PLATE_THICKNESS]);
        if(!solid)
        {
            for(i=[0:5]) {
                for(j=[0:3]) {
                    if(j != 0 || i != 5)
                    {
                        translate([i*KEY_UNIT,j*KEY_UNIT,0]) hole();
                    }
                }
            }
        }
        translate([5.5*KEY_UNIT,0,-1]) cube([KEY_UNIT/2,KEY_UNIT/2,PLATE_THICKNESS+2]);
    }
}
module plate_thumbs(solid=false) {
    difference() {
        translate([6*KEY_UNIT, 0.75*KEY_UNIT, 0])
        rotate([0,0,-ANGLE]) translate([-2*KEY_UNIT,-1.75*KEY_UNIT,0]) cube([4*KEY_UNIT,1.75*KEY_UNIT,PLATE_THICKNESS]);
        if(!solid)
        {
            difference() {
                translate([0,0,-1]) cube([6*KEY_UNIT,4*KEY_UNIT,PLATE_THICKNESS+2]);
                translate([5.5*KEY_UNIT,0,-2]) cube([KEY_UNIT/2,KEY_UNIT/2,PLATE_THICKNESS+4]);
            }
            translate([6*KEY_UNIT, 0.75*KEY_UNIT, 0])
            rotate([0,0,-ANGLE]) translate([-2*KEY_UNIT,-1.75*KEY_UNIT,0]) union() {
                translate([2*KEY_UNIT,0.75*KEY_UNIT/2,0]) hole();
                translate([3*KEY_UNIT,0.75*KEY_UNIT/2,0]) hole();
            }
        }
    }
}

module plate() {
    difference() {
        union() {
            plate_main();
            plate_thumbs();
        }
        translate([3.5*KEY_UNIT, 1.5*KEY_UNIT,0]) hole();
    }
}
module hole() {
   translate([KEY_SPACING,KEY_SPACING,-1]) cube([KEY_HOLE,KEY_HOLE,PLATE_THICKNESS+2]);
}

module pcb(cutouts = false) {
    difference() {
        union() {
            translate([PCB_OFFSET,PCB_OFFSET,0]) cube_rounded([6*KEY_UNIT-2*PCB_OFFSET,4*KEY_UNIT-2*PCB_OFFSET,PCB_THICKNESS]);
            // translate([6*KEY_UNIT, 0.75*KEY_UNIT, 0]) rotate([0,0,-ANGLE]) translate([-2*KEY_UNIT+PCB_OFFSET,-1.75*KEY_UNIT+PCB_OFFSET,0]) cube_rounded([4*KEY_UNIT-2*PCB_OFFSET,1.75*KEY_UNIT-2*PCB_OFFSET,PCB_THICKNESS]);
            translate([6*KEY_UNIT, 0.75*KEY_UNIT, 0]) rotate([0,0,-ANGLE])
            translate([-2*KEY_UNIT+PCB_OFFSET,-1.75*KEY_UNIT+PCB_OFFSET,0])
            translate([0,(1.75-1.75)*KEY_UNIT/2,0])
            cube_rounded([4*KEY_UNIT-2*PCB_OFFSET,1.75*KEY_UNIT-2*PCB_OFFSET,PCB_THICKNESS]);
        }
        translate([1*KEY_UNIT, 1*KEY_UNIT, -1]) cylinder(h=20,r=PCB_PIN/2);
        translate([1*KEY_UNIT, 3*KEY_UNIT, -1]) cylinder(h=20,r=PCB_PIN/2);
        translate([5*KEY_UNIT, 1*KEY_UNIT, -1]) cylinder(h=20,r=PCB_PIN/2);
        translate([5*KEY_UNIT, 3*KEY_UNIT, -1]) cylinder(h=20,r=PCB_PIN/2);
        translate([4*KEY_UNIT, 2*KEY_UNIT, -1]) cylinder(h=20,r=PCB_SCREW/2);

        translate([6*KEY_UNIT, 0.75*KEY_UNIT, 0])
        rotate([0,0,-ANGLE]) translate([-2*KEY_UNIT,-1.75*KEY_UNIT,0]) union() {
            translate([3*KEY_UNIT, 1.75*KEY_UNIT/2, -1]) cylinder(h=20,r=PCB_PIN/2);
        }
    }
}

module cube_rounded(v, r=2, center=false){
    translate(center==true ? [r-v[0]/2,r-v[1]/2,-v[2]/2] : [r,r,0])
    union(){
        cylinder(h = v[2], r = r);
        translate(v = [0,v[1]-2*r,0]) cylinder(h = v[2], r = r);
        translate(v = [v[0]-2*r,v[1]-2*r,0]) cylinder(h = v[2], r = r);
        translate(v = [v[0]-2*r,0,0]) cylinder(h = v[2], r = r);
        translate(v = [-r,0,0]) cube([v[0],v[1]-2*r,v[2]]);
        translate(v = [0,-r,0]) cube([v[0]-2*r,v[1],v[2]]);
    }
}