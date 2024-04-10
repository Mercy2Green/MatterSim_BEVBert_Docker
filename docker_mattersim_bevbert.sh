#! /bin/bash

export MATTERPORT_DATA_DIR=path/to/v1/unzipped
export MATTERPORT_SIMULATOR_DIR=./Matterport3DSimulator_opencv4
export BEVBERT_DIR=./VLN-BEVBert

# Habitat dataset for BEV-BERT

export HABITAT_DATA_DIR=path/to/mp3d

docker run --gpus all -it\
    --mount type=bind,source=$MATTERPORT_DATA_DIR,target=/root/mount/Matterport3DSimulator/data/v1/scans \
    --mount type=bind,source=$MATTERPORT_SIMULATOR_DIR,target=/root/mount/Matterport3DSimulator \
    --mount type=bind,source=$BEVBERT_DIR,target=/root/mount/VLN-BEVBert \
    --mount type=bind,source=$HABITAT_DATA_DIR,target=/root/mount/Matterport3DSimulator/data/scene_datasets/mp3d \
    mattersim:11.3.0-devel-ubuntu20.04

