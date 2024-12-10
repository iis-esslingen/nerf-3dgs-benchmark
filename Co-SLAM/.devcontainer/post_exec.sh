#!/bin/bash
set -eux

echo ">>> Start of post install script <<<"

if [[ ! -d "/workspace/Co-SLAM" ]]; then
  echo "Cloning Co-SLAM repository..."
  
  cd /workspace

  git clone https://github.com/iis-esslingen/Co-SLAM.git

  cd Co-SLAM
  pip install torch==1.10.1+cu113 torchvision==0.11.2+cu113 torchaudio==0.10.1 -f https://download.pytorch.org/whl/cu113/torch_stable.html
  pip install -r requirements.txt
  
  cd /workspace/Co-SLAM/external/NumpyMarchingCubes
  python setup.py install
fi

echo ">>> End of post install script <<<" 