# compressor5000

Compresses 3D tiles (*.b3dm) almost 5000 times using Google Draco (https://github.com/google/draco).

This tool does the following:

- Loops through all b3dm files in currrent directory, for each file do:

    - Unpack b3dm to glb file + batch table file (using b3dm unpack)

    - Run Draco compression (using gltf-pipeline)

    - Pack glb to b3dm file (using b3dm pack)

    - Remove the temporary glb file and batch file

## Remarks

- Input b3dm's will be overwritten;

- Running this tool multiple times will give an error.

## Docker 

### Build

```
$ docker build -t bertt/compressor5000 .
```

### Run

Run from folder where b3dms are located.

On Windows:

```
$ docker run -v D:\dev\github.com\geodan\pg2b3dm\sample_data\delaware\mapbox\test\tiles:/tiles -it bertt/compressor5000
```

On Linux:

```
$ docker run -v $(pwd):/tiles -it bertt/compressor5000
```
