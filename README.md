# Processing3 using low level OpenGL VBO

Example sketch demo'ing how to use the low level OpenGL Visual Buffer Object (VBO) technique.   This allows faster rendering and is appropriate for large datasets.   The technique works by having the data input and/or calculation occur only once.  The aspects of the geometry (vertexes, normals, colors, texture map locations) are loaded into the GPU memory as a VBO.   The rendering speed results from not needing to move the data from the CPU memory to the GPU for every draw refresh.   The GPU can access it's own memory with parallel processing, so having the data reside in the GPU is faster than feeding it from the CPU.

The sketch also includes the ability to move the camera viewpoint using keyboard inputs.
