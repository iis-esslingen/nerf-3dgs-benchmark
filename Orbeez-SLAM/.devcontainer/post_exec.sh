#!/bin/bash
set -eux

echo ">>> Start of post install script <<<"

DISPLAY_EXPORT="export DISPLAY=:0"

if [[ ! -d "/workspace/Orbeez-SLAM" ]]; then
  echo "Cloning Orbeez-SLAM repository..."
  
  cd /workspace

  git clone --recursive https://github.com/iis-esslingen/Orbeez-SLAM.git

  cd /workspace/Orbeez-SLAM

  git submodule update --init --recursive

  cmake -B build -DCMAKE_BUILD_TYPE=Release .
  cmake --build build --parallel $(nproc --all)

  cd Vocabulary
  tar zxf ORBvoc.txt.tar.gz
fi

echo ">>> End of post install script <<<" 