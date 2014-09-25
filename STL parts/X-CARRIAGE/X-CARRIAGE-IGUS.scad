module vanilla_carriage(){
	import("X-CARRIAGE.stl");
}

module igus_carriage_legacy(){
	difference(){
		vanilla_carriage();
		translate([-13.25,22.5,11])
			rotate([0,90,0])
				cylinder(h=25.5,r=16/2,center=true, $fn=20);
		translate([13.25,22.5,11])
			rotate([0,90,0])
				cylinder(h=25.5,r=16/2,center=true, $fn=20);
		translate([-13.25,-22.5,11])
			rotate([0,90,0])
				cylinder(h=25.5,r=16/2,center=true, $fn=20);
		translate([13.25,-22.5,11])
			rotate([0,90,0])
				cylinder(h=25.5,r=16/2,center=true, $fn=20);	
	}
}

module igus_carriage(){
	difference(){
		vanilla_carriage();
		translate([-13.5,22.5,11])
			rotate([0,90,0])
				rotate([0,0,360/64])
					cylinder(h=25.5,r=16/2,center=true, $fn=32);
		translate([13.5,22.5,11])
			rotate([0,90,0])
				rotate([0,0,360/64])
					cylinder(h=25.5,r=16/2,center=true, $fn=32);
		translate([-13.5,-22.5,11])
			rotate([0,90,0])
				rotate([0,0,360/64])
					cylinder(h=25.5,r=16/2,center=true, $fn=32);
		translate([13.5,-22.5,11])
			rotate([0,90,0])
				rotate([0,0,360/64])
					cylinder(h=25.5,r=16/2,center=true, $fn=32);
	}
}

//vanilla_carriage();

igus_carriage();