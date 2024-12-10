#!/bin/bash
set -eux

echo ">>> Start of post install script <<<"

DISPLAY_EXPORT="export DISPLAY=:0"

if [[ ! -d "/workspace/GO-SLAM" ]]; then
  echo "Cloning GO-SLAM repository..."
  
  cd /workspace

  git clone --recursive https://github.com/iis-esslingen/GO-SLAM.git

  cd /workspace/GO-SLAM

  pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch
  pip install evo --upgrade --no-binary evo

  python setup.py install
fi

echo ">>> End of post install script <<<" 