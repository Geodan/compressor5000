#!/bin/bash

outlines="false"
jobs=5
compressionLevel=7

cd tiles

print_usage()
{
   # Display Help
   echo Syntax: '[o|h]'
   echo options:
   echo o     outlines - default $outlines
   echo h     Print this help
   echo
}

# Parse input arguments (flags)
while getopts o:h flag
do
    case $flag in
        o) outlines=$OPTARG;;
        h) print_usage; exit 0;;
    esac
done

echo Outlines: $outlines

if($outlines)
then
  compressionLevel=0
fi

compressB3dm()
{
  entry=$1
  echo "$entry"
  b3dm unpack -i "$entry" -f
  filename="${entry%.*}"
  gltf-pipeline -i "$filename".glb -o "$filename".glb -d -b --draco.quantizePositionBits 15 --draco.compressionLevel "$compressionLevel"
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
  gltf-pipeline -i "$entry" -o "$entry" -d -b --draco.quantizePositionBits 15 --draco.compressionLevel "$compressionLevel"
}

export -f compressB3dm
export -f compressGlb

echo Compressor5000 running with $jobs jobs
echo "Find *.b3dm files and compress them..."
find ./ -maxdepth 1 -type f -iname '*.b3dm' | parallel --bar -j ${jobs} compressB3dm
echo "Find *.glb files and compress them..."
find ./ -maxdepth 1 -type f -iname '*.glb' | parallel --bar -j ${jobs} compressGlb
