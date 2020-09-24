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
cylinder(cylinder_height,d=10);
// don't forget to finish any command or function with a ';'
// or it won't run
translate([30, 0, 0])blanking_plate(20, 20, 20, 5, 1,"red");
// Call the maze importer but translate it -30 on x axis
translate([-30, 0, 0])my_maze(maze_scale);
// Uncomment the below to get another one
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
            // extrude the following by my_height 
            linear_extrude(height = my_height)
                // draw a square to be extruded
                square([width, depth], center = true);
}

// Make the maze importing module

module my_maze(scale){
    // scale the imported file by scale eg 0.25 is 25%
    // along the x, y, z axes
    scale([scale,scale,scale])
    // import the file path.
    // if you keep the imported file in theu same directory
    // as your .scad code you can just use the file name
        import("MazeExample.stl", convexity=3);
}
// dont forget the enclosing curly bracket
// OpenSCAD highlights the bracket pairs in your code so you dont lose track
// Also indent your code with tabs so you can see how each line relates to the function

// Make a blanking plate module
// We'll use external dimensions for the outermost edge of the object then subtract the wall_thickness from the external dimensions to workout the size of the void inside

module blanking_plate(external_width, external_depth, external_height, wall_thickness, lid_height, colour){
    // Use difference to remove one shape from another
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
