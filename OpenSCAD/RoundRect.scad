// Simple Rounded Rectangles 

rounded_rect(100,200,20);


module rounded_rect(my_width,my_depth,corner){
    difference(){
        square([my_width,my_depth]);
        translate([0,0,0])rotate([0,0,0])fillet(corner,2);
        translate([0,my_depth,0])rotate([180,0,0])fillet(corner,2);
        translate([my_width,0,0])rotate([0,180,0])fillet(corner,2);
        translate([my_width,my_depth,0])rotate([180,180,0])fillet(corner,2);
        }
}


module fillet(r, h) {
    translate([r / 2, r / 2, 0])
        difference() {
            cube([r + 0.01, r + 0.01, h], center = true);
            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true);
        }
}



