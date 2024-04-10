The original MatterSim website is:https://github.com/peteanderson80/Matterport3DSimulator

The original BEV-Bert website is:https://github.com/MarSaKi/VLN-BEVBert

Thanks so much for their efforts.

# Docker for MatterSim + BEVBert

This is a docker that contains both Mattersim and BEVBert. For those who want to pursue the VLN research.


If you want to build this docker, please follow the instructions below.

First, you need to clone this project:

```
git clone https://github.com/Mercy2Green/MatterSim_BEVBert_Docker.git
cd MatterSim_BEVBert_Docker
```

Then, you will see a docker file to build this docker and a shell file to run this docker.


```
docker build -t mattersim:11.3.0-devel-ubuntu20.04 .
```

After the build process, you can test if the docker images can be run correctly.

```
docker run --gpus all -it mattersim:11.3.0-devel-ubuntu20.04
```

Next, you will need to edit the shell file. There are some PATH you will need to rewrite as you need.

```
export MATTERPORT_DATA_DIR=path/to/v1/unzipped
export MATTERPORT_SIMULATOR_DIR=./Matterport3DSimulator_opencv4
export BEVBERT_DIR=./VLN-BEVBert

# Habitat dataset for BEV-BERT

export HABITAT_DATA_DIR=path/to/mp3d
```

Oh, you will need the Matterport3Dsimulator_opencv4 version, which I already provided.
I also provide a copy of VLN-BEVBert which is as same as the original BEVBert. You can clone the original one if you want.

After you rewrite these PATH, you can use the shell to enter the docker.

```
./docker_mattersim_bevbert.sh
```

## MatterSim

Then, in the docker, enter the PATH of the Matterport3DSimulator_opencv4 to build it.

If there is a build folder, you will need to delete it first.

```
cd /root/mount/Matterport3DSimulator
mkdir build && cd build
cmake -DEGL_RENDERING=ON ..
make
cd ../
```

You can test the MatterSim by using:

```
./build/tests ~Timing
```
If all the test is passed, which means you will see only green without any red errors or worrying.

If the terminal shows that "Segment dumped", don't worry, It is just because the memory of your computer is not enough to perform some of the test tasks. But it won't be a problem.

Ok, so, your MatterSim is ready to go. We can test the BEVBert next.

## BEVBert

Since we using --mount to mount the BEVBert folder on the docker, you will need to edit the dataset path in some of the BEVBert code.

For example, if you want to test the "grid_mp3d_clip.py.", you will need to change the data folder PATH in the "grid_mp3d_clip.py."

You can use the code below to test if the MatterSim is fine.
```
python precompute_features/grid_mp3d_clip.py
```

You can use the code below to test if the Habitat is fine.
```
python precompute_features/grid_depth.py
```

That all.
