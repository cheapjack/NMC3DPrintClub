/////////////////////////////////////////////
// Intro to openSCAD for the 3D Print Club //
// Make Basic Shapes                       // 
// simple 2D -> 3D extrusion               // 
// Rectangles Cylinders and spheres        //
// Importing stl files                     // 
// Set colours                             // 
// Making modules/functions                //
/////////////////////////////////////////////

// Remember to add your own comments to help
// explaing your code to your self later on!
// F5 'previews' your model in the window 
// F6 'fully renders' your model ready for exporting and takes longer and makes it all one colour
// Once fully rendered you can export as .stl files and then slice it up ready for the ender
/* Comment out big chunks of code with /*
// Find all resources at http://www.openscad.org/
// Access the cheatsheet here
// http://www.openscad.org/documentation.html
// Buy filament here
// https://shop.3dfilaprint.com/
//
*/ // the enclosing commented chunk
// LETS GO!
//
// Define constants for the whole project here
// Then you can include values constant-ly through the project
// CONSTANTS
maze_scale = 0.25;
cylinder_height = 20;
// now instead of using specific values in the code you can refer to the constants. Make sure you make your own names for them so OpenSCAD does not confuse them with commands
////////////////////////////////////////////
// MAIN COMMANDS
// Here you want your main commands or 'calls' to the  modules you make

// Draw a cylinder
//cylinder(cylinder_height,d=10);
// don't forget to finish any command or function with a ';'
// or it won't run
// move the start position 30mm on x axis then call blanking_plate()
//blanking_plate(external_width, external_depth, external_height, wall_thickness, lid_height, colour)
translate([0, 0, 0])blanking_plate(20, 20, 20, 5, 3,"red");
// Call the maze importer but translate it -30 on x axis first
//translate([-30, 0, 0])my_maze(maze_scale);
// Uncomment the below to get another one, but shifted 30 on the y axis
//translate([0, 30, 0])my_maze(maze_scale);
////////////////////////////////////////////
// MODULE DEFINITIONS
////////////////////////////////////////////
// Define your modules and functions below that the code above 'calls' it into effect
// the format is
// module my_module_name(parameters){
        // my code I want to run when its called
        // with parameters
//    }
//
// Then make it run with my_module_name(parameters);
//
// Make a basic cube module



module myCube(width,depth,my_height,my_colour){
    // note the command 'color' is US spelling
    color(my_colour)
            rounder(0.1,width,depth,my_height,2,45);
            // extrude the following object by my_height 
            //linear_extrude(height = my_height)
                // draw the square to be extruded, make it draw from the centre
                //square([width, depth], center = true);
}

// Make the maze importing module

module my_maze(my_scale){
    // scale the imported file by scale eg 0.25 is 25%
    // along the x, y, z axes
    scale([my_scale,my_scale,my_scale])
    // import the file path.
    // if you keep the imported file in theu same directory
    // as your .scad code you can just use the file name and convexity is a standard 3
        import("MazeExample.stl", convexity=3);
}
// dont forget the enclosing curly bracket
// OpenSCAD highlights the bracket pairs in your code so you dont lose track
// Also indent your code with tabs so you can see how each line relates to the function

// Make a blanking plate module
// We'll use external dimensions for the outermost edge of the object then subtract the wall_thickness from the external dimensions to workout the size of the void inside

module blanking_plate(external_width, external_depth, external_height, wall_thickness, lid_height, colour){
    // Use difference() function to remove one shape from another
    // Second and following shapes are removed from the first
    difference(){
        translate([0, 0, 0])
            myCube(external_width, external_depth,external_height, "red");
        translate([0, 0, -11])
            // subtract wall_thickness and add 1mm to clear the void
            myCube(external_width-wall_thickness, external_depth-wall_thickness,external_height+2,"green");
        }
    translate([0, 0, (0.5 * external_height)])myCube(external_width + 4, external_depth + 4,lid_height, "red");
}
//////////////////////////////////////////////////////
// HOMEWORK                                         //
// Make a cylindrical version of the blanking plate //
//////////////////////////////////////////////////////

// Adapted by @cheapjack from Torsten Paul <Torsten.Paul@gmx.de> basic shape tutorial
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// LICENSE <http://creativecommons.org/publicdomain/zero/1.0/>.



// To fix the corners cut the main cube with smaller cubes with spheres removed


module rounder(pad,	// Padding to maintain manifold
box_l,	// Length
box_w,	// Width
box_h,	// Height
round_r,	// Radius of round
smooth){
    difference() {
	cube([box_l, box_w, box_h], center = true);

	translate([0, -box_w/2+round_r, box_h/2-round_r]) {
		difference() {
			translate([0,-round_r-pad,round_r+pad])
				cube([box_l+2*pad, round_r*2+pad, round_r*2+pad], center = true);
			rotate(a=[0,90,0])
				cylinder(box_l+4*pad,round_r,round_r,center=true,$fn=smooth);
		}
	}
	translate([0, box_w/2-round_r, box_h/2-round_r]) {
		difference() {
			translate([0,round_r+pad,round_r+pad])
				cube([box_l+2*pad, round_r*2+pad, round_r*2+pad], center = true);
			rotate(a=[0,90,0])
				cylinder(box_l+4*pad,round_r,round_r,center=true,$fn=smooth);
		}
	}
	translate([0, -box_w/2+round_r, -box_h/2+round_r]) {
		difference() {
			translate([0,-round_r-pad,-round_r-pad])
				cube([box_l+2*pad, round_r*2+pad, round_r*2+pad], center = true);
			rotate(a=[0,90,0])
				cylinder(box_l+4*pad,round_r,round_r,center=true,$fn=smooth);
		}
	}
	translate([0, box_w/2-round_r, -box_h/2+round_r]) {
		difference() {
			translate([0,round_r+pad,-round_r-pad])
				cube([box_l+2*pad, round_r*2+pad, round_r*2+pad], center = true);
			rotate(a=[0,90,0])
				cylinder(box_l+4*pad,round_r,round_r,center=true,$fn=smooth);
		}
	}

// ----

	translate([-box_l/2+round_r, box_w/2-round_r, 0]) {
		difference() {
			translate([-round_r-pad,round_r+pad,0])
				cube([round_r*2+pad, round_r*2+pad, box_h+2*pad], center = true);
			cylinder(box_h+4*pad,round_r,round_r,center=true,$fn=smooth);
		}
	}
	translate([box_l/2-round_r, box_w/2-round_r, 0]) {
		difference() {
			translate([round_r+pad,round_r+pad,0])
				cube([round_r*2+pad, round_r*2+pad, box_h+2*pad], center = true);
			cylinder(box_h+4*pad,round_r,round_r,center=true,$fn=smooth);
		}
	}

	translate([-box_l/2+round_r, -box_w/2+round_r, 0]) {
		difference() {
			translate([-round_r-pad,-round_r-pad,0])
				cube([round_r*2+pad, round_r*2+pad, box_h+2*pad], center = true);
			cylinder(box_h+4*pad,round_r,round_r,center=true,$fn=smooth);
		}
	}
	translate([box_l/2-round_r, -box_w/2+round_r, 0]) {
		difference() {
			translate([round_r+pad,-round_r-pad,0])
				cube([round_r*2+pad, round_r*2+pad, box_h+2*pad], center = true);
			cylinder(box_h+4*pad,round_r,round_r,center=true,$fn=smooth);
		}
	}

// ----

	translate([-box_l/2+round_r, 0, box_h/2-round_r]) {
		difference() {
			translate([-round_r-pad, 0, round_r+pad])
				cube([round_r*2+pad, box_w+2*pad, round_r*2+pad], center = true);
			rotate(a=[0,90,90])
				cylinder(box_w+4*pad,round_r,round_r,center=true,$fn=smooth);
		}
	}
	translate([box_l/2-round_r, 0, box_h/2-round_r]) {
		difference() {
			translate([round_r+pad, 0, round_r+pad])
				cube([round_r*2+pad, box_w+2*pad, round_r*2+pad], center = true);
			rotate(a=[0,90,90])
				cylinder(box_w+4*pad,round_r,round_r,center=true,$fn=smooth);
		}
	}
	translate([-box_l/2+round_r, 0, -box_h/2+round_r]) {
		difference() {
			translate([-round_r-pad, 0, -round_r-pad])
				cube([round_r*2+pad, box_w+2*pad, round_r*2+pad], center = true);
			rotate(a=[0,90,90])
				cylinder(box_w+4*pad,round_r,round_r,center=true,$fn=smooth);
		}
	}
	translate([box_l/2-round_r, 0, -box_h/2+round_r]) {
		difference() {
			translate([round_r+pad, 0, -round_r-pad])
				cube([round_r*2+pad, box_w+2*pad, round_r*2+pad], center = true);
			rotate(a=[0,90,90])
				cylinder(box_w+4*pad,round_r,round_r,center=true,$fn=smooth);
		}
	}

// ----

	translate([box_l/2-round_r, box_w/2-round_r, box_h/2-round_r]) {
		difference() {
			translate([round_r+pad, round_r+pad, round_r+pad])
				cube([round_r*2+pad, round_r*2+pad, round_r*2+pad], center = true);
			sphere(round_r,center=true,$fn=smooth);
		}
	}
	translate([-box_l/2+round_r, box_w/2-round_r, box_h/2-round_r]) {
		difference() {
			translate([-round_r-pad, round_r+pad, round_r+pad])
				cube([round_r*2+pad, round_r*2+pad, round_r*2+pad], center = true);
			sphere(round_r,center=true,$fn=smooth);
		}
	}
	translate([box_l/2-round_r, -box_w/2+round_r, box_h/2-round_r]) {
		difference() {
			translate([round_r+pad, -round_r-pad, round_r+pad])
				cube([round_r*2+pad, round_r*2+pad, round_r*2+pad], center = true);
			sphere(round_r,center=true,$fn=smooth);
		}
	}
	translate([-box_l/2+round_r, -box_w/2+round_r, box_h/2-round_r]) {
		difference() {
			translate([-round_r-pad, -round_r-pad, round_r+pad])
				cube([round_r*2+pad, round_r*2+pad, round_r*2+pad], center = true);
			sphere(round_r,center=true,$fn=smooth);
		}
	}

	translate([box_l/2-round_r, box_w/2-round_r, -box_h/2+round_r]) {
		difference() {
			translate([round_r+pad, round_r+pad, -round_r-pad])
				cube([round_r*2+pad, round_r*2+pad, round_r*2+pad], center = true);
			sphere(round_r,center=true,$fn=smooth);
		}
	}
	translate([-box_l/2+round_r, box_w/2-round_r, -box_h/2+round_r]) {
		difference() {
			translate([-round_r-pad, round_r+pad, -round_r-pad])
				cube([round_r*2+pad, round_r*2+pad, round_r*2+pad], center = true);
			sphere(round_r,center=true,$fn=smooth);
		}
	}
	translate([box_l/2-round_r, -box_w/2+round_r, -box_h/2+round_r]) {
		difference() {
			translate([round_r+pad, -round_r-pad, -round_r-pad])
				cube([round_r*2+pad, round_r*2+pad, round_r*2+pad], center = true);
			sphere(round_r,center=true,$fn=smooth);
		}
	}
	translate([-box_l/2+round_r, -box_w/2+round_r, -box_h/2+round_r]) {
		difference() {
			translate([-round_r-pad, -round_r-pad, -round_r-pad])
				cube([round_r*2+pad, round_r*2+pad, round_r*2+pad], center = true);
			sphere(round_r,center=true,$fn=smooth);
		}
	}
}
}
