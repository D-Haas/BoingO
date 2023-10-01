module spring(steps=0, h=25, revs=10, thickness=1, r=0, r1=3, r2=0, base=false) //Boing boing boing
{difference(){union()
{
    //Sets r1 size to r ir it wasn't defined
    r1 = r==0 ? r1 : r;
    //Sets r2 size to r1 if it wasn't defined
    r2 = r2==0 ? r1 : r2;

    //Automatically calculate number of steps
    steps = steps==0 ? (h*revs*(r1+r2)/2)/20 : steps;
    echo(steps=steps);

    //Change height, so the size bottom to top matches the one predefined
    h = base ? h-thickness/2 : h;
    //Move it up to position it's bottom on the ground
    translate([0,0,base ? thickness/2 : 0])
    {
    //If it should have a base, model it
    if (base) { for (i=[0:steps/revs])
    {
        thisScalar = i/steps;
        nextScalar = (i+1)/steps;
        for (j=[0,h]) {
            r = (j==0?r1:r2);
            hull()
            {
                translate([
                    r*cos(revs*360*thisScalar),
                    r*sin(revs*360*thisScalar),
                    j,
                ])
                    sphere(d=thickness);
                translate([
                    r*cos(revs*360*nextScalar),
                    r*sin(revs*360*nextScalar),
                    j,
                ])
                    sphere(d=thickness);
            }
        }
    }}
    for (i=[0:steps-1])
    {
        thisScalar = i/steps;
        nextScalar = (i+1)/steps;
        thisR = r1 + (r2-r1)*thisScalar;
        nextR = r1 + (r2-r1)*nextScalar;
        hull()
        {
            translate([
                thisR*cos(revs*360*thisScalar),
                thisR*sin(revs*360*thisScalar),
                h*thisScalar
            ])
                sphere(d=thickness);
            translate([
                nextR*cos(revs*360*nextScalar),
                nextR*sin(revs*360*nextScalar),
                h*nextScalar
            ])
                sphere(d=thickness);
        }
    }
    }
}
    //Remove base if it should not have one
    if (!base)
    {
        //Remove bottom tip
        translate([0, 0, -thickness/2])
            cylinder(r=r1+thickness/2*1.1, h=thickness/2);
        //Remove top tip
        translate([0, 0, h])
            cylinder(r=r2+thickness/2*1.1, h=thickness/2);

    }
}}

module roundBowSpring(steps=0, height=10, thickness=1, width=3, base=false, baseWidth=0)
{difference() {union()
{
    steps = steps==0 ? height+width : steps;
    height = base ? height-thickness*2 : height;
    baseWidth = baseWidth==0 ? (width==0 ? thickness : width) : baseWidth;
    translate(base ? [0,0,thickness] : [0,0,0])
    for (i=[0:steps-1])
    {
        thisScalar = i/steps;
        nextScalar = (i+1)/steps;
        hull()
        {
            translate([
                width*sin(thisScalar*180),
                0,
                height*thisScalar
            ])
                sphere(d=thickness);
            translate([
                width*sin(nextScalar*180),
                0,
                height*nextScalar
            ])
                sphere(d=thickness);
        }
    }
    if (base)
    {
        translate([-width/2, -thickness/2, 0])
            cube([width, thickness, thickness]);
        translate([-width/2, -thickness/2, height+thickness])
            cube([width, thickness, thickness]);
    }
}
    if (!base)
    {
        translate([-thickness/2, -thickness/2, -thickness/2])
            cube([2*thickness, 2*thickness, thickness/2]);
        translate([-thickness/2, -thickness/2, height])
            cube([2*thickness, 2*thickness, thickness/2]);
    }

}}

module squareBowSpring(steps=0, height=10, thickness=1, width=3, base=false, baseWidth=0)
{difference() {union()
{
    steps = steps==0 ? height+width : steps;
    height = base ? height-thickness*2 : height;
    baseWidth = baseWidth==0 ? (width==0 ? thickness : width) : baseWidth;
    translate(base ? [0,0,thickness] : [0,0,0])
    for (i=[0:steps-1])
    {
        thisScalar = i/steps;
        nextScalar = (i+1)/steps;
        hull()
        {
            translate([
                width*sin(thisScalar*180),
                0,
                height*thisScalar
            ])
                cube(thickness, center=true);
            translate([
                width*sin(nextScalar*180),
                0,
                height*nextScalar
            ])
                cube(thickness, center=true);
        }
    }
    if (base)
    {
        translate([-width/2, -thickness/2, 0])
            cube([width, thickness, thickness]);
        translate([-width/2, -thickness/2, height+thickness])
            cube([width, thickness, thickness]);
    }
}
    if (!base)
    {
        translate([-thickness/2*1.1, -thickness/2*1.1, -thickness/2*1.1])
            cube([2*thickness*1.2, 2*thickness*1.2, thickness/2*1.1]);
        translate([-thickness/2*1.1, -thickness/2*1.1, height])
            cube([2*thickness*1.2, 2*thickness*1.2, thickness/2*1.1]);
    }

}}
