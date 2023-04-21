FROM ros:noetic-ros-base

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y build-essential software-properties-common\
    && rm -rf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

RUN apt-get install -y ros-noetic-pcl-ros


# Build the Livox ROS Driver 2
RUN apt-get install -y git

RUN sudo apt install cmake

RUN git clone https://github.com/Livox-SDK/Livox-SDK2.git

RUN cd ./Livox-SDK2/ && mkdir -p build && cd build && cmake .. && make -j && sudo make install

RUN mkdir -p /ws_livox/src/livox_ros_driver2
COPY . /ws_livox/src/livox_ros_driver2
RUN source /opt/ros/noetic/setup.sh && /ws_livox/src/livox_ros_driver2/build.sh ROS1

