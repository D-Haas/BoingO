module spring(steps=0, h=25, revs=10, thickness=1, r=0, r1=3, r2=0, base=false) //Boing boing boing
{difference(){union()
{
    //Sets r1 size to r ir it wasn't defined
    r1 = r==0 ? r1 : r;
    //Sets r2 size to r1 if it wasn't defined
    r2 = r2==0 ? r1 : r2;

    //Automatically calculate number of steps
    steps = steps==0 ? (h*revs*(r1+r2)/2)/20 : steps;

    //Change height, so the size bottom to top matches the one predefined
    h = base ? h-thickness : h;

    //Move it up to position it's bottom on the ground
    translate([0,0,base ? thickness/2 : 0])
    {
    //If it should have a base, model it
    if (base) { for (i=[0:steps/revs])
    {
        //Define scalars for parametric positioning
        thisScalar = i/steps;
        nextScalar = (i+1)/steps;

        //For bottom and top
        for (j=[0,h]) {
            //Set radius based on if its the bottom or the top
            r = (j==0?r1:r2);
            //Render tubes between spheres with the hull module
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
    //For each step (point of the curve)
    for (i=[0:steps-1])
    {
        //Define scalars for parametric positioning
        thisScalar = i/steps;
        nextScalar = (i+1)/steps;

        //Set radius of actual and next points of the curve
        thisR = r1 + (r2-r1)*thisScalar;
        nextR = r1 + (r2-r1)*nextScalar;

        //Render tubes between spheres with the hull module
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

module roundBowSpring(steps=0, h=10, thickness=1, width=3, base=false, baseWidth=0)
{difference() {union()
{
    //Automatically calculate number of steps
    steps = steps==0 ? h+width : steps;

    //Change height, so the size bottom to top matches the one predefined
    h = base ? h-thickness*2 : h;

    //Set baseWidth if it wasn't before
    baseWidth = baseWidth==0 ? (width==0 ? thickness : width) : baseWidth;

    //Move it up to position it's bottom on the ground
    translate(base ? [0,0,thickness] : [0,0,0])

    //For each step (point of the curve)
    for (i=[0:steps-1])
    {
        //Define scalars for parametric positioning
        thisScalar = i/steps;
        nextScalar = (i+1)/steps;

        //Render tubes between spheres with the hull module
        hull()
        {
            translate([
                width*sin(thisScalar*180),
                0,
                h*thisScalar
            ])
                sphere(d=thickness);
            translate([
                width*sin(nextScalar*180),
                0,
                h*nextScalar
            ])
                sphere(d=thickness);
        }
    }
    if (base)
    {
        //Render bottom base
        translate([-width/2, -thickness/2, 0])
            cube([width, thickness, thickness]);
        //Render top base
        translate([-width/2, -thickness/2, h+thickness])
            cube([width, thickness, thickness]);
    }
}
    if (!base)
    {
        //Cut bottom tip
        translate([-thickness/2, -thickness/2, -thickness/2])
            cube([2*thickness, 2*thickness, thickness/2]);
        //Cut top tip
        translate([-thickness/2, -thickness/2, h])
            cube([2*thickness, 2*thickness, thickness/2]);
    }

}}

module squareBowSpring(steps=0, h=10, thickness=1, width=3, base=false, baseWidth=0)
{difference() {union()
{
    //Automatically calculate number of steps
    steps = steps==0 ? h+width : steps;

    //Change height, so the size bottom to top matches the one predefined
    h = base ? h-thickness*2 : h;

    //Set baseWidth if it wasn't before
    baseWidth = baseWidth==0 ? (width==0 ? thickness : width) : baseWidth;

    //Move it up to position it's bottom on the ground
    translate(base ? [0,0,thickness] : [0,0,0])

    //For each step (point of the curve)
    for (i=[0:steps-1])
    {
        //Define scalars for parametric positioning
        thisScalar = i/steps;
        nextScalar = (i+1)/steps;

        //Render tubes between cubes with the hull module
        hull()
        {
            translate([
                width*sin(thisScalar*180),
                0,
                h*thisScalar
            ])
                cube(thickness, center=true);
            translate([
                width*sin(nextScalar*180),
                0,
                h*nextScalar
            ])
                cube(thickness, center=true);
        }
    }
    if (base)
    {
        //Render bottom base
        translate([-width/2, -thickness/2, 0])
            cube([width, thickness, thickness]);
        //Render top base
        translate([-width/2, -thickness/2, h+thickness])
            cube([width, thickness, thickness]);
    }
}
    if (!base)
    {
        //Cut bottom tip
        translate([-thickness/2, -thickness/2, -thickness/2])
            cube([2*thickness, 2*thickness, thickness/2]);
        //Cut top tip
        translate([-thickness/2, -thickness/2, h])
            cube([2*thickness, 2*thickness, thickness/2]);
    }

}}
