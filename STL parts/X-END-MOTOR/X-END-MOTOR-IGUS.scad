module vanilla_motor(){
	import("X-END-MOTOR-V2.stl");
}

module igus_motor(){
	difference(){
		vanilla_motor();
		translate([7.75,-14,0])
			cylinder(r=16/2, h=60, center=true, $fn=20);
	}
}


igus_motor();