# Voxel-based models

This folder holds scripts, data loaders, and networks for operating on voxelized LArTPC data.

We implement two types of networks to benchmark potential improvements from using euclidean-equivariant models.

* Single Particle Classification network: `models/larvoxelclassifier.py`
* Semantic segmentation network: (not implemented yet)

## Running the test example

First, get the singularity container. You can also run the code within a docker container.

### Singularity

If you don't already have it, you can install singularity via [these instructions](https://sylabs.io/guides/3.9/user-guide/quick_start.html#quick-installation-steps).

Download the ubdl container at this [google drive location](https://drive.google.com/file/d/1dpJquaLIihqBqOtb2NwNZ_Mm4qR8p3U1/view?usp=sharing).

If you haven't already done it, clone this repository somewhere:

```
git clone http://github.com/nutufts/lareennet
```

You can then start the singularity container

```
singularity shell --nv [location of container]/singularity_ubdl_dlgen2_u20.04.cu111.torch1.9.0.sif
Singularity > bash
```

Now you are inside the container (and inside a bash shell).

Go to the `larennet` folder you cloned and run

```
source set_env_vars_ubdl_container.sh
```

If you haven't already, get some testdata (instructions in `testdata/README.md`) and put it into the `testdata` folder.

Then you should be able to start the training,

```
python train_dist_larvoxel_classify.py --config-file config/larvoxel_classifier_test.yaml --gpu 1
```

### Docker

Note -- I could not figure out how to run docker with the nvidia runtime.
So I have not tested it.
I imagine the instructions would be something like the following.

---

You can also get a docker container instead.


```
docker pull larbys/ubdl:dlgen2_cu11.1_torch1.9_minkowski
```

Start docker

```
docker run --gpu all -it larbys/ubdl:dlgen2_cu11.1_torch1.9_minkowski bash
```

And then follow same steps as singularity container.


## Models

### Classification

The model is implemented in `models/larvoxelclassifier.py`.
The baseline network uses sub-manifold convolution operations implemented by the
MinkowskiEngine.
The model consists of six residual layers with max pooling between layers.
The feature maps after each layer are at different resolutions.
We broadcast lower resolution features up to high resolution through MinkowskiEngine's
TensorField::slice operation.
We then concatinate the feature layers and pass it through a convolutional layer
in order to mix the different resolution features.
This is followed by global pooling, which collapses the feature vectors at each non-zero pixel
in the tensor down into one feature vector (positioned at the (0,0,0) coordinate).
The global feature vector is then passed into a mulit-layer perceptron in order
to make the final class predictions.

### Voxel Semantic Segmentaion

(To be implemented)

## Datasets

### Classification

For classification we use simulated single particle trajectories isolated from neutrino interactions.
The simulated data was produced by the MicroBooNE collaboration.

### Semantic segmentation

(Use PiLArNet data? Use MicroBooNE?)

## Training scripts

### Classification

Use `train_dist_larvoxel_classify.py` to train the classification network.
A YAML configuration  is needed. An example file is in `config/larvoxel_classifier_test.yaml`.

### Semantic segmentation

(To be implemented)
