# Matterport3DSimulator
# Requires nvidia gpu with driver 396.37 or higher


FROM nvidia/cudagl:11.3.0-devel-ubuntu20.04

SHELL ["/bin/bash", "-c"]

# Install cudnn
# ENV CUDNN_VERSION 8.2.2.26
# LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

# RUN apt-get update && apt-get install -y --no-install-recommends \
#     libcudnn8=$CUDNN_VERSION-1+cuda11.4 \
# libcudnn8-dev=$CUDNN_VERSION-1+cuda11.4 \
# && \
#     apt-mark hold libcudnn8 && \
#     rm -rf /var/lib/apt/lists/*



ENV cudnn_version=8.2.1.32
ENV cuda_version=cuda11.3
LABEL com.nvidia.cudnn.version="${cudnn_version}"
RUN apt-get update && apt-get install -y libcudnn8=${cudnn_version}-1+${cuda_version}
RUN apt-get install -y libcudnn8-dev=${cudnn_version}-1+${cuda_version}


# Install a few libraries to support both EGL and OSMESA options
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y wget doxygen curl libjsoncpp-dev libepoxy-dev libglm-dev libosmesa6 libosmesa6-dev libglew-dev libopencv-dev python3-setuptools python3-dev python3-pip

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    vim \
    ca-certificates \
    libjpeg-dev \
    libpng-dev \
    libglfw3-dev \
    libglm-dev \
    libx11-dev \
    libomp-dev \
    libegl1-mesa-dev \
    pkg-config \
    wget \
    zip \
    unzip &&\
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y python-is-python3
RUN apt-get install -y libglfw3-dev libgles2-mesa-dev

#install latest cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.14.0/cmake-3.14.0-Linux-x86_64.sh
RUN mkdir /opt/cmake
RUN sh /cmake-3.14.0-Linux-x86_64.sh --prefix=/opt/cmake --skip-license
RUN ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake
RUN cmake --version

# Install miniconda python36 latest
RUN wget -O miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN /bin/bash miniconda.sh -b -p /opt/conda
RUN rm miniconda.sh
ENV PATH /opt/conda/bin:$PATH

RUN conda create -y -n bevbert python=3.6 cmake=3.14.0
RUN echo "source activate bevbert" >> ~/.bashrc

RUN source activate bevbert && \
    pip3 install numpy pandas networkx==2.2 opencv_python==4.1.2.30

RUN source activate bevbert && \
    pip3 install torch==1.10.2+cu113 --extra-index-url https://download.pytorch.org/whl/cu113

RUN source activate bevbert && pip3 install torchvision==0.11.3+cu113 --extra-index-url https://download.pytorch.org/whl/cu113

RUN source activate bevbert && pip3 install torchaudio==0.10.2 --extra-index-url https://download.pytorch.org/whl/cu113


# BEVBert additional dependencies
RUN source activate bevbert && \
    pip3 install h5py msgpack_numpy tqdm ftfy regex timm && \
    pip3 install progressbar2==3.55.0

# install habitat and habitat_baselines
RUN source activate bevbert && \
    git clone --branch v0.1.7 https://github.com/facebookresearch/habitat-sim.git && \
    cd habitat-sim && \
    pip3 install -r requirements.txt && \
    python setup.py install --headless

RUN source activate bevbert && \
    pip3 install protobuf==3.19.6 && \
    git clone --branch v0.1.7 https://github.com/facebookresearch/habitat-lab.git && \
    cd habitat-lab && \
    pip3 install -e . && cd .. 

ENV GLOG_minloglevel=2
ENV MAGNUM_LOG="quiet"

RUN source activate bevbert && \
    pip3 install gym==0.17.3

ENV PYTHONPATH=/root/mount/Matterport3DSimulator/build

RUN source activate bevbert && \
    conda env config vars set PYTHONPATH=/root/mount/Matterport3DSimulator/build

# RUN cp /opt/conda/lib/libstdc++.so.6.0.29 /usr/lib/x86_64-linux-gnu/ && \
#     rm /usr/lib/x86_64-linux-gnu/libstdc++.so.6 && \
#     ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.29 /usr/lib/x86_64-linux-gnu/libstdc++.so.6