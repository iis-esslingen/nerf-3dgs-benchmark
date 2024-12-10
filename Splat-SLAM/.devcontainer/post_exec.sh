#!/bin/bash
set -eux

echo ">>> Start of post install script <<<"

DISPLAY_EXPORT="export DISPLAY=:0"

if [[ ! -d "/workspace/Splat-SLAM" ]]; then
  echo "Cloning Splat-SLAM repository..."
  
  cd /workspace

  git clone --recursive https://github.com/iis-esslingen/Splat-SLAM.git

  cd /workspace/Splat-SLAM

  sed -i 's/p_view\.z <= 0\.2f/p_view\.z <= 0\.001f/' /workspace/Splat-SLAM/thirdparty/diff-gaussian-rasterization-w-pose/cuda_rasterizer/auxiliary.h && \
    pip install --no-cache-dir -e thirdparty/lietorch/ \
                                   thirdparty/diff-gaussian-rasterization-w-pose/ \
                                   thirdparty/simple-knn/ \
                                   thirdparty/evaluate_3d_reconstruction_lib/ && \
    pip install --no-cache-dir -e . && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir pytorch-lightning==1.9 --no-deps && \
    pip install --no-cache-dir gdown

  pip install gdown
  gdown "https://drive.google.com/uc?id=1oZbVPrubtaIUjRRuT8F-YjjHBW-1spKT" -O glorie-pretrained.zip
  unzip glorie-pretrained.zip -d pretrained
fi

echo ">>> End of post install script <<<" 