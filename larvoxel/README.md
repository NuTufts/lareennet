# Voxel-based models

This folder holds scripts, data loaders, and networks for operating on voxelized LArTPC data.

We implement two types of networks to benchmark potential improvements from using euclidean-equivariant models.

* Single Particle Classification network: `models/larvoxelclassifier.py`
* Semantic segmentation network: (not implemented yet)

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
