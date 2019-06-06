
Boolean shiftPressed=false;
Boolean ctrlPressed=false;
Boolean altPressed=false;
Integer numModPressed=0;
Integer numKeysPressed=0;
Boolean postModReleased=false;
boolean keyDownSeen=false;
int frame2Display=0;
float deltaXYZ=64;
float deltaPRY=radians(30.);

/* CameraKey allows keyboard movement of the camera viewpoint
 *
 * the translate keys change the position, but do not change orientation 
 * f and F  = move Forward
 * b and B  = move backward  (also v and V because I kept hitting the wrong keys)
 *
 * The arrow keys are those keys over on the right of a full keyboard 
 * right arrow key = move to the right
 *  left arrow key = move to the left
 *    up arrow key = move up
 *  down arrow key = move down
 *
 * The twist-and-turn keys change orientation, but do not change position
 * An airplane analogy is used to convey directions.
 * r and R = Roll clockwize        (right wing down, left wing up  )
 * c and C = counterClockwize Roll (right wing up  , left wing down)
 * shift    up arrow = push the nose down
 * shift  down arrow = pull the nose up
 * shift right arrow = turn the nose to the right
 * shift  left arrow = turn the nose to the left
 */

class CameraKey {
  PVector xyz;
  PVector pry;

  CameraKey(float X,float Y,float Z,float pitch, float roll,float yaw){
    this.xyz = new PVector(X,0.-Y,Z);
    this.pry = new PVector(PI-pitch,roll,yaw);
    println(String.format("(%7.3f,%7.3f,%7.3f) (%8.3f,%8.3f,%8.3f)",xyz.x,xyz.y,xyz.z,degrees(pry.x),degrees(pry.y),degrees(pry.z)));
  }
  void set(float X,float Y,float Z,float pitch, float roll,float yaw){
    this.xyz = new PVector(X,0.-Y,Z);
    this.pry = new PVector(PI-pitch,roll,yaw);
    println(String.format("(%7.3f,%7.3f,%7.3f) (%8.3f,%8.3f,%8.3f)",xyz.x,xyz.y,xyz.z,degrees(pry.x),degrees(pry.y),degrees(pry.z)));
  }  
  void drawCrossHairs(){
  pushMatrix();
    scale(1,-1,1);
  
    float distForward=10;
    float cx= 10;  /* crosshair X factor */
    
    float fx = distForward * cx * ( cos(pry.x)*sin(pry.z)                                                  ); // forward[0]
    float fy = distForward * cx * ( -1.0*cos(pry.x)*cos(pry.z)                                             ); // forward[1]
    float fz = distForward * cx * ( sin(pry.x)                                                             ); // forward[2]
    float ux = distForward * cx * ( -1.0*sin(pry.y)*cos(pry.z)-cos(pry.y)*sin(pry.x)*sin(pry.z)            ); // up[0]
    float uy = distForward * cx * ( sin(pry.y)*sin(pry.z)-cos(pry.y)*sin(pry.x)*cos(pry.z)                 ); // up[1]
    float uz = distForward * cx * ( -1.0*(cos(pry.y)*cos(pry.x))                                           ); // up[2] 
    float rx = distForward * cx * ( cos(pry.z) * cos(pry.y)  + sin(pry.z) * sin(pry.x) * sin(pry.y)        ); // right[0]
    float ry = distForward * cx * ( -1.0*(-sin(pry.z) * cos(pry.y) + cos(pry.z) * sin(pry.x) * sin(pry.y)) ); // right[1]
    float rz = distForward * cx * (  cos(pry.x) * sin(pry.y)                                               ); // right[2]
    
    stroke(0);
    line(
      xyz.x+fx,
      xyz.y+fy,
      xyz.z+fz,
      xyz.x+fx+rx,
      xyz.y+fy+ry,
      xyz.z+fz+rz
    );
    //println(String.format("right (%9.3f,%9.3f,%9.3f) (%9.3f,%9.3f,%9.3f)",  
    //  xyz.x+fx,
    //  xyz.y+fy,
    //  xyz.z+fz,
    //  xyz.x+fx+rx,
    //  xyz.y+fy+ry,
    //  xyz.z+fz+rz
    //))  ;
    stroke(1,0,0);
    line(
      xyz.x+fx,
      xyz.y+fy,
      xyz.z+fz,
      xyz.x+fx+ux,
      xyz.y+fy+uy,
      xyz.z+fz+uz
    );
  popMatrix();
}
  
  /* start each of these with right hand,  index finger away.   thumb up.    
   * pitch is tilt index finger down,                   phi    circle with vertical stripe 
   * roll is tilt thumb to left                         psi    trident  
   * yaw is pivot index finger toward the left          theta  circle with horizontal stripe
   */
  void setFromPRY(float pitch,float roll, float yaw){
    pry.set(pitch,roll,yaw);
    this.set(true);
  }
void set(Boolean say){
    camera(xyz.x,xyz.y,xyz.z,    // at
           xyz.x + cos(pry.x)*sin(pry.z)  ,xyz.y + cos(pry.x)*cos(pry.z), xyz.z + sin(pry.x),   //at + forward
           -1.0*sin(pry.y)*cos(pry.z)-cos(pry.y)*sin(pry.x)*sin(pry.z),   sin(pry.y)*sin(pry.z)-cos(pry.y)*sin(pry.x)*cos(pry.z),  cos(pry.y)*cos(pry.x) // up
          );          
    if(say)say();
    // drawCrossHairs();
  }
  void say(){
    //    println(String.format("CameraKey ck = new CameraKey(%9.3f,%9.3f,%9.3f,    radians(%8.3f),   radians(%8.3f),   radians(%8.3f));",
    println(String.format("ck.set(%9.3f,%9.3f,%9.3f,    radians(%8.3f),   radians(%8.3f),   radians(%8.3f));",
      xyz.x,
      -1.0*xyz.y,
      xyz.z,
      degrees(PI-pry.x),
      degrees(pry.y),
      degrees(pry.z)   
   ));      
  }  
  void say1(){
    println(String.format("(%9.3f,%9.3f,%9.3f)  %8.3f (%8.3f,%8.3f,%8.3f) (%6.3f,%6.3f,%6.3f) (%6.3f,%6.3f,%6.3f) (%6.3f,%6.3f,%6.3f)",
      xyz.x,
      -1.0*xyz.y,
      xyz.z,
      degrees(pry.x),
      degrees(PI-pry.x),
      degrees(pry.y),
      degrees(pry.z),
      cos(pry.x)*sin(pry.z),      // forward[0]
      -1.0*cos(pry.x)*cos(pry.z), // forward[1]
      sin(pry.x),                 // forward[2]
      -1.0*sin(pry.y)*cos(pry.z)-cos(pry.y)*sin(pry.x)*sin(pry.z), // up[0]
      sin(pry.y)*sin(pry.z)-cos(pry.y)*sin(pry.x)*cos(pry.z),      // up[1]
      -1.0*(cos(pry.y)*cos(pry.x)),                                // up[2] 
      cos(pry.z) * cos(pry.y)  + sin(pry.z) * sin(pry.x) * sin(pry.y),        // right[0]
      -1.0*(-sin(pry.z) * cos(pry.y) + cos(pry.z) * sin(pry.x) * sin(pry.y)), // right[1]
       cos(pry.x) * sin(pry.y)                                                // right[2]
   ));      
  }  
  void sayPure(){
    println(String.format("(%9.3f,%9.3f,%9.3f) (%8.3f,%8.3f,%8.3f) (%6.3f,%6.3f,%6.3f) (%6.3f,%6.3f,%6.3f) (%6.3f,%6.3f,%6.3f)",
      xyz.x,
      xyz.y,
      xyz.z,
      degrees(pry.x),
      degrees(pry.y),
      degrees(pry.z),
      cos(pry.x)*sin(pry.z),  // forward[0]
      cos(pry.x)*cos(pry.z),  // forward[1]
      sin(pry.x),             // forward[2]
      -1.0*sin(pry.y)*cos(pry.z)-cos(pry.y)*sin(pry.x)*sin(pry.z), // up[0]
      sin(pry.y)*sin(pry.z)-cos(pry.y)*sin(pry.x)*cos(pry.z),      // up[1]
      cos(pry.y)*cos(pry.x),                                       // up[2] 
      cos(pry.z) * cos(pry.y)  + sin(pry.z) * sin(pry.x) * sin(pry.y), // right[0]
      -sin(pry.z) * cos(pry.y) + cos(pry.z) * sin(pry.x) * sin(pry.y), // right[1]
       cos(pry.x) * sin(pry.y)                                         // right[2]
   ));      
  }  
  //void sayV2(){
  //    println(String.format("(%9.3f,%9.3f,%9.3f) (%9.3f,%9.3f,%9.3f) (%6.3f,%6.3f,%6.3f) (%8.3f,%8.3f,%8.3f) (%6.3f,%6.3f,%6.3f) (%6.3f,%6.3f,%6.3f)",
  //      xyz.x,
  //      xyz.y,
  //      xyz.z,
  //      xyz.x + cos(pry.x)*sin(pry.z)  ,xyz.y + cos(pry.x)*cos(pry.z), xyz.z + sin(pry.x), // toward
  //      -1.0*sin(pry.y)*cos(pry.z)-cos(pry.y)*sin(pry.x)*sin(pry.z), // up[0]
  //      sin(pry.y)*sin(pry.z)-cos(pry.y)*sin(pry.x)*cos(pry.z),      // up[1]
  //      cos(pry.y)*cos(pry.x),                                       // up[2] 
  //      pry.x*rad2deg,
  //      pry.y*rad2deg,
  //      pry.z*rad2deg,
  //      cos(pry.x)*sin(pry.z),  // forward[0]
  //      cos(pry.x)*cos(pry.z),  // forward[1]
  //      sin(pry.x),             // forward[2]
  //      -1.0*sin(pry.y)*cos(pry.z)-cos(pry.y)*sin(pry.x)*sin(pry.z), // up[0]
  //      sin(pry.y)*sin(pry.z)-cos(pry.y)*sin(pry.x)*cos(pry.z),      // up[1]
  //      cos(pry.y)*cos(pry.x),                                       // up[2] 
  //      cos(pry.z) * cos(pry.y)  + sin(pry.z) * sin(pry.x) * sin(pry.y), // right[0]
  //      -sin(pry.z) * cos(pry.y) + cos(pry.z) * sin(pry.x) * sin(pry.y), // right[1]
  //       cos(pry.x) * sin(pry.y)                                         // right[2]
  //   ));      
  //}  
  void moveForward(){
     PVector d = new PVector(cos(pry.x)*sin(pry.z),cos(pry.x)*cos(pry.z), sin(pry.x));
     d.mult(deltaXYZ/frameRate);
     xyz.add(d.x,d.y,d.z);
     say();
  }
  void moveBackward(){
     PVector d = new PVector(cos(pry.x)*sin(pry.z),cos(pry.x)*cos(pry.z), sin(pry.x));
     d.mult(deltaXYZ/frameRate);
     xyz.sub(d.x,d.y,d.z);
     say();
  }
  void moveUp(){
     PVector d = new PVector(
        -1.0*sin(pry.y)*cos(pry.z)-cos(pry.y)*sin(pry.x)*sin(pry.z),  // up[0]
        sin(pry.y)*sin(pry.z)-cos(pry.y)*sin(pry.x)*cos(pry.z),       // up[1]
        cos(pry.y)*cos(pry.x)                                         // up[2] 
        );
     d.mult(deltaXYZ/frameRate);        
     xyz.sub(d.x,d.y,d.z);
     say();
  }
  void moveDown(){
     PVector d = new PVector(
        -1.0*sin(pry.y)*cos(pry.z)-cos(pry.y)*sin(pry.x)*sin(pry.z),  // up[0]
        sin(pry.y)*sin(pry.z)-cos(pry.y)*sin(pry.x)*cos(pry.z),       // up[1]
        cos(pry.y)*cos(pry.x)                                         // up[2] ){
     );
     d.mult(deltaXYZ/frameRate);     
     xyz.add(d.x,d.y,d.z);
     say();
  }  
  
  void moveRight(){
     PVector d = new PVector(
        cos(pry.z) * cos(pry.y)  + sin(pry.z) * sin(pry.x) * sin(pry.y),
        -sin(pry.z) * cos(pry.y) + cos(pry.z) * sin(pry.x) * sin(pry.y),
         cos(pry.x) * sin(pry.y)
       );
     d.mult(deltaXYZ/frameRate);       
     xyz.add(d.x,d.y,d.z);
     say();
  }
  void moveLeft(){
     PVector d = new PVector(
        cos(pry.z) * cos(pry.y)  + sin(pry.z) * sin(pry.x) * sin(pry.y),
        -sin(pry.z) * cos(pry.y) + cos(pry.z) * sin(pry.x) * sin(pry.y),
         cos(pry.x) * sin(pry.y)
       );
     d.mult(deltaXYZ/frameRate);       
     xyz.sub(d.x,d.y,d.z);
     say();
  }  
  void roll(){
    //println("roll");
    pry.y+=deltaPRY/frameRate;
    say();    
  }
  void counterRoll(){
    pry.y-=deltaPRY/frameRate;    
    say();
  }  
  void pitchNoseDown(){
    //println("pitchNoseDown");
    pry.x+=deltaPRY/frameRate;
    //if((3.*PI/2.)<pry.x) {
    //  println(String.format("passingd through pitch singularity at internal 270, external -90.  pry.x=%8.3f",pry.x*rad2deg));
    //  pry.x=(3.*PI/2.)-(pry.x-(3.*PI/2.));
    //  pry.y+=PI;
    //  pry.z+=PI;      
    //}  
    say();
  }
  void pitchNoseUp(){
    //println("pitchNoseUp");
    pry.x-=deltaPRY/frameRate;
    //if((PI/-2.)>pry.x)pry.x+=(2.*PI);
    say();
  }
  void yawRight(){
    pry.z+=deltaPRY/frameRate;
    say();
  }
  void yawLeft(){
    pry.z-=deltaPRY/frameRate;
    say();
  }
  void feedKeys(){
   if(  (true==keyPressed)
       &&(  (0==numModPressed)
          ||(false==postModReleased)
         ) 
      ){
      if ('f' == key || 'F' == key) {
        ck.moveForward();
      } else 
      if (('b' == key)||('v' == key)||('B' == key)||('V' == key)){
        ck.moveBackward();
      } else
      if ('r' == key||'R' == key) {
        ck.roll();
      } else 
      if ('c' == key||'C' == key) {
        ck.counterRoll();
      } else 
      if (key == CODED) { 
        if(shiftPressed){
          if (UP    == keyCode) {
            ck.pitchNoseDown();
          } else 
          if (DOWN  == keyCode) {
            ck.pitchNoseUp();
          } else 
          if (LEFT  == keyCode) {
            ck.yawRight();
          } else 
          if (RIGHT == keyCode) {
            ck.yawLeft();
          }  
        } else {
          if (UP    == keyCode) {
            ck.moveUp();
          } else 
          if (DOWN  == keyCode) {
            ck.moveDown();
          } else 
          if (LEFT  == keyCode) {
            ck.moveLeft();
          } else 
          if (RIGHT == keyCode) {
            ck.moveRight();
          }  
        } 
      }
    }
    //if(  (true==keyPressed)
    //   &&(true==postModReleased)
    //  ){
    //  println("pre-empted ongoing shifting of pry");
    //}
  }  
}
void keyPressed() {
  //println("key pressed ="+key+" "+((CODED==key)?"CODED  ":"regular")+" keyCode="+keyCode+" incomming numModPressed="+numModPressed);
  if (16==keyCode) {
    shiftPressed=true;
    postModReleased=false;
    numModPressed+=1;
  } else
  if (17==keyCode) {
    ctrlPressed=true;
    postModReleased=false;
    numModPressed+=1;
  } else
  if (18==keyCode) {
    altPressed=true;
    postModReleased=false;
    numModPressed+=1;
  } 
  if(0<numModPressed){
    if(  (37 == keyCode)
       ||(38 == keyCode)
       ||(39 == keyCode)
       ||(40 == keyCode)
      )postModReleased=false;       
  }
  if(0==numKeysPressed){
    if(97==keyCode){
      deltaXYZ/=2.;
    } else
    if(98==keyCode){
      deltaXYZ*=2.;
    } else
    if(99==keyCode){
      deltaPRY/=2.;
    } else
    if(100==keyCode){
      deltaPRY*=2.;
    }    
  }  
  numKeysPressed+=1;
  //println("keyPressed  outGoing numModPressed="+numModPressed +" postModReleased="+(postModReleased?"true ":"false"));
}
void keyReleased() {
  //println("key released="+key+" "+((CODED==key)?"CODED  ":"regular")+" keyCode="+keyCode+" incomming numModPressed="+numModPressed);
  if (16==keyCode) {
    shiftPressed=false;
    numModPressed-=1;
  } else
  if (17==keyCode) {
    ctrlPressed=false;
     numModPressed-=1;
  } else
  if (18==keyCode) {
    altPressed=false;
    numModPressed-=1;
  }
  if(0<numModPressed){
    if(  (37 == keyCode)
       ||(38 == keyCode)
       ||(39 == keyCode)
       ||(40 == keyCode)
      )postModReleased=true;       
  }
  numKeysPressed-=1;
  //println("keyReleased outGoing numModPressed="+numModPressed +" postModReleased="+(postModReleased?" true ":" false"));    
}
