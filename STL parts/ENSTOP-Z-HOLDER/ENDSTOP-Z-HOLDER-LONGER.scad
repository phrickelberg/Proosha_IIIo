additional_length=15;
overlap=1;

module vanilla_holder(){
	import("ENDSTOP-Z-HOLDER.stl");
}


module stretch(){
	translate([30-overlap,-5,-1]){
		scale([additional_length+2*overlap,1,1]){
			translate([-30,5,1])
				intersection(){
					translate([30,-5,-1])
						cube([1,55,18.5]);
					vanilla_holder();
				}
		}
	}
}
module mount(){
	intersection(){
		translate([0,-5,-1])
			cube([30,55,18.5]);
		vanilla_holder();
	}
}

module tip(){
	translate([additional_length,0,0]){
		intersection(){
			translate([30,-5,-1])
				cube([20,55,18.5]);
			vanilla_holder();
		}
	}
}

module longer_holder(){
	union(){
		stretch();
		mount();
		tip();
	}
}

longer_holder();