/*
** For Noa. A demo to produce a hollow sphere with open holes at
** specific angles along the y axis.
*/
MMINFEET=0.00328084;    // 1mm == how man feet?
1FOOT=304.8;        // size in mm
SPHERESIZE=6;     // Size of the sphere
HOLESIZE=1 * 1FOOT/12;  // size of the hole
HOLEHEIGHT=2 * 1FOOT/12;  // Height of the hole
SKINDEPTH=10;     // depth of the sphere "skin" in mm

module hole(theta)
{
  translate([((SPHERESIZE*1FOOT/2) - 1FOOT) * sin(theta),0, ((SPHERESIZE*1FOOT/2) - 1FOOT) * cos(theta)]) rotate([0, theta, 0]) cylinder(r=1FOOT, h=1FOOT);
}

module hollowsphere()
{
  difference()
  {
    sphere(r=SPHERESIZE * 1FOOT/2);
    sphere(r=(SPHERESIZE * 1FOOT/2) - SKINDEPTH);
  }
}

difference()
{
  //sphere(r=SPHERESIZE * 1FOOT/2);   // Make a sphere SPHERESIZE in feet
  hollowsphere();
  //translate([0,0,(SPHERESIZE*1FOOT/2)-1FOOT/2]) cylinder(r=1FOOT, h=1FOOT);
  #hole(0);
  #hole(45);
  #hole(90);
  #hole(90+45);
  #hole(180);
  #hole(180+45);
  #hole(270);
  #hole(270+45);
}
