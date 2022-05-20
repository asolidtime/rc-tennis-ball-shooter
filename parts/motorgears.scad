// so, about the stepper
// according to a random datasheet I found online, the diameter of the shaft is 4.99mm, while the width of the indent is 4.52mm

use <MCAD/involute_gears.scad>
circular_pitch = 200; // idk what this is other than that it makes the gear bigger
//gear_height = 10; // height of the gear when it gets linear_extruded
$fa = 1; // idk waht these are lol
$fs = 0.4;


module 2dstepperhead(shaft_diameter=4.99, indent=4.52) { // generate the stepper head with specified shaft and indent lengths
    difference() {
        circle(d=shaft_diameter);
        translate([-5,indent/2]) {
            square(10); // the actual size of the square doesn't really matter
        }
    }
}

steppergear();
module steppergear(height=10) {
   linear_extrude(height=height) {
    difference() {
        gear(number_of_teeth=15, circular_pitch=circular_pitch,flat=true,bore_diameter=0);
        2dstepperhead();
    }
} 
}
//}