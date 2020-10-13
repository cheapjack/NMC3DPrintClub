////////////////////////////////////////////
// NMC3D Print Club                       //
// Make A Blanking Plate                  // 
////////////////////////////////////////////


// Call blanking_plate()
blanking_plate(20, 20, 20, 5, 1,"red");

// MODULE DEFINITIONS

// Make a basic cube module

module myCube(width,depth,my_height,my_colour){
    // note the command 'color' is US spelling
    color(my_colour)
            // extrude the following object by my_height 
            linear_extrude(height = my_height)
                // draw the square to be extruded, make it draw from the centre
                square([width, depth], center = true);
}

// Make a blanking plate module
// We'll use external dimensions for the outermost edge of the object then subtract the wall_thickness from the external dimensions to workout the size of the void inside

module blanking_plate(external_width, external_depth, external_height, wall_thickness, lid_height, colour){
    // Use difference() function to remove one shape from another
    // Second and following shapes are removed from the first
    difference(){
        translate([0, 0, 0])
            myCube(external_width, external_depth,external_height, "red");
        translate([0, 0, -1])
            // subtract wall_thickness and add 1mm to clear the void
            myCube(external_width-wall_thickness, external_depth-wall_thickness,external_height+2,"green");
        }
    myCube(external_width + 4, external_depth + 4,lid_height, "red");
}

// Make by @cheapjack
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// LICENSE <http://creativecommons.org/publicdomain/zero/1.0/>.
