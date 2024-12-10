#!/bin/bash
set -eux

echo ">>> Start of post install script <<<"

DISPLAY_EXPORT="export DISPLAY=:0"

if [[ ! -d "/workspace/Photo-SLAM" ]]; then
  echo "Cloning Photo-SLAM repository..."
  
  cd /workspace

  git clone --recursive https://github.com/iis-esslingen/Photo-SLAM.git

  cd /workspace/Photo-SLAM

  chmod +x ./build.sh
  ./build.sh
fi

echo ">>> End of post install script <<<" 