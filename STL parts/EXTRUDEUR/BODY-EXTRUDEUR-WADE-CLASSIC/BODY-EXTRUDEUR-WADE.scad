mount_height=32;
mount_depth=8;
mount_width=17;
servo_height=23;
servo_width=12;
servo_depth=17;

mount_position=[-servo_depth,0,34];

module vanilla_extruder(){
	import("BODY-EXTRUDEUR-WADE.stl");
}

module level_extruder(){
	vanilla_extruder();
	translate(mount_position)
		cube([mount_depth,mount_height,mount_width]);
}

level_extruder();