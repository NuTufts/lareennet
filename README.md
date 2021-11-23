# lareennet

Exploration of Euclidean Equivarient Neural Networks for Liquid Argon TPC data

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



