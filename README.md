<h1 align="center">
  NeRF and Gaussian Splatting SLAM in the Wild

  [![arXiv](https://img.shields.io/badge/arXiv-2412.03263-b31b1b.svg?style=plastic)](https://arxiv.org/abs/2412.03263)
</h1>

<br>

## Getting Started
The only required software is [Docker](https://www.docker.com/). Each SLAM method comes with its own Docker container, making setup straightforward. We recommend using VSCode with the Docker extension for an enhanced development experience. Additionally, we provide a Docker container with tools for evaluation.

When running the Dockerfiles, the first step is to navigate to the directory where the dataset is stored, as it will be mounted inside the Docker container.

Tested using Ubuntu 22.04.

## Data
Coming soon.

## SLAM Methods
Each method is available as a Docker container. When running the Dockerfiles, the first step is to enter the directory where the dataset is stored, as it will be mounted inside the Docker container.


<details><summary>ORB-SLAM3</summary>

We are using [our fork](https://github.com/iis-esslingen/ORB-SLAM3) of the [ORB-SLAM3 ROS Wrapper](https://github.com/thien94/orb_slam3_ros) implementation. 

To launch the application:

```bash
roslaunch orb_slam3_ros <launch_file> \
    do_bag:=<do_bag> bag:=<bag> \
    do_save_traj:=<do_save_traj> \
    traj_file_name:=<traj_file_name> \
    do_lc:=<enable_loop_closing>
```

#### Parameters:

- `launch_file`: Specifies the launch file to use. Choices include:
    - `rover_mono_d435i.launch`: To launch monocular mode.
    - `rover_rgbd_d435i.launch`: To launch RGBD mode.

- `do_bag`: *(Optional)* Specifies whether to replay a bag. Set to either:
    - `true`: To replay a bag.
    - `false`: To not replay a bag.

- `bag`: *(Optional)* Specifies the path to the rosbag file.

- `do_save_traj`: *(Optional)* Specifies whether to save a predicted trajectory. Set to either:
    - `true`: To save the trajectory.
    - `false`: To not save the trajectory.

- `traj_file_name`: *(Optional)* Specifies the file path where the estimated trajectory should be saved.

- `do_lc`: *(Optional)* Specifies whether to enable loop closing. Set to either:
    - `true`: To enable loop closing.
    - `false`: To disable loop closing.
 
</details>


<details><summary>DROID-SLAM</summary>

We are using [our fork](https://github.com/iis-esslingen/DROID-SLAM) of the official [DROID-SLAM](https://github.com/princeton-vl/DROID-SLAM) implementation. 

Example to run the application and evaluation:

```bash
python evaluation_scripts/test_rover_d435i.py \
    --data_path /garden_small/2023-08-18 \
    --ground_truth_path /garden_small/2023-08-18/ground_truth.txt \
    --output_path ./rover_trajectories
```

#### Parameters:

-  `base_data_path`: Specifies the base directory of the dataset sequence.
-  `ground_truth_path`: Path to the ground truth file for the selected dataset sequence.
-  `output_path`: Directory where the resulting trajectories will be stored.

To test DROID-SLAM in RGBD mode (Camera D435i), add the flag `--depth`, for Stereo mode (Camera T265) add `--stereo`.

</details>

<details><summary>DPV-SLAM</summary>

We are using [our fork](https://github.com/iis-esslingen/DPV-SLAM) of the official [DPVO / DPV-SLAM](https://github.com/princeton-vl/DPVO) implementation. 
  
**Note:** The container currently does not support visualization.

Example to run the application and evaluation:

```bash
python evaluate_rover.py \
    --base_data_path /garden_small/2023-08-18 \
    --ground_truth_path /garden_small/2023-08-18/ground_truth.txt \
    --output_path ./rover_trajectories \
    --cameras d435i \
    --trials 5 \
    --opts LOOP_CLOSURE True
```

#### Parameters:

-  `base_data_path`: Specifies the base directory of the dataset sequence.
-  `ground_truth_path`: Path to the ground truth file for the selected dataset sequence.
-  `output_path`: Directory where the resulting trajectories will be stored.
-  `cameras`: List of cameras to be used for the evaluation. Choices: `d435i`, `t265`, or `pi_cam`.
-  `trials`: The number of trials to execute for the evaluation.
-  `opts`: Specifies additional optional arguments.

To enable Loop Closing for DPV-SLAM, the argument: `--opts LOOP_CLOSURE True` has to be set.

</details> 


<details><summary>Orbeez-SLAM</summary>

We are using [our fork](https://github.com/iis-esslingen/Orbeez-SLAM) of the official [Orbeez-SLAM](https://github.com/MarvinChung/Orbeez-SLAM) implementation. 

Example to run the application in monocular mode:

```bash
./build/mono_rover \
    ./Vocabulary/ORBvoc.txt \
    ./configs/Monocular/ROVER/d435i.yaml \
    "/path/to/data/d435i" \
    "/output/dir"
```

Example to run the application in RGBD mode:

```bash
./build/rgbd_rover \
    ./Vocabulary/ORBvoc.txt \
    ./configs/RGB-D/ROVER/d435i.yaml \
    "/path/to/data/d435i" \
    "/path/to/data/associations.txt" \
    "/output/dir"
```

Additionally you can have a look at the script `run_rover.sh` that runs all of the experiments.

</details> 

<details><summary>GO-SLAM</summary>

We are using [our fork](https://github.com/iis-esslingen/GO-SLAM) of the official [GO-SLAM](https://github.com/youmi-zym/GO-SLAM) implementation. 

Example to run the application in monocular mode:

```bash
python run_rover.py <config> \
    --device <device> \
    --input_folder /path/to/input_folder \
    --output /path/to/output_folder \
    --mode <mode> \
    --only_tracking
```

#### Parameters:
- `config`: Path to the configuration file that contains the settings for the SLAM system. For ROVER dataset use `.configs/ROVER/d435i.yaml`.
- `device`: Specifies the computing device to run the script on. Default is `cuda:0`, meaning the first GPU.
- `input_folder`: The path to the input folder containing data.
- `output`: The path where the results will be stored. 
- `mode`: The SLAM mode to use. Choose from `mono`, `rgbd`, or `stereo`.
- `only_tracking`: If set, only tracking will be triggered without mapping.

</details> 

<details><summary>GlORIE-SLAM</summary>

We are using [our fork](https://github.com/iis-esslingen/GlORIE-SLAM) of the official [GlORIE-SLAM](https://github.com/zhangganlin/GlORIE-SLAM) implementation. 

Example to run the application:

```bash
python run.py <config> \
    --input_dir /path/to/input_folder \
    --output_dir /path/to/output_folder \
    --only_tracking
```

#### Parameters:
- `config`: Path to the configuration file that contains the settings for the SLAM system. For ROVER dataset use `.configs/ROVER/d435i.yaml`.
- `input_folder`: The path to the input folder containing data.
- `output`: The path where the results will be stored. 
- `only_tracking`: If set, only tracking will be triggered without mapping.

Additionally you can have a look at the script `run_rover_all.sh` that runs all of the experiments.

</details> 

<details><summary>Co-SLAM</summary>

We are using [our fork](https://github.com/iis-esslingen/Co-SLAM) of the official [Co-SLAM](https://github.com/HengyiWang/Co-SLAM) implementation. 

Example to run the application:

```bash
python coslam_rover.py \
    --config /path/to/config.yaml \
    --input_folder /path/to/input_folder \
    --output /path/to/output_folder 
```

#### Parameters:
- `config`: Path to the configuration file that contains the settings for the SLAM system. For ROVER dataset use `.configs/ROVER/d435i.yaml`.
- `input_folder`: The path to the input folder containing data.
- `output`: The path where the results will be stored. 

Additionally you can have a look at the script `run_rover_all.sh` that runs all of the experiments.

</details> 


<details><summary>MonoGS</summary>

We are using [our fork](https://github.com/iis-esslingen/MonoGS) of the official [MonoGS](https://github.com/muskie82/MonoGS) implementation. 

**Note:** The container currently does not support visualization.

Example to run the application:

```bash
python run_slam_rover.py \
    --config /path/to/config.yaml \
    --data_path /path/to/input_folder \
    --output_path /path/to/output_folder \
    --eval
```

#### Parameters:
- `config`: Path to the configuration file that contains the settings for the SLAM system. For ROVER dataset use `.configs/[mono/rgbd]/ROVER/d435i.yaml`.
- `data_path`: The path to the input folder containing data.
- `output_path`: The path where the results will be stored.
- `eval`: Enables evaluation of results.

Additionally you can have a look at the script `run_rover_all.sh` that runs all of the experiments.

</details> 

<details><summary>Photo-SLAM</summary>

We are using [our fork](https://github.com/iis-esslingen/Photo-SLAM) of the official [Photo-SLAM](https://github.com/HuajianUP/Photo-SLAM) implementation. 

**Note:** The container currently does not support visualization.

Example to run the application in monocular mode:

```bash
./bin/rover_mono \
    ./ORB-SLAM3/Vocabulary/ORBvoc.txt \
    ./cfg/ORB_SLAM3/Monocular/ROVER/d435i.yaml \
    ./cfg/gaussian_mapper/Monocular/ROVER/rover_mono.yaml \
    "/path/to/data/d435i" \
    "/output/dir"
    no_viewer
```

Example to run the application in RGBD mode:

```bash
./bin/rover_rgbd \
    ./ORB-SLAM3/Vocabulary/ORBvoc.txt \
    ./cfg/ORB_SLAM3/RGB-D/ROVER/d435i.yaml \
    ./cfg/gaussian_mapper/RGB-D/ROVER/rover_rgbd.yaml \
    "/path/to/data/d435i" \
    "/path/to/data/associations.txt" \
    "/output/dir"
    no_viewer
```

Additionally you can have a look at the script `scripts/rover_all.sh` that runs all of the experiments.

</details> 

<details><summary>Splat-SLAM</summary>

We are using [our fork](https://github.com/iis-esslingen/Splat-SLAM) of the official [GlORIE-SLAM](https://github.com/zhangganlin/GlORIE-SLAM) implementation. 

Example to run the application:

```bash
python run.py <config> \
    --input_dir /path/to/input_folder \
    --output_dir /path/to/output_folder \
    --only_tracking
```

#### Parameters:
- `config`: Path to the configuration file that contains the settings for the SLAM system. For ROVER dataset use `.configs/ROVER/d435i.yaml`.
- `input_dir`: The path to the input folder containing data.
- `output_dir`: The path where the results will be stored. 
- `only_tracking`: If set, only tracking will be triggered without mapping.

Additionally you can have a look at the script `run_rover_all.sh` that runs all of the experiments.

</details> 

<details><summary>GS-ICP-SLAM</summary>
  Coming soon.
</details> 

## Evaluation
Coming soon.

## Citing
If you find our work useful, please consider citing:
```bibtex
@article{schmidt2024nerfgsbenchmark,
      title={NeRF and Gaussian Splatting SLAM in the Wild}, 
      author={Fabian Schmidt and Markus Enzweiler and Abhinav Valada},
      year={2024},
      eprint={2412.03263},
      archivePrefix={arXiv},
      primaryClass={cs.RO},
      url={https://arxiv.org/abs/2412.03263}, 
}
```
