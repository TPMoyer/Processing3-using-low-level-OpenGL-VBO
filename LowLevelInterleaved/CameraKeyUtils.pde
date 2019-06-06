/* used by the production version to parse keys to the app to control stuff */
void feedKeysP(){
 //println("cme@feedKeysP() keyPressed="+keyPressed);
 if(true==keyPressed){
    println("key==CODED is "+(key==CODED)+" keyCode="+keyCode+" key="+key);
    if(false==keyDownSeen){
      if (key == CODED) { 
        if (LEFT  == keyCode) {
          keyDownSeen=true;
          frame2Display-=1;
          if(-1==frame2Display)frame2Display=11;
        } else 
        if (RIGHT == keyCode) {
          frame2Display+=1;
          keyDownSeen=true;
        }
      } else {
         println("keyDownSeen=true"); 
      }
    }
  }
  if(false==keyPressed)keyDownSeen=false;
}
/* used in 2D apps to allow Y ordinate to increase up */
void yText(String s,float x,float y){
  fill(0);
  noStroke();
  pushMatrix();
    scale(1,-1);
    text(s,x,-y);
  popMatrix();
}
/* used in 2D apps to allow Y ordinate to increase up */
void yTextNoColor(String s,float x,float y){
  pushMatrix();
    scale(1,-1);
    text(s,x,-y);
  popMatrix();
}  
/* used in 2D apps to allow Y ordinate to increase up */
void yText(String s,float x,float y,float x2, float y2){
  pushMatrix();
    scale(1,-1);
    text(s,x,height-y,x2,height-y2);
  popMatrix();
} 
/* works in default 2D and Y ordinate increases up apps */
void fullGrid(){
  strokeWeight(1);
  stroke(.9);
  /* vertical lines on 10 pixel spacing */
  for(int ii=1;ii<width/10+1;ii++){
     if(0!=ii%10)line(ii*10,0,ii*10,height);  
  }
  /* horizontal lines on 100 pixel spacing */
  for(int ii=1;ii<height/10+1;ii++){
     if(0!=ii%10)line(0,ii*10,width,ii*10);
  }
  stroke(.75);
  //dash.pattern(10, 3, 84, 3);
  /* horizontal lines on 100 pixel spacing */
  for(int ii=1;ii<width/100+1;ii++){
   //dash.line(ii*100,-5,ii*100,height+10);
   line(ii*100,-5,ii*100,height+10);
  }
  /* vertical lines on 100 pixel spacing */
  for(int ii=1;ii<height/100+1;ii++){
    //dash.line(-5,ii*100,width+10,ii*100);
    line(-5,ii*100,width+10,ii*100);
  }
} 
/* works in default 2D and Y ordinate increases up apps */
void fullGridBlack(){
  strokeWeight(1);
  float sv=.25;
  //sv=xMod(0,1);
  stroke(sv);
  /* vertical lines on 10 pixel spacing */
  for(int ii=1;ii<width/10+1;ii++){
     if(0!=ii%10)line(ii*10,0,ii*10,height);  
  }
  /* horizontal lines on 100 pixel spacing */
  for(int ii=1;ii<height/10+1;ii++){
     if(0!=ii%10)line(0,ii*10,width,ii*10);
  }
  sv=.34;
  //sv=xMod(0,1);
  stroke(sv);
  //dash.pattern(10, 3, 84, 3);
  /* horizontal lines on 100 pixel spacing */
  for(int ii=1;ii<width/100+1;ii++){
   //dash.line(ii*100,-5,ii*100,height+10);
   line(ii*100,-5,ii*100,height+10);
  }
  /* vertical lines on 100 pixel spacing */
  for(int ii=1;ii<height/100+1;ii++){
    //dash.line(-5,ii*100,width+10,ii*100);
    line(-5,ii*100,width+10,ii*100);
  }
} 
void arrayOfAlternatingCubesAndSpheres(){
  noStroke();
  float xLimit=50;
  int yLimit=11;
  int spacing=10;
  int centerOnMaterial=12;
  Boolean pingPong=true;
  for(int ii=0;ii<xLimit;ii++){
   //ggm.setMaterial(ii);    
    for(int jj=0;jj<yLimit;jj++){
      pushMatrix();    
      //translate(((xLimit/2)*-1.0*spacing)+ii*spacing,((yLimit/2)*-1.0*spacing)+jj*spacing, 0);
      translate(-10*centerOnMaterial+ii*spacing,((yLimit/2)*-1.0*spacing)+jj*spacing, 0);
      if(pingPong){
        pushMatrix();
          scale(1,-1,1);
          sphere(2.5);
        popMatrix();
      }else {
        pushMatrix();
          scale(1,-1,1);
          box(5);
        popMatrix();
      }
      pingPong=!pingPong;
      popMatrix();
    }
  }  
}

void longSentance(){
  //textFont(font0);
  pushMatrix();
    fill(0);
    //rotateX(PI/2);
    rotateZ(PI/2);
    rotateX(PI/2);
    pushMatrix();
      scale(1,-1,1);
      text("Just the place for a snark the bellman cried as he landed his crew with care, supporting each man on the top of the tide by a finger entwined in his hair.",0.,-60.,0.);
    popMatrix();
  popMatrix();
}    
void pointLightAndEmissiveMarker(){
  pointLight(1.,1.,1.,-140+mouseX,-100*((mouseY/(height/2.))-1),40); 
  pushMatrix();
    translate(-140+mouseX,-100*((mouseY/(height/2.))-1),40);
    emissive(.8,.8,0.);
    stroke(0.0,0.0,1.0);
    box(5);
    emissive(0.0);
  popMatrix();  
}  

float thetaMod(){
  float min=0;
  float max=TWO_PI;
  float theta=min+(max-min)*mouseX/width;
  println(String.format("theta=%6.3f degrees(theta)=%8.3f min=%4.0f max=%4.0f mouseX=%d width=%d",theta,degrees(theta),min,max,mouseX,width));
  return(min+(max-min)*mouseX/width);
}
float xMod(){
  float min=0;
  float max=width;
  float x=min+(max-min)*mouseX/width;
  println(String.format("x=%5.0f      min=%4.0f max=%4.0f mouseX=%4d width=%d x=%9.3f",x,min,max,mouseX,width,x));
  return(x);
}
float yMod(){
  float min=0;
  float max=height;
  float y=min+(max-min)*(height-mouseY)/height;
  println(String.format("y=%5.0f      min=%4.0f max=%4.0f mouseX=%4d width=%d y=%9.3f",y,min,max,mouseX,width,y));
  return(y);
}
float xMod(float min, float max){
  float x=min+(max-min)*mouseX/width;
  println(String.format("x=%5.0f      min=%4.0f max=%4.0f mouseX=%4d width=%d x=%9.3f",x,min,max,mouseX,width,x));
  return(x);
}
float yMod(float min,float max){
  float y=min+(max-min)*(height-mouseY)/height;
  println(String.format("y=%5.0f      min=%4.0f max=%4.0f mouseX=%4d width=%d y=%9.3f",y,min,max,mouseX,width,y));
  return(y);
}
float thetaMod(float min,float max){
  //float theta=min+(max-min)*mouseX/width;
  float theta=min+(max-min)*mouseY/height;
  println(String.format("theta=%6.3f degrees(theta)=%8.3f min=%4.0f max=%4.0f mouseX=%d width=%d",theta,degrees(theta),min,max,mouseX,width));
  return(theta);
}
