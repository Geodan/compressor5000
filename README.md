# compressor5000

Compresses 3D tiles (*.b3dm) almost 5000 times using Google Draco (https://github.com/google/draco).

This tool does the following:

- Loops through all b3dm files in subdirectory 'tiles', for each file do:

    - Unpack b3dm to glb file (using b3dm unpack)

    - Run Draco compression (using gltf-pipeline)

    - Pack glb to b3dm file (using b3dm pack)

    - Remove the temporary glb file

Remarks:

- Input b3dm's will be overwritten

- B3dm batch information will be lost

Docker 

Build:

```
$ docker build -t bertt/compressor5000 .
```

Run from folder where tileset.json is located.

On Windows:

```
$ docker run -v D:\dev\github.com\geodan\pg2b3dm\sample_data\delaware\mapbox\test\tiles:/tiles bertt/compressor5000
```

On Linux:

```
$ docker run -v $(pwd)/tiles:/tiles bertt/compressor5000
```
