#!/bin/bash

cd /workspace/GS_ICP_SLAM
cd /workspace/GS_ICP_SLAM/submodules/fast_gicp
mkdir build
cd /workspace/GS_ICP_SLAM/submodules/fast_gicp/build
cmake ..
make -j8
cd /workspace/GS_ICP_SLAM/submodules/fast_gicp
python setup.py install --user

cd /workspace/GS_ICP_SLAM/SIBR_viewers
cmake -Bbuild . -DCMAKE_BUILD_TYPE=Release
cmake --build build -j4 --target install

cd /workspace/GS_ICP_SLAM
pip install submodules/diff-gaussian-rasterization
pip install submodules/simple-knn

cd /workspace/GS_ICP_SLAM/SIBR_viewers
cmake -Bbuild . -DCMAKE_BUILD_TYPE=Release
cmake --build build -j4 --target install