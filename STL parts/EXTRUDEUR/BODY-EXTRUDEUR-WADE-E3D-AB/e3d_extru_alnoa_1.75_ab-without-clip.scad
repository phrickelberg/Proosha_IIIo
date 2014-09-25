module ab_extruder(){
	import("e3d_extru_alnoa_1.75_ab.STL");
}

module ab_extruder_without_clip(){
	difference(){
		ab_extruder();
		translate([17,49,4.5])
			cube([40,20,20], center=true);
	}
}

ab_extruder_without_clip();