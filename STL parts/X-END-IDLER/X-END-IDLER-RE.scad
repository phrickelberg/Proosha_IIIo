         ///////////////////////////////////////////////////////////////////////
        // MODIFIED SCAD MODEL BASED ON THE PRUSA I3 EINSTEIN REWORK         //
       // LICENSED UNDER: GPL V2                                            //
      // ORIGINALLY CREATED BY EMOTION-TECH (http://www.reprap-france.com) //
     // MODIFIED BY MORITZ WALTER (iamnotachoice.com)                     //
    // ORIGINAL PART: X-END-IDLER.STL                                    //
   // MODIFIED PART: X-END-IDLER-RE.SCAD                                //
  // DATE OF CREATION/MODIFICATION: 14.09.2014                         //
 // VERSION 0.1                                                       //
////                                                               ////
// DESCRIPTION:                                                      //
// - parametrized the whole part                                     //
// - removed windows for more rigidity                               //
// - moved screw hole and flange for more rigidity and printability  //
// - minor changes where original parameters were missing            //
///////////////////////////////////////////////////////////////////////

  ///////////////////
 // CONFIGURATION //
///////////////////

// SMOOTH RODS
smooth_rod_diameter=8.5; // drill diameter of smooth rods
smooth_rod_fn=16;	// polygon resolution of smooth rods and taps
interaxial_distance=45; // interaxial distance between smooth rods
tap_diameter=7; // drill diameter of the counter screw tap, defaults to 7 which is good for a M8 screw
tap_length=5; // length of the counter screw tap, 5 is good for M8, don't make this too long or you have to shorten your smooth rods

// GENERAL DIMENSIONS
main_length=40.5; // length of the main body block (excluding foot)
main_width=16; // width of above block
total_height=57; // total height of the idler
total_length=52.5; // total length of the idler (including foot)
core_height=33; // height of the core cutout
walls_width=3.5; // width of the walls arround the core cutout
foot_height=12; // height of the foot
top_corner_radius=4.0; // rounded corner radius of the main body block
top_corner_fn=16; // polygon resolution of the above rounded corners

// MOUNT FOR ENDSTOP DIMENSIONS
mount_slot_height=3.5; // height of the slot/cutout
mount_slot_z=17; // z-offset of the mount slot relative to the top of the idler (= bottom of the model)
mount_slot_border=2; // border in x direction of the mount slot
mount_slot_width=14.7; // width of the mounting slot
mount_slot_fn=12; // polygon resolution of the slots rounded corners
mount_pin_cutout=2.6; // length of the sides for the tiny cutout for the through hole component pins of the endstop
mount_pin_cutout_width=11.5; // width of the above cutout
mount_pin_cutout_z=9; // z-offset of above cutout relative to the top of the idler (= bottom of the model)
mount_total_height=21; // total height of the mount, relative to the top of the idler (= bottom of the model)
mount_corner_radius=3; // rounded-corner radius of the mount
mount_corner_fn=16; // polygon resolution of above rounded corners

// BEARING MOUNT FLANGES
flange_holes_x=12.25; // x position of the flange holes
flange_holes_diameter=4; // drill diameter of the flange holes, defaults to 4 which is good for M4
flange_fn=16; // polygon resolution of flanges and above drill holes
flange_width=1.5; // width of the flanges that hold the bearing in place
flange_inner_diameter=5.5986; // inner (=smaller) diameter of the flanges
flange_outer_diameter=6.308; // outer (=larger) diameter of the flanges
flange_overlap=0.1; // overlap helper for correct rendering

// BUSHING BRACKET
bushing_diameter=14.9;
bushing_bracket_walls=2.05;
bushing_bracket_diameter=bushing_diameter+2*bushing_bracket_walls;
bushing_interaxial=14;
bushing_bracket_height=50;
bushing_fn=32;
bushing_bracket_slot_width=1;
bushing_bracket_slot_angle=-30;

// LEAD NUT BRACKET
lead_nut_size=9.2376;
lead_nut_fn=6;
lead_nut_height=4;//3.1;
lead_nut_smooth_rod_distance=17;
lead_nut_interaxial=14;
lead_nut_bracket_height=8;
lead_nut_bracket_diameter=16;
threaded_rod_diameter=5.5;
threaded_rod_fn=16;

  ///////////
 // MAGIC //
///////////

module vanilla_idler(){
	import("X-END-IDLER.stl");
}

module rotated_cylinder(_radius,_height,_fn,_orientation,_rotation){
	intersection(){
		if(_rotation==[90,0,0]){
			cube([4*_radius,_height,4*_radius],center=true);
		}else if(_rotation==[0,90,0]){
			cube([_height,4*_radius,4*_radius],center=true);
		}else if(_rotation==[0,0,90]){
			cube([4*_radius,4*_radius,_height],center=true);
		}
		rotate(_rotation)
			rotate([0,0,_orientation])
				cylinder(r=_radius,h=2*_height,$fn=_fn,center=true);
	}
}

module drills(){
	union(){
		// UPPER SMOOTH ROD
		translate([tap_length,0,interaxial_distance/2])
			rotated_cylinder(_radius=smooth_rod_diameter/2,_height=main_length,_fn=smooth_rod_fn,_orientation=180/smooth_rod_fn,_rotation=[0,90,0]);
		// UPPER TAP
		translate([-main_length/2,0,interaxial_distance/2])
			rotated_cylinder(_radius=tap_diameter/2,_height=2*tap_length,_fn=smooth_rod_fn,_orientation=180/smooth_rod_fn,_rotation=[0,90,0]);
		// LOWER SMOOTH ROD
		translate([tap_length+(total_length-main_length)/2,0,-interaxial_distance/2])
			rotated_cylinder(_radius=smooth_rod_diameter/2,_height=total_length,_fn=smooth_rod_fn,_orientation=180/smooth_rod_fn,_rotation=[0,90,0]);
		// LOWER TAP
		translate([-main_length/2,0,-interaxial_distance/2])
			rotated_cylinder(_radius=tap_diameter/2,_height=2*tap_length,_fn=smooth_rod_fn,_orientation=180/smooth_rod_fn,_rotation=[0,90,0]);
	}
}

module block(){
	union(){
		// RIGHT CORNER
		translate([0,-main_width/2+top_corner_radius,total_height/2-top_corner_radius])
			rotated_cylinder(_radius=top_corner_radius,_height=main_length,_center=true,_fn=top_corner_fn,_orientation=0,_rotation=[0,90,0]);
		// LEFT CORNER
		translate([0,main_width/2-top_corner_radius,total_height/2-top_corner_radius])
			rotated_cylinder(_radius=top_corner_radius,_height=main_length,_center=true,_fn=top_corner_fn,_orientation=0,_rotation=[0,90,0]);
		// CORNER BRIDGE
		translate([0,0,total_height/2-top_corner_radius])
			cube([main_length,main_width-2*top_corner_radius,2*top_corner_radius],center=true);
		// MAIN BLOCK
		translate([0,0,-top_corner_radius/2])
			cube([main_length,main_width,total_height-top_corner_radius],center=true);
		// FOOT
		translate([(total_length-main_length)/2,0,-total_height/2+foot_height/2])
			cube([total_length,main_width,foot_height],center=true);
	}
}

module block_cutout(){
	// CORE BLOCK
	cube([main_length,main_width-2*walls_width,core_height],center=true);
}

module mount_slot(){
	union(){
		// RIGHT SLOT END
		translate([(total_length-main_length)/2+total_length/2-mount_slot_border-mount_slot_height/2,-main_width/2+walls_width/2,-total_height/2+mount_slot_z])
			rotated_cylinder(_radius=mount_slot_height/2,_height=2*walls_width,_fn=mount_slot_fn,_orientation=0,_rotation=[90,0,0]);
		// LEFT SLOT END
		translate([(total_length-main_length)/2+total_length/2-mount_slot_border-mount_slot_width+mount_slot_height/2,-main_width/2+walls_width/2,-total_height/2+mount_slot_z])
			rotated_cylinder(_radius=mount_slot_height/2,_height=2*walls_width,_fn=mount_slot_fn,_orientation=0,_rotation=[90,0,0]);
		// SLOT CENTER
		translate([(total_length-main_length)/2+total_length/2-mount_slot_border-mount_slot_width/2,-main_width/2+walls_width/2,-total_height/2+mount_slot_z])
			cube([mount_slot_width-mount_slot_height,2*walls_width,mount_slot_height],center=true);
		// PIN CUTOUT
		translate([(total_length-main_length)/2+total_length/2-mount_slot_border-mount_slot_width/2,-main_width/2,-total_height/2+mount_pin_cutout_z])
			rotate([45,0,0])
				cube([mount_pin_cutout_width,mount_pin_cutout,mount_pin_cutout],center=true);
	}
}

module mount(){
	union(){
		// INNER
		translate([(total_length-main_length)/2+total_length/2-mount_slot_width/2-mount_slot_border-mount_corner_radius/2,-main_width/2+walls_width/2,-total_height/2+mount_total_height/2])
			cube([mount_slot_width+2*mount_slot_border-mount_corner_radius,walls_width,mount_total_height],center=true);
		// OUTER
		translate([(total_length-main_length)/2+total_length/2-mount_slot_width/2-mount_slot_border,-main_width/2+walls_width/2,-total_height/2+mount_total_height/2-mount_corner_radius/2])
			cube([mount_slot_width+2*mount_slot_border,walls_width,mount_total_height-mount_corner_radius],center=true);
		// CORNER
		translate([(total_length-main_length)/2+total_length/2-mount_corner_radius,-main_width/2+walls_width/2,-total_height/2+mount_total_height-mount_corner_radius])
			rotated_cylinder(_radius=mount_corner_radius,_height=walls_width,_fn=mount_corner_fn,_orientation=0,_rotation=[90,0,0]);
	}
}

module flanges(){
	translate([flange_holes_x,-main_width/2+walls_width+flange_width/2-flange_overlap/2,0])
		rotate([90,0,0])
			cylinder(r1=flange_inner_diameter/2,r2=flange_outer_diameter/2,h=flange_width+flange_overlap,center=true,$fn=flange_fn);
	translate([flange_holes_x,main_width/2-walls_width-flange_width/2+flange_overlap/2,0])
		rotate([90,0,0])
			cylinder(r1=flange_outer_diameter/2,r2=flange_inner_diameter/2,h=flange_width+flange_overlap,center=true,$fn=flange_fn);
}

module holes(){
	translate([flange_holes_x,0,0])
		rotate([90,0,0])
			cylinder(r=flange_holes_diameter/2,h=2*main_width,center=true,$fn=flange_fn);
}

module bushing_bracket(){
	union(){
		// BUSHING BRACKET
		translate([-main_length/2+bushing_bracket_diameter/2,-bushing_interaxial,-total_height/2+bushing_bracket_height/2])
			cylinder(r=bushing_bracket_diameter/2,h=bushing_bracket_height,center=true,$fn=bushing_fn,center=true);
		// BRACKET CONNECTOR
		translate([-main_length/2+bushing_bracket_diameter/2,-bushing_interaxial/2,-total_height/2+bushing_bracket_height/2])
			cube([bushing_bracket_diameter,bushing_interaxial,bushing_bracket_height],center=true);
	}
}

module bushing_cutouts(){
	// BUSHING DRILL
	translate([-main_length/2+bushing_bracket_diameter/2,-bushing_interaxial,0])
		cylinder(r=bushing_diameter/2,h=total_height,center=true,$fn=bushing_fn,center=true);
	// BUSHING BRACKET SLOT
	translate([-main_length/2+bushing_bracket_diameter/2,-bushing_interaxial,-total_height/2+bushing_bracket_height/2])
		rotate([0,0,bushing_bracket_slot_angle])
			translate([bushing_bracket_diameter/2,0,0])
				cube([bushing_bracket_diameter,bushing_bracket_slot_width,bushing_bracket_height],center=true);

}

module lead_nut_bracket(){
	union(){
		// LEAD NUT BRACKET
		translate([-main_length/2+bushing_bracket_diameter/2+lead_nut_smooth_rod_distance,-lead_nut_interaxial,-total_height/2+lead_nut_bracket_height/2])
			cylinder(r=lead_nut_bracket_diameter/2,h=lead_nut_bracket_height,center=true,$fn=lead_nut_fn,center=true);
		// BRACKET CONNECTOR
		translate([-main_length/2+bushing_bracket_diameter/2+lead_nut_smooth_rod_distance,-lead_nut_interaxial/2,-total_height/2+lead_nut_bracket_height/2])
			cube([lead_nut_bracket_diameter,lead_nut_interaxial,lead_nut_bracket_height],center=true);
	}
}
module lead_nut_bracket_cutouts(){
	union(){
		// LEAD NUT
		translate([-main_length/2+bushing_bracket_diameter/2+lead_nut_smooth_rod_distance,-lead_nut_interaxial,-total_height/2+lead_nut_bracket_height])
			cylinder(r=lead_nut_size/2,h=2*lead_nut_height,center=true,$fn=lead_nut_fn,center=true);
		// THREADED_ROD
		translate([-main_length/2+bushing_bracket_diameter/2+lead_nut_smooth_rod_distance,-lead_nut_interaxial,-total_height/2+lead_nut_bracket_height/2])
			cylinder(r=threaded_rod_diameter/2,h=2*lead_nut_bracket_height,center=true,$fn=threaded_rod_fn,center=true);
	}
}


module idler(){
	difference(){
		union(){
			block();
			mount();
			bushing_bracket();
			lead_nut_bracket();
		}
		drills();
		mount_slot();
		holes();
		difference(){
			block_cutout();
			flanges();
		}
		bushing_cutouts();
		lead_nut_bracket_cutouts();
	}
}

idler();
//vanilla_idler();