         ///////////////////////////////////////////////////////////////////////
        // MODIFIED SCAD MODEL BASED ON THE PRUSA I3 EINSTEIN REWORK         //
       // LICENSED UNDER: GPL V2                                            //
      // ORIGINALLY CREATED BY EMOTION-TECH (http://www.reprap-france.com) //
     // MODIFIED BY MORITZ WALTER (iamnotachoice.com)                     //
    // ORIGINAL PART: X-END-IDLER.STL                                    //
   // MODIFIED PART: X-END-IDLER-BETTER-IGUS.SCAD                       //
  // DATE OF CREATION/MODIFICATION: 14.09.2014                         //
 // VERSION 0.1                                                       //
////                                                               ////
// DESCRIPTION:                                                      //
// - removed windows for more rigidity                               //
// - moved screw hole and flange for more rigidity and printability  //
// - resized LM8UU mounting clamp for IGUS RJMP-01-08                //
///////////////////////////////////////////////////////////////////////


holes_offset=4;
tap_radius=3.5;
tap_length=5;

module flanges(){
	translate([16.25-holes_offset,-3.75,0])
		rotate([90,0,0])
			cylinder(r1=2.7993,r2=3.154,h=1.5,center=true,$fn=16);
	translate([16.25-holes_offset,3.75,0])
		rotate([90,0,0])
			cylinder(r2=2.7993,r1=3.154,h=1.5,center=true,$fn=16);
		/*
		intersection(){
			flange_box();
			vanilla_idler();
		}
		*/
}

module flange_box(){
	translate([16.25,0,0])
		cube([7,9+2*3.5,7],center=true);
}

module vanilla_idler(){
	import("X-END-IDLER.stl");
}

module windows(){
	translate([0,6.25,0]){
		cube(size=[26,3.5,35],center=true);
	}
	translate([6,-6.25,0]){
		cube(size=[14,3.5,35],center=true);
	}
}

module corks(){
	translate([16.25,6.25,0]){
		cube([7,3.5,7],center=true);
	}
	translate([16.25,-6.25,0]){
		cube([7,3.5,7],center=true);
	}
}

module holes(){
	translate([16.25-holes_offset,0,0])
		rotate([90,0,0])
			cylinder(r=2,h=20,center=true,$fn=16);
}

module clean_idler(){
	union(){
		difference(){
			vanilla_idler();
			flange_box();
		}
		windows();
		corks();
	}
}

module better_idler(){
	difference(){
		union(){
			clean_idler();
			flanges();
			screw_tap();
		}
		holes();
	}
}

module better_igus_idler(){
	difference(){
		better_idler();
		translate([-10.75,-14,0])
			cylinder(r=16/2, h=60, center=true, $fn=20);
	}
}

module screw_tap(){
	translate([-20.25+tap_length/2,0,22.5])
		rotate([0,90,0])
			difference(){
				cylinder(r=5,h=tap_length,center=true,$fn=16);
				cylinder(r=tap_radius,h=tap_length,center=true,$fn=16);
			}
	translate([-20.25+tap_length/2,0,-22.5])
		rotate([0,90,0])
			difference(){
				cylinder(r=5,h=tap_length,center=true,$fn=16);
				cylinder(r=tap_radius,h=tap_length,center=true,$fn=16);
			}
}

better_igus_idler();