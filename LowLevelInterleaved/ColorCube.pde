void setVisualObjectColorCube() {
  /* 0 north white    snow
   * 1 south green    jungle
   * 2 east  yellow   sunrise
   * 3 west  blue     pacific
   * 4 up    cyan     sky
   * 5 down  red      magma
   */
  float size = 100.; /* cube would go from -size/2 to +size/2, and is exploded to twice that */
  int base=0;
  /* NS */
  for(int ii=0;ii<2;ii++){
    attribs[(48*base)+ 0]=size * -0.5;
    attribs[(48*base)+ 1]=size * ((0==ii)?1:-1);
    attribs[(48*base)+ 2]=size * -0.5;
    
    attribs[(48*base)+ 8]=size * -0.5;
    attribs[(48*base)+ 9]=size * ((0==ii)?1:-1);
    attribs[(48*base)+10]=size *  0.5;
    
    attribs[(48*base)+16]=size *  0.5;
    attribs[(48*base)+17]=size * ((0==ii)?1:-1);
    attribs[(48*base)+18]=size *  0.5;

    for(int jj=0;jj<3;jj++)attribs[(48*base)+3+(8*jj)]=1;
    
    
    attribs[(48*base)+24]=size *  0.5;
    attribs[(48*base)+25]=size * ((0==ii)?1:-1);
    attribs[(48*base)+26]=size *  0.5;
                                            
    attribs[(48*base)+32]=size *  0.5;
    attribs[(48*base)+33]=size * ((0==ii)?1:-1);
    attribs[(48*base)+34]=size * -0.5;
                                                
    attribs[(48*base)+40]=size * -0.5;
    attribs[(48*base)+41]=size * ((0==ii)?1:-1);
    attribs[(48*base)+42]=size * -0.5;
                                      
    for(int jj=0;jj<3;jj++)attribs[(48*base)+27+(8*jj)]=1;
    for(int jj=0;jj<6;jj++){
      attribs[(48*base) + (8*jj) +  4]=((0==ii)?1:0);
      attribs[(48*base) + (8*jj) +  5]=1.0;
      attribs[(48*base) + (8*jj) +  6]=((0==ii)?1:0);
      attribs[(48*base) + (8*jj) +  7]=1.0;
    }
    base+=1;
  }
  //println("NS");

  /* EW */
  for(int ii=0;ii<2;ii++){
    attribs[(48*base)+ 0]=size * ((0==ii)?1:-1);
    attribs[(48*base)+ 1]=size * -0.5;
    attribs[(48*base)+ 2]=size * -0.5;
    
    attribs[(48*base)+ 8]=size * ((0==ii)?1:-1);
    attribs[(48*base)+ 9]=size * -0.5;
    attribs[(48*base)+10]=size *  0.5;
    
    attribs[(48*base)+16]=size * ((0==ii)?1:-1);
    attribs[(48*base)+17]=size *  0.5;
    attribs[(48*base)+18]=size *  0.5;

    for(int jj=0;jj<3;jj++)attribs[(48*base)+3+(8*jj)]=1;
    

    attribs[(48*base)+24]=size * ((0==ii)?1:-1);
    attribs[(48*base)+25]=size *  0.5;
    attribs[(48*base)+26]=size *  0.5;
                                      
    attribs[(48*base)+32]=size * ((0==ii)?1:-1);
    attribs[(48*base)+33]=size *  0.5;
    attribs[(48*base)+34]=size * -0.5;
                                        
    attribs[(48*base)+40]=size * ((0==ii)?1:-1);
    attribs[(48*base)+41]=size * -0.5;
    attribs[(48*base)+42]=size * -0.5;
                          
    for(int jj=0;jj<3;jj++)attribs[(48*base)+27+(8*jj)]=1;
    for(int jj=0;jj<6;jj++){
      attribs[(48*base) + (8*jj) +  4]=((0==ii)?1:0);
      attribs[(48*base) + (8*jj) +  5]=((0==ii)?1:0);
      attribs[(48*base) + (8*jj) +  6]=((0==ii)?0:1);
      attribs[(48*base) + (8*jj) +  7]=1.0;
    }
    base+=1;   
  }  
  //println("EW");

  /* UD */
  for(int ii=0;ii<2;ii++){
    
    attribs[(48*base)+ 0]=size * -0.5;
    attribs[(48*base)+ 1]=size * -0.5;
    attribs[(48*base)+ 2]=size * ((0==ii)?1:-1);
    
    attribs[(48*base)+ 8]=size * -0.5;
    attribs[(48*base)+ 9]=size *  0.5;
    attribs[(48*base)+10]=size * ((0==ii)?1:-1);
    
    attribs[(48*base)+16]=size *  0.5;
    attribs[(48*base)+17]=size *  0.5;
    attribs[(48*base)+18]=size * ((0==ii)?1:-1);

    for(int jj=0;jj<3;jj++)attribs[(48*base)+3+(8*jj)]=1;
    


    attribs[(48*base)+24]=size *  0.5;
    attribs[(48*base)+25]=size *  0.5;
    attribs[(48*base)+26]=size * ((0==ii)?1:-1);
                                    
    attribs[(48*base)+32]=size *  0.5;
    attribs[(48*base)+33]=size * -0.5;
    attribs[(48*base)+34]=size * ((0==ii)?1:-1);
                                                      
    attribs[(48*base)+40]=size * -0.5;
    attribs[(48*base)+41]=size * -0.5;
    attribs[(48*base)+42]=size * ((0==ii)?1:-1);


    for(int jj=0;jj<3;jj++)attribs[(48*base)+27+(8*jj)]=1;
    for(int jj=0;jj<6;jj++){
      attribs[(48*base) + (8*jj) +  4]=((0==ii)?0:1);
      attribs[(48*base) + (8*jj) +  5]=((0==ii)?1:0);
      attribs[(48*base) + (8*jj) +  6]=((0==ii)?1:0);
      attribs[(48*base) + (8*jj) +  7]=1.0;
    }
    base+=1;   
  }  
  //for(int ii=0;ii<12;ii++){
  //  println(String.format("(%4.0f,%4.0f,%4.0f,%1.0f) (%4.0f,%4.0f,%4.0f,%1.0f) (%4.0f,%4.0f,%4.0f,%1.0f) (%1.0f,%1.0f,%1.0f,%1.0f) (%1.0f,%1.0f,%1.0f,%1.0f) (%1.0f,%1.0f,%1.0f,%1.0f)",
  //      attribs[(ii*24)+ 0],
  //      attribs[(ii*24)+ 1],
  //      attribs[(ii*24)+ 2],
  //      attribs[(ii*24)+ 3],
  
  //      attribs[(ii*24)+ 8],
  //      attribs[(ii*24)+ 9],
  //      attribs[(ii*24)+10],
  //      attribs[(ii*24)+11],
  
  //      attribs[(ii*24)+16],
  //      attribs[(ii*24)+17],
  //      attribs[(ii*24)+18],
  //      attribs[(ii*24)+19],
  
  //      attribs[(ii*24)+ 4],
  //      attribs[(ii*24)+ 5],
  //      attribs[(ii*24)+ 6],
  //      attribs[(ii*24)+ 7],
  
  //      attribs[(ii*24)+12],
  //      attribs[(ii*24)+13],
  //      attribs[(ii*24)+14],
  //      attribs[(ii*24)+15],
  
  //      attribs[(ii*24)+20],
  //      attribs[(ii*24)+21],
  //      attribs[(ii*24)+22],
  //      attribs[(ii*24)+23]
  //    )
  //  );
  //  if(1==ii%2)println("");
  //}
  attribBuffer.rewind();
  attribBuffer.put(attribs);
  attribBuffer.rewind();
 
}
