# lareennet

Exploration of Euclidean Equivarient Neural Networks for Liquid Argon TPC data

# Setting up the container

(To be implemented)

# Setting up MicroBooNE code for accessing data

## If using container w/ ubdl

## If using container w/ dependencies only

First setup of the ubdl repository. You only have to do this the first time you check out this code.


```
git submodule init
git submodule update
```

Then setup the environment variables.

```
source set_env_vars.sh
```

Now go into the ubdl repository and start the build

```
source scripts/buildall_py3.sh
```

That should be it. To test it, you can go into the folder where this README lives then

```
python3
> from larcv import larcv
```

If you see no errors, things should be ok.

# Setup on MIT Supercloud

For running on supercloud, you'll need to build up several pre-requisites.

In the instructions below, we're keeping the pre-req packages in `$HOME/software`

## ROOT

According to g++:

```
g++ --version
g++ (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
```

the login-3 node uses ubuntu18.04 gcc7.5.0. Luckily, there is a pre-built binary for ROOT.

```
cd $HOME/software
wget https://root.cern/download/root_v6.24.06.Linux-ubuntu18-x86_64-gcc7.5.tar.gz
tar -zxvf root_v6.24.06.Linux-ubuntu18-x86_64-gcc7.5.tar.gz
rm root_v6.24.06.Linux-ubuntu18-x86_64-gcc7.5.tar.gz
```

## Open CV

```
cd $HOME/software
mkdir opencv
cd opencv
git clone https://github.com/opencv/opencv.git source
mkdir build
mkdir 4.5.3
cd source
git checkout -b 4.5.3 4.5.3
cd ../build
cmake -DCMAKE_INSTALL_PREFIX=$HOME/software/opencv/4.5.3 ../source
make install
```

## Eigen3

```
cd $HOME/software
mkdir eigen
cd eigen
mkdir build
mkdir 3.4.0
git clone https://gitlab.com/libeigen/eigen.git source
cd source
git checkout -b 3.4.0 3.4.0
cd ../build
cmake -DCMAKE_INSTALL_PREFIX=$HOME/software/eigen/3.4.0 ../source
make install
```

I found I needed to hack `$HOME/software/eigen/3.4.0/share/eigen3/cmake/Eigen3Config.cmake` with

```
# get_filename_component(PACKAGE_PREFIX_DIR ...
set(PACKAGE_PREFIX_DIR "/home/gridsan/twongjirad/software/eigen/3.4.0/")
```

Hopefully this was a mistake in my setup and not needed.

## UBDL

First, change `setenv_supercloud.sh`, located in the same folder as this README, to point to wherever you put ROOT, OpenCV, and Eigen3.


```
cd $HOME/lareennet
source setenv_supercloud.sh
cd $HOME
git clone https://github.com/larbys/ubdl
cd ubdl
git checkout gen2
git submodule init
git submodule update
source configure.sh
source buildall_py3.sh
```

Hopefully, you'll see no errors and the following message:

```
echo "built ubdl modules"
```
## pytorch

(coming)

## minkowski engine

(coming)


# Training data workflow

Training data derives from MicroBooNE simulated files.
We use code in the [larflow](https://github.com/NuTufts/larflow) repository to extract
image and truth meta-data for training.

Our data files are written and read using the [ROOT](https://github.com/root-project/root) data analysis framework.


## Step 1: MicroBooNE files to Triplet files


From MicroBooNE files (larcv, larlite) into `triplet` files. Triplet files store candidate
space points formed from a triplet of pixels from the three MicroBooNE wire planes.
Truth labels for these spacepoints are also stored.

Labels provided:
* true/false 3d space point
* particle type
* proximity to keypoint: neutrino vertex, track start and end, shower starts, michel electron start, delta ray start.

To run:

```
python ${LARFLOW_BASEDIR}/larflow/PrepFlowMatchData/test/run_prepmatchtriplets_wfulltruth.py

usage: run_prepmatchtriplets_wfulltruth.py [-h] -lcv INPUT_LARCV -ll INPUT_LARLITE -o OUTPUT [-adc ADC_NAME] [-mc] [-n NENTRIES] [-e START_ENTRY]

Run Prep LArFlow Match Data

optional arguments:
  -h, --help            show this help message and exit
  -lcv INPUT_LARCV, --input-larcv INPUT_LARCV
                        Input larcv file
  -ll INPUT_LARLITE, --input-larlite INPUT_LARLITE
                        Input larlite file
  -o OUTPUT, --output OUTPUT
                        Filename for LArCV output
  -adc ADC_NAME, --adc-name ADC_NAME
                        Name of Tree containing wire images
  -mc, --has-mc         Has MC information
  -n NENTRIES, --nentries NENTRIES
                        Set number of events to run [default: all in file]
  -e START_ENTRY, --start-entry START_ENTRY
                        Set entry to start at [default: entry 0]
```

## Step 2: MicroBooNE files to Triplet files

After triplet files are made, we use them to write the numpy arrays we will use for network training.
The numpy arrays are stored in our files as `larcv::NumpyArray` objects.
These objects allow us to store the arrays in our ROOT files and then easily restore the numpy array for our network.



