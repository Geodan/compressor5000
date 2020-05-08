#!/bin/bash
cd /tiles
for entry in *.b3dm
do
  echo "$entry"
  b3dm unpack "$entry"
  filename="${entry%.*}"
  gltf-pipeline -i "$filename".glb -o "$filename".glb -d -b
  b3dm pack "$filename".glb
  rm "$filename".glb
done
