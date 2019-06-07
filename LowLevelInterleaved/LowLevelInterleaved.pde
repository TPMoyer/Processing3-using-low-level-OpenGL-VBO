/*
  Copyright (c) 2019 Thomas P Moyer

  LowLevelInterleaved is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  LowLevelInterleaved is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with LowLevelInterleaved.  If not, see <http://www.gnu.org/licenses/>.
  
  // Draws using low-level OpenGL calls interleaving vertices and colors.
// Keyboard modification of camera position and orientation is enabled in CameraKey.pde
*/


import java.nio.*;

/* These are default 4 values per vertex and 4 values per color.
 * Performance can be enhanced somewhat in non-transparency apps by trimming the colors to 
 * 3 components and using a shader which inserts 1 as the 4'th value.
 * Anybody use the 4'th vertex value?
 */
final static int VERT_CMP_COUNT = 4; // vertex component count (x, y, z, w) -> 4
final static int CLR_CMP_COUNT = 4;  // color component count (r, g, b, a) -> 4 
final int stride = (VERT_CMP_COUNT + CLR_CMP_COUNT) * Float.BYTES;
final int vertexOffset = 0 * Float.BYTES;
final int colorOffset  = VERT_CMP_COUNT * Float.BYTES;

PGL pgl = null;
PShader sh;
float[] attribs;
FloatBuffer attribBuffer;
int vertLoc=0;
int colorLoc=0;
int attribVboId;

/* vanella  starting position of 10 units along the Z axis, looking straight down, with up as north */ 
CameraKey ck = new CameraKey(0.,0.,10.,    radians( -90.000),   radians( 0.000),   radians( 0.000)); 


public void setup() {
  size(640, 360, P3D);
  surface.setLocation(300,400);
  
  /* A set of co-ordinates which gave a revealing camera viewpoint.   
   * See the top of the CameraKey.pde for keyboard control of camera position and orientation
   * ck.set() inputs are camera X,Y,Z,Pitch,Roll,Yaw 
   */
  ck.set( -175.131, -213.554,   72.196,    radians( -20.014),   radians(   0.000),   radians( -40.012));

  /*  Loads a shader to render geometry w/out textures or lights. */
  sh = loadShader("frag.glsl", "vert.glsl");
  /* If you want a more full featured shader, copy/paste and load one of the 
   * more advanced shaders in the  /processing-master/core/src/processing/opengl/shaders directory
   * obtainable from  https://github.com/processing/processing
   */
  sh.bind();
  
  attribs = new float[24*12];
  attribBuffer = allocateDirectFloatBuffer(24*12);

  pgl = beginPGL(); /* will begin here and not endPGL untill app is closed */

  IntBuffer intBuffer = IntBuffer.allocate(1);
  pgl.genBuffers(1, intBuffer); /* will fill intBuffer with as many unique integers as arg[0] ie in this case 1 */
  attribVboId = intBuffer.get(0);


  /* the performance of these low level calls comes from 
   * reading in and/or calculating the geometry data once, 
   * pushing it to the GPU once,
   * and then using it many times.
   */
  setVisualObjectColorCube();
   /*
    BUFFER LAYOUT from setVisualObjectColorCube()

    xyzwrgbaxyzwrgbaxyzwrgba...

    |v1       |v2       |v3       |...
    |0   |4   |8   |12  |16  |20  |...
    |xyzw|rgba|xyzw|rgba|xyzw|rgba|...

    stride (values per vertex) is 8 floats
    vertex offset is 0 floats (starts at the beginning of each line)
    color offset is 4 floats (starts after vertex coords)

       |0   |4   |8
    v1 |xyzw|rgba|
    v2 |xyzw|rgba|
    v3 |xyzw|rgba|
       |...
   */
    
  // get "vertex" attribute location in the shader
  vertLoc = pgl.getAttribLocation(sh.glProgram, "vertex");
  // enable array for "vertex" attribute
  pgl.enableVertexAttribArray(vertLoc);

  // get "color" attribute location in the shader
  colorLoc = pgl.getAttribLocation(sh.glProgram, "color");
  // enable array for "color" attribute
  pgl.enableVertexAttribArray(colorLoc);
 
  // bind the Visual Buffer Object (VBO).  The VBO is a memory area on the GPU.
  pgl.bindBuffer(PGL.ARRAY_BUFFER, attribVboId);
  // once only, fill the VBO with data
  pgl.bufferData(PGL.ARRAY_BUFFER, Float.BYTES * attribs.length, attribBuffer, PGL.DYNAMIC_DRAW);

  /* leave the PGL open, but shutter the shader to allow interleaving standard 
   * Processing objects with our custom low level calls 
   */
  sh.unbind(); 
 
}

public void draw() {
  
  surface.setTitle("PGL   "+round(frameRate) + " fps "+frameCount);
  /* if any key is currently pressed, feed that directive to the methods which update my viewpoint variables */ 
  ck.feedKeys(); 
  /* set the camera viewpoint.  false== do not print the current location & orientation */
  ck.set(false);
  
  /* the default shaders called by the standard Processing shapes (box, line, sphere,...) 
   * will invoke and access shaders with their needed attributes like lights 
   */
  lights();
  strokeWeight(5);  

  /* some of the standard processing calls are compatible with use of custom shaders, 
   * some do not work as expected
   */
  /* fill(1);   Causes all the boxes to be black */
  background(.5);  /* has no effect */

  /* these boxes are rendered using the effects of the lights() */
  box(500.,  20.,  20.);
  box(  20.,500.,  20.);
  box(  20.,  20.,500.);
  
  rotate(frameCount * 0.01f,0.,0.,1.);
  
  /* this makes the shader update it's uniforms ie use the current transform matrix */
  sh.bind();   
    /* The default shaders called by the standard Procesisng shapes leave these pgl variable set to their own stuff.
     * It is likely that they did not overwrite the data we stuffed into the GPU VBO in setup(). 
     * At a minimum, bind the ARRAY_BUFFER to our data and set the start and strides for our varyings
     */
    pgl.bindBuffer(PGL.ARRAY_BUFFER, attribVboId);  
    pgl.vertexAttribPointer(vertLoc, VERT_CMP_COUNT, PGL.FLOAT, false, stride, vertexOffset);
    pgl.vertexAttribPointer(colorLoc, CLR_CMP_COUNT, PGL.FLOAT, false, stride, colorOffset);
    
    pgl.drawArrays(PGL.TRIANGLES, 0, 36);
  sh.unbind();

}


FloatBuffer allocateDirectFloatBuffer(int n) {
  return ByteBuffer.allocateDirect(n * Float.BYTES).order(ByteOrder.nativeOrder()).asFloatBuffer();
}
