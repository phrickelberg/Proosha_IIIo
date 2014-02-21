union(){
	import("X-END-IDLER.stl");
	difference(){
		union(){
			translate([0,6.25,0]){
				cube(size=[26,3.5,35],center=true);
			}
			translate([6,-6.25,0]){
				cube(size=[14,3.5,35],center=true);
			}
		}
		union(){
			translate([6,0,10.5]){
				rotate(a = [90,0,0]) {
					cylinder(h=30,r=6,center=true);
				}
			}
			translate([6,0,-10.5]){
				rotate(a = [90,0,0]) {
					cylinder(h=30,r=6,center=true);
				}
			}
			translate([0,6.25,10.5]){
				cube(size=[12,10,12],center=true);
			}
			translate([0,6.25,-10.5]){
				cube(size=[12,10,12],center=true);
			}

			translate([-6,6.25,10.5]){
				rotate(a = [90,0,0]) {
					cylinder(h=10,r=6,center=true);
				}
			}
			translate([-6,6.25,-10.5]){
				rotate(a = [90,0,0]) {
					cylinder(h=10,r=6,center=true);
				}
			}
		}
	}
}