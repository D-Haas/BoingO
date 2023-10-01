# BoingO
This library aims to provide a way to create differents spring types within any parameters the user fill.


![Regular](images/spring.png)
![Rounded Bow](images/roundedBowSpring.png)
![Square Bow](images/squareBowSpring.png)

## How to use
```openscad
//Creating a regular spring
spring(
  steps,     //Number of nodes (spheres) the spring will model the lines (cylinders) from, if set to 0 it will be setted to a default value
  h,         //Total height of the spring, including base if selected
  revs,      //Number os revolutions (turns) the spring will do
  thickness, //Thickness of the lines that compose the spring
  r,         //Radius of the spring (total radius is equal to r+thickness/2)
  r1,        //Radius of the spring bottom
  r2,        //Radius of the spring top
  base       //Define if the spring will have a base or not
);

roundBowSpring(
  steps,     //Same as above
  h,         //*
  thickness, //*
  width,     //Arch's distortion on the y-axis (making a sine curve)
  base,      //Same as above
  baseWifth  //Base size along the y-axis (size keeps the same along the x and z axis, which is equal thickness)
);

squareBowSpring(); //Same as roundBowSpring but made out of cubes instead of spheres
```
