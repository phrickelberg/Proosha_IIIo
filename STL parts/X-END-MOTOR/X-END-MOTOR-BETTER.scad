module vanilla_motor(){
	import("X-END-MOTOR.stl");
}

motor_center=[44.75,2.5,0];
cutout_offset=8;

module better_motor(){
	difference(){
		union(){
			vanilla_motor();
			patch();
		}
		cutout();
	}
}

module patch(){
	union(){
		intersection(){
			translate([31.75,6,0])
				cube([10,3,32],center=true);
			translate([44.75,6,0])
				rotate([90,0,0])
					cylinder(r=20,h=3,center=true);
		}
		intersection(){
			union(){
				translate([34.5,2.5,13.25])
					cube([4.5,10,4.5],center=true);
				//translate([34.5,2.5,-13.25])
					//cube([4.5,10,4.5],center=true);
				translate([44.75,2.5,-15.5])
					cube([25,10,9],center=true);
		
			}
			translate([44.75,2.5,0])
				rotate([90,0,0])
					cylinder(r=18,h=10,center=true);
		}
	}
}

module cutout(){
	union(){
		translate([motor_center[0]-cutout_offset,2.5,motor_center[2]+cutout_offset])
			rotate([90,0,0])
				cylinder(r=6.5,h=11,center=true,$fn=36);
		translate([motor_center[0]-cutout_offset,2.5,motor_center[2]-cutout_offset])
			rotate([90,0,0])
				cylinder(r=6.5,h=11,center=true,$fn=36);
		translate([motor_center[0]+cutout_offset,2.5,motor_center[2]-cutout_offset])
			rotate([90,0,0])
				cylinder(r=6.5,h=11,center=true,$fn=36);
		translate([motor_center[0]-cutout_offset,2.5,0])
			cube([13,11,2*cutout_offset],center=true);
		translate([motor_center[0],2.5,motor_center[2]-cutout_offset])
			cube([2*cutout_offset,11,13],center=true);
		translate([motor_center[0]-cutout_offset,2.5,motor_center[2]+cutout_offset])
			rotate([90,0,0])
				cylinder(r=6.5,h=11,center=true,$fn=36);
		intersection(){
			translate([motor_center[0]-cutout_offset,2.5,motor_center[2]+cutout_offset])
				rotate([0,45,0])
					translate([0,0,6.5])
						cube([13,11,13],center=true,$fn=36);
			translate([motor_center[0]-cutout_offset,2.5,motor_center[2]+cutout_offset])
				rotate([0,45,0])
					cube([13,11,26],center=true,$fn=36);
			translate([motor_center[0]-cutout_offset,2.5,motor_center[2]+cutout_offset])
				cube([13,11,26],center=true,$fn=36);
		}
	}
}
better_motor();