#!/bin/bash
cd tiles
for entry in *.b3dm
do
  echo "$entry"
  b3dm unpack -i "$entry" -f
  filename="${entry%.*}"
  gltf-pipeline -i "$filename".glb -o "$filename".glb -d -b
  b3dm pack -i "$filename".glb -f
  rm "$filename".glb
  rm "$filename".batch
done
