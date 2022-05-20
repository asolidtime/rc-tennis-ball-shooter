ball_bearing_inner_dimension = 8;
ball_bearing_height = 7;
ball_bearing_support_width = 10;
ball_bearing_support_height = 2;
platform_support_diameter = 83 * 2;
platform_height = 4;
$fa = 1; // idk waht these are lol
$fs = 0.4;
union() {
cylinder(d=platform_support_diameter,h=platform_height);
translate([0,0,platform_height]) {
    cylinder(d=ball_bearing_support_width, h=ball_bearing_support_height);
    translate([0,0,ball_bearing_support_height]) {
        cylinder(d=ball_bearing_inner_dimension,h=ball_bearing_height);
    }
}
}