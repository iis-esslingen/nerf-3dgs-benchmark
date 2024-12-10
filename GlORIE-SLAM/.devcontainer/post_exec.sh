#!/bin/bash
set -eux

echo ">>> Start of post install script <<<"

DISPLAY_EXPORT="export DISPLAY=:0"

if [[ ! -d "/workspace/GlORIE-SLAM" ]]; then
  echo "Cloning GlORIE-SLAM repository..."
  
  cd /workspace

  git clone --recursive https://github.com/iis-esslingen/GlORIE-SLAM.git

  cd /workspace/GlORIE-SLAM

  pip install thirdparty/evaluate_3d_reconstruction_lib

  python setup.py install

  pip install gdown
  gdown "https://drive.google.com/uc?id=1oZbVPrubtaIUjRRuT8F-YjjHBW-1spKT" -O glorie-pretrained.zip
  unzip glorie-pretrained.zip -d pretrained
fi

echo ">>> End of post install script <<<" 