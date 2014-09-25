module vanilla_idler(){
	import("EXTRUDER-IDLER-avec-guide.stl");
}

module idler_cutout(){
	translate([14,4.5738,20.85])
		rotate([90,0,0])
			rotate([0,0,360/32])
				cylinder(r=2,h=6,center=true, $fn=16);
}

module bowden_idler(){
	difference(){
		vanilla_idler();
		idler_cutout();
	}
}

bowden_idler();