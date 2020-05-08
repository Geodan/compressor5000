# compressor5000

Compresses 3D tiles (*.b3dm) almost 5000 times.

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
