// Import 2D svg's and pngs using the full path like this
//import(file = "/full/path/to/my_file.svg", center = false, dpi = 96);
// NB Full paths in Windows might be like this
// import(file = "\Program Files\Custom Utilities\my_file.svg", center = false, dpi = 96);



//import("/home/cheapjack/NMC3DPrintClub/OpenSCAD/2D_3D_SVG/SerialDilutionLadder.svg");


import(file = "/home/cheapjack/NMC3DPrintClub/OpenSCAD/2D_3D_SVG/sample2.svg", center = false, dpi = 96);


// Use a png with surface
translate([-300,1,0])
scale([1,1,0.5])surface(file = "/home/cheapjack/NMC3DPrintClub/OpenSCAD/2D_3D_SVG/nmcLogo.png", center = false, invert = false);


my_logo = "/home/cheapjack/NMC3DPrintClub/OpenSCAD/2D_3D_SVG/circle.svg";


logo(20);

module logo(height) {
    linear_extrude(height = height) {
        scale(1)
        import(my_logo);
    }
}