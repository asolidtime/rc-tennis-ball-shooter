use <MCAD/involute_gears.scad>
use <MCAD/boxes.scad>
use <motorgears.scad>
include <NopSCADlib/lib.scad>

circular_pitch = 200; // idk what this is other than that it makes the gear bigger
base_height = 10; // height of the gear when it gets linear_extruded
mount_height = 140;
stand_width = 20;
stepper_clearance=0;
gear_diameter = 82 * 2;
stand_distance = 120; // distance of stands from each other
pole_diameter = 10; // diameter of the pole that holds up the angle-y part
platform_space_from_stands = 2;
platform_width = stand_distance - (stand_width + platform_space_from_stands*2);
platform_length=gear_diameter;
thing = -stand_distance/2 + stand_width/2 + platform_space_from_stands;
$fa = 1; // idk waht these are lol
$fs = 0.4;
stepper_size = 40;
pole_distance_from_top = pole_diameter;
color ([1,0,0]) {
    difference() {
    union() {
    stand();
    mainGear();
    stepperStuff();
    }
    union() {
        platform();
        cylinder(d=22,h=7.4,center=false);
    }
}
}



module stepperStuff() {
    difference() {
        union() {
rotate([90,0,270]) translate([0,(mount_height-pole_distance_from_top)-91.6,-thing - stepper_size/2]) {
    difference() {
    translate([0,-20/2,0]) cube([stepper_size,stepper_size + 20,2],center=true);
        union() {
    translate([0,0,2]) {
        NEMA_screws(NEMA17_40, M3_pan_screw);
        
    }
    cylinder(d=10,h=30,center=true);
    union() {
        for (rot=[0,180]) {
            rotate([rot,0,0]) translate([0,0,-1.9]) NEMA(NEMA17_40);
        }
    }
}
}
    difference() {
    union() {
        for(rot = [0,180]) {
            rotate([0,rot,0]) {
            for (pos = [-20,20-4]) {
                translate([pos,-stepper_size-1,10]) rotate([0,90,0]) linear_extrude(height=4) polygon([[10,10],[20,10],[10,20]]);
            }
        }
        for (pos = [-20+4,20]) translate([pos,-stepper_size-1,-60]) rotate([0,270,0]) {
            linear_extrude(height=4) polygon([[10,10],[40,10],[10,40]]);
            
        }
        translate([-stepper_size/2,-31,-91.6/2-5]) cube([40,30,4]);
        }
    }
    NEMA(NEMA17_40);
}
}


    
    //translate ([0,0,10]) steppergear();
}
translate([0,0,-10]) mainGear(); // ugly hack to clean off the bottom
}

}






//platform();
module platform() {
    translate([0,0,mount_height - pole_distance_from_top]) cube([platform_width,platform_length,base_height],center=true);
    rotate([90,0,90]) {
        translate([0,mount_height - pole_distance_from_top,0]) {
            translate([0,0,thing]) mainGear();
            pole();
            for (pos=[-stand_distance/2,stand_distance/2]) translate([0,0,pos])  {
                fakeBearing();
                translate([0,8,0]) fakeBearing();
            }
        }
        
        //cube(30);
    }
}

module fakeBearing() {
    cylinder(d=22,h=7.4,center=true);
}


module mainGear() {
    linear_extrude(height=base_height) {
    gear(number_of_teeth=150, circular_pitch=circular_pitch,flat=true,bore_diameter=0);
    }
}

module stand() {
    for (pos = [-stand_distance/2, stand_distance/2]) {
        translate([pos, 0, mount_height/2]) {
            roundedBox(size=[stand_width, stand_width, mount_height], radius=5,sidesonly=true);
        }
    }
}

module pole() {
    cylinder(d=pole_diameter,h=stand_distance + stand_width * 2,center=true);
    
}