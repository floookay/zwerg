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
CASE_ANGLE = [0,10,6];    // test with case_height
CASE_HEIGHT = 45;   // test with case_angle

PCB_THICKNESS = 1.6;
PCB_OFFSET = 1;


BOTTOM_OFFSET = 5;

// for pcb outline and positions
// projection() translate([0,0,-PLATE_THICKNESS]) plate();
// projection() translate([0,0,-PLATE_THICKNESS-5]) pcb();

//translate([0,0,-PLATE_THICKNESS-5]) color("green") pcb();

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
        translate([-CASE_RIM_WIDTH,0,-SPACING_INSIDE,]) rotate(CASE_ANGLE) translate(v = [0,-200,-200]) cube([400,400,200]);
        translate([0,0,-SPACING_INSIDE]) linear_extrude(20) offset() projection() plate_main(solid=true);
        translate([0,0,-SPACING_INSIDE]) linear_extrude(20) offset() projection() plate_thumbs(solid=true);
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
    }
}
module plate_thumbs(solid=false) {
    difference() {
        translate([6*KEY_UNIT, 0.75*KEY_UNIT, 0])
        rotate([0,0,-ANGLE]) translate([-2*KEY_UNIT,-1.75*KEY_UNIT,0]) cube([4*KEY_UNIT,1.75*KEY_UNIT,PLATE_THICKNESS]);
        if(!solid)
        {
            plate_main(solid=true);
            translate([6*KEY_UNIT, 0.75*KEY_UNIT, 0])
            rotate([0,0,-ANGLE]) translate([-2*KEY_UNIT,-1.75*KEY_UNIT,0]) union() {
                translate([2*KEY_UNIT,0.75*KEY_UNIT/2,0]) hole();
                translate([3*KEY_UNIT,0.75*KEY_UNIT/2,0]) hole();
            }
        }
    }
}

module plate() {
    union() {
        plate_main();
        plate_thumbs();
    }
}
module hole() {
   translate([KEY_SPACING,KEY_SPACING,-1]) cube([KEY_HOLE,KEY_HOLE,PLATE_THICKNESS+2]);
}

module pcb() {
    union() {
        translate([PCB_OFFSET,PCB_OFFSET,0]) cube_rounded([6*KEY_UNIT-2*PCB_OFFSET,4*KEY_UNIT-2*PCB_OFFSET,PCB_THICKNESS]);
        // translate([6*KEY_UNIT, 0.75*KEY_UNIT, 0]) rotate([0,0,-ANGLE]) translate([-2*KEY_UNIT+PCB_OFFSET,-1.75*KEY_UNIT+PCB_OFFSET,0]) cube_rounded([4*KEY_UNIT-2*PCB_OFFSET,1.75*KEY_UNIT-2*PCB_OFFSET,PCB_THICKNESS]);
        translate([6*KEY_UNIT, 0.75*KEY_UNIT, 0]) rotate([0,0,-ANGLE])
        translate([-2*KEY_UNIT+PCB_OFFSET,-1.75*KEY_UNIT+PCB_OFFSET,0])
        translate([0,(1.75-1.25)*KEY_UNIT/2,0])
        cube_rounded([4*KEY_UNIT-2*PCB_OFFSET,1.25*KEY_UNIT-2*PCB_OFFSET,PCB_THICKNESS]);
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