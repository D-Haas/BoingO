include <variables.scad>

$fs=0.5;

baseRadius = 15;
baseHeight = 4;

module base(h=3, r=8, outDrill=false, centerDrill=false, outDrillDiameter=boltDiameter, centerDrillDiameter=boltDiameter)
{
    difference()
    {
        linear_extrude(h)
            polygon([
                [0, r],
                [r*sin(120), r*cos(120)],
                [r*sin(240), r*cos(240)]
            ]);
        if (outDrill) { for (i=[0, 120, 240]) { rotate([0,0,i]) {
            translate([0,r*2/3,0])
                cylinder(d=outDrillDiameter, h=h+0.01);
        }}}
        if (centerDrill)
        {
            cylinder(d=centerDrillDiameter, h=h+0.01);
        }
    }
}

module spring(steps=0, h=25, revs=10, thickness=1, r=3) //Boing boing boing
{

    steps = steps==0 ? ($preview ? h*revs*r : h*revs*r*10) : steps;
    h = h-thickness*2;
    translate([0,0,thickness/2])
    {
    for (i=[0:steps/revs])
    {
        scalar = i/steps;
        for (j=[0,h])
        {
            translate([
                r*cos(revs*360*scalar),
                r*sin(revs*360*scalar),
                j,
            ])
            sphere(d=thickness);
        }
    }
    for (i=[0:steps])
    {
        scalar = i/steps;
        translate([
            r*cos(revs*360*scalar),
            r*sin(revs*360*scalar),
            h*scalar
        ])
        sphere(d=thickness);
    }
    }
}

module conicSpring(steps=0, h=25, revs=10, thickness=1, topR=3, bottomR=5) //Boing boing boing
{

    steps = steps==0 ? ($preview ? h*revs*r : h*revs*(topR+bottomR)/2*10) : steps;
    h = h-thickness*2;
    translate([0,0,thickness/2])
    {
    for (i=[0:steps/revs])
    {
        scalar = i/steps;
        for (j=[0,h])
        {
            translate([
                (bottomR+(topR-bottomR)*scalar)*cos(revs*360*scalar),
                (bottomR+(topR-bottomR)*scalar)*sin(revs*360*scalar),
                j,
            ])
            sphere(d=thickness);
        }
    }
    for (i=[0:steps])
    {
        scalar = i/steps;
        translate([
            scalar*r*cos(revs*360*scalar),
            scalar*r*sin(revs*360*scalar),
            h*scalar
        ])
        sphere(d=thickness);
    }
    }
}

union()
{
    //Bottom base
    base(h=baseHeight, r=baseRadius, outDrill=true, centerDrill=true, centerDrillDiameter=boltDiameter);
    difference()
    {
        conicSpring(h=30, thickness=2, topR=6, bottomR=4, revs=6);
    }
}



//Sleeve base
/*
difference()
{
    base(h=boltDiameter+4, r=baseRadius, outDrill=true, centerDrill=true, outDrillDiameter=boltDiameter+0.5);
    translate([0,0,(boltDiameter+4)/2])
    rotate([-90,0,0])
    for (i=[-1,1])
    {
        translate([i*4.5, 0, -10])
        cylinder(h=20, d=boltDiameter);
    }
}
*/
//Tubes
//for (i=[0,1,2])
//{
//   translate([10+i*4, 10, 0])
//    cylinder(h=boltLenght, d=boltDiameter-0.5);
//}

