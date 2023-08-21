#!/bin/bash

jobs=5

cd tiles

compress()
{
  entry=$1
  echo "$entry"
  b3dm unpack -i "$entry" -f
  filename="${entry%.*}"
  gltf-pipeline -i "$filename".glb -o "$filename".glb -d -b
  b3dm pack -i "$filename".glb -f
  rm "$filename".glb
  if [ -f "$filename".batchtable.json ]; then
    rm "$filename".batchtable.json
  fi
  if [ -f "$filename".featuretable.json ]; then
    rm "$filename".featuretable.json
  fi
}

export -f compress


find ./ -maxdepth 1 -type f -iname '*.b3dm' | parallel --bar -j ${jobs} compress