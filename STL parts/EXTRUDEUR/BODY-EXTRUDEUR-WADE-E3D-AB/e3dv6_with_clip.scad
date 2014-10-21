module ab_extruder(){
	import("e3d_extru_alnoa_1.75_ab.STL");
}

module bowden_shim(){
    // e3d cooler body with bowden
    rotate([-90,0,0]) union(){
	cylinder($fs = 0.1,h=3.8,d=16.2);
	translate([-8.1,-10,0]) cube([16.2,10,3.8]);
	cylinder(h=25,d=4,$fs = 0.1);
	translate([0,0,-6 ]) cylinder($fs = 0.1,h=9,d=11.8);
	translate([-5.9,-10,-10]) cube([11.8,10,10]);
    }
}

module cutoff(){
    // material to be stripped of from the main extruder to allow a tight fit.
    translate([73.36,43.83,21.35]) union(){
	translate([-10,0,-0.5]) cube([36,10,2]);
	translate([0,0,-3.035]) cube([16.529,10,4]);
    }
}

module ab_extruder_with_bowden_e3dv6_tight_fit(){
    difference(){
	union(){
	    ab_extruder();
	    // add material to extruder block
	    translate([73.36,44.253,5.315]) cube([16.529,10,14.75]);
	    // add material to clip
	    translate([9,44.25,0]) cube([16,9.58,9.2]);
	}
	// cut bowden and some material off top from the main exturder block
	cutoff();
	// cut bowden and some material off top from the main exturder block
	translate([81.643,50.03,14.065]) bowden_shim();
	// cut bowden from clip
	translate([17,50.03,14]) bowden_shim();
    }
}

ab_extruder_with_bowden_e3dv6_tight_fit();
