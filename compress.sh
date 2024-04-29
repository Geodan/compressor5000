#!/bin/bash

jobs=5

cd tiles

compressB3dm()
{
  entry=$1
  echo "$entry"
  b3dm unpack -i "$entry" -f
  filename="${entry%.*}"
  gltf-pipeline -i "$filename".glb -o "$filename".glb -d -b --draco.quantizePositionBits 15
  b3dm pack -i "$filename".glb -f
  rm "$filename".glb
  if [ -f "$filename".batchtable.json ]; then
    rm "$filename".batchtable.json
  fi
  if [ -f "$filename".featuretable.json ]; then
    rm "$filename".featuretable.json
  fi
}

compressGlb()
{
  entry=$1
  echo "$entry"
  gltf-pipeline -i "$entry" -o "$entry" -d -b
}

export -f compressB3dm
export -f compressGlb

echo Compressor5000 running with $jobs jobs
echo "Find *.b3dm files and compress them..."
find ./ -maxdepth 1 -type f -iname '*.b3dm' | parallel --bar -j ${jobs} compressB3dm
echo "Find *.glb files and compress them..."
find ./ -maxdepth 1 -type f -iname '*.glb' | parallel --bar -j ${jobs} compressGlb
