#!/bin/bash
set -eux

echo ">>> Start of post install script <<<"

if [[ ! -d "/workspace/MonoGS" ]]; then
  echo "Cloning MonoGS repository..."
  
  cd /workspace

  git clone --recursive https://github.com/iis-esslingen/MonoGS.git

  cd MonoGS
  pip install submodules/diff-gaussian-rasterization
  pip install submodules/simple-knn
fi

echo ">>> End of post install script <<<" 