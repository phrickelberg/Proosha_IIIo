  ///////////////////
 // CONFIGURATION //
///////////////////

// OVERALL DIMENSIONS OF THE CORNER
corner_width=18;
corner_length=22;
corner_height=56;

// DIMENSIONS OF DRILL HOLES FOR THREADED RODS
threaded_rod_diameter=10.8;
threaded_rod_fn=18;

// DIMENSIONS OF CUTOUTS FOR WHASHERS
whasher_diameter=21.5;
whasher_height=2;
whasher_fn=32;

// DIMENSIONS OF MOUNT FOR SMOOTH RODS
smooth_rod_diameter=8.1;
smooth_rod_fn=16;
smooth_rod_depth=20;

// POSITIONING OF ALL RODS
lower_x_threaded_rod_z=12;
upper_x_threaded_rod_z=34;
y_threaded_rod_z=23;
y_smooth_rod_z=54;

// DIMENSION AND POSITION OF CUTOUT FOR CABLE TIE
cable_tie_height=2;
cable_tie_width=3.5;
cable_tie_z=46;

// FANCY CORNER CONFIGURATION
outer_corner_cut=2*sqrt(whasher_height);
top_corner_cut=2.12;

  ///////////
 // MAGIC //
///////////

module vanilla_corner(){
	translate([0,0,28])
		import("Y-CORNERS.stl");
}

module x_rods(){
	union(){
		// LOWER THREADED ROD
		translate([0,0,lower_x_threaded_rod_z])
			rotate([0,90,0])
				rotate([0,0,360/threaded_rod_fn/2])
					cylinder(r=threaded_rod_diameter/2, h=2*corner_width,center=true,$fn=threaded_rod_fn);
		// UPPER THREADED ROD
		translate([0,0,upper_x_threaded_rod_z])
			rotate([0,90,0])
				rotate([0,0,360/threaded_rod_fn/2])
					cylinder(r=threaded_rod_diameter/2, h=2*corner_width,center=true,$fn=threaded_rod_fn);
		// CABLE TIE
		translate([0,0,cable_tie_z])
			cube([2*corner_width,cable_tie_width,cable_tie_height],center=true);
	}
}

module y_rods(){
	union(){
		// WHASHER
		translate([0,-corner_length/2,y_threaded_rod_z])
			rotate([90,0,0])
				rotate([0,0,360/whasher_fn/2])
					cylinder(r=whasher_diameter/2, h=2*whasher_height,center=true,$fn=whasher_fn);
		// THREADED ROD
		translate([0,0,y_threaded_rod_z])
			rotate([90,0,0])
				rotate([0,0,0])
					cylinder(r=threaded_rod_diameter/2, h=2*corner_length,center=true,$fn=threaded_rod_fn);
		// SMOOTH ROD
		translate([0,corner_length/2,y_smooth_rod_z])
			rotate([90,0,0])
				rotate([0,0,360/smooth_rod_fn/2])
					cylinder(r=smooth_rod_diameter/2, h=2*smooth_rod_depth,center=true,$fn=smooth_rod_fn);
	}
}

module block(){
	translate([0,0,corner_height/2])
		cube([corner_width,corner_length,corner_height],center=true);
}

module fancy_corners(){
	union(){
		/*
		// INNER
		translate([corner_width/2,corner_length/2,corner_height/2])
			rotate([0,0,45])
				cube([inner_corner_cut,2*inner_corner_cut,2*corner_height],center=true);
		translate([-corner_width/2,corner_length/2,corner_height/2])
			rotate([0,0,-45])
				cube([inner_corner_cut,2*inner_corner_cut,2*corner_height],center=true);
		*/
		// OUTER
		translate([corner_width/2,-corner_length/2,corner_height/2])
			rotate([0,0,-45])
				cube([outer_corner_cut,2*outer_corner_cut,2*corner_height],center=true);
		translate([-corner_width/2,-corner_length/2,corner_height/2])
			rotate([0,0,45])
				cube([outer_corner_cut,2*outer_corner_cut,2*corner_height],center=true);
		// UPPER
		translate([-corner_width/2,0,corner_height])
			rotate([0,-45,0])
				cube([2*top_corner_cut,2*corner_length,top_corner_cut],center=true);
		translate([corner_width/2,0,corner_height])
			rotate([0,45,0])
				cube([2*top_corner_cut,2*corner_length,top_corner_cut],center=true);
		translate([0,-corner_length/2,corner_height])
			rotate([45,0,0])
				cube([2*corner_width,2*top_corner_cut,top_corner_cut],center=true);
	}
}

module corner(){
	difference(){
		block();
		fancy_corners();
		x_rods();
		y_rods();
	}
}

corner();
