# Matterport3DSimulator
# Requires nvidia gpu with driver 396.37 or higher

# m2g@m2g:~$ docker run --gpus all --rm -it -v source=$MATTERPORT_DATA_DIR,target=/root/mount/Matterport3DSimulator/data/v1/scans --volume `pwd`:/root/mount/Matterport3DSimulator mattersim:9.2-devel-ubuntu18.04


FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

# Install a few libraries to support both EGL and OSMESA options
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y wget doxygen curl libjsoncpp-dev libepoxy-dev libglm-dev libosmesa6 libosmesa6-dev libglew-dev libopencv-dev python3-setuptools python3-dev python3-pip

RUN pip3 install numpy pandas networkx==2.2 opencv-python==4.1.2.30

RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

RUN apt-get install -y libglfw3-dev libgles2-mesa-dev


# BEVBert additional dependencies
RUN pip3 install h5py msgpack_numpy tqdm ftfy regex timm

RUN pip3 install progressbar2==3.55.0


#install latest cmake
ADD https://cmake.org/files/v3.12/cmake-3.12.2-Linux-x86_64.sh /cmake-3.12.2-Linux-x86_64.sh
RUN mkdir /opt/cmake
RUN sh /cmake-3.12.2-Linux-x86_64.sh --prefix=/opt/cmake --skip-license
RUN ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake
RUN cmake --version

ENV PYTHONPATH=/root/mount/Matterport3DSimulator/build