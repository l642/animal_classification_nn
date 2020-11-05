### Project Title: Classification of animals using texture features and neural networks.
## Theory:
Texture characterizes the spatial arrangement of pixel values in an image. Animals are characterized by
the difference in pattern on their coats, thus making texure based methods useful for animal
segmentation and classification. Different types of texture features include statistical moments, cooccurrence matrix features, spectral features, Gabor features.
Gray-level co-occurrence matrix :
The Gray-level co-occurrence matrix (GLCM) is a matrix G whose (i,j)th element denotes the number
of times the gray-level combination i-j occurs within the neighbourhood defined as Q. Dividing G by
the sum of its elements gives a matrix containing probabilities of co-occurrence of gray levels.
The features extracted from this matrix are
1) Maximum probability
2) Contrast
3) Correlation
4) Uniformity
5) Homogeneity
6) Entropy
These features characterize the smoothness/coarseness of the image. However, to obtain more
information about the texture, other types of features are used.
Fourier Descriptors :
Fourier spectrum describes the directionality and periodicity of texture patterns. It forms a global
description of texture which can be easily distinguished by the location of peaks in the spectrum. The
DFT of image/region is converted to polar form (𝑟, 𝑟) and descriptors are (𝑟) and 𝑟(𝑟) generated by
summing along 𝑟 and 𝑟 respectively. Location of peaks of (𝑟) denotesthe periodicity of the pattern and
peaks of (𝑟) denote its orientation.
Texture based Segmentation :
Region merging techniques for segmentation are based on similarity in gray values. For texture based
segmentation of animals in an image, similarity in texture can be used as a criteria for merging regions.
The procedure is as follows:
1) The image is split into 16 x 16 sized blocks and texture features using any of the methods are
calculated for each block.
2) K-means clustering is applied to these features. The number of clusters is decided by finding
the k value for which distance between clusters is maximum, i.e. different clusters are
dissimilar.
3) Examining the connected components for each cluster gives the segmented foreground pixels.
Border pixels are excluded to distinguish between background and foreground. The extracted
connected components are further used for classification.
## Classification :
Segmentation detects the foreground (animals) in the image. These animals can be classified into
different classes using ANN.

## Artificial Neural Network classifier:

ANN is a set layers of neurons connected by different weights. The input layer takes the values of
features and output layer takes the values of classes. The hidden layers are intermediate stages in
reaching to the output values by combinations of input features. Training of neural network involves
optimizing the weights so as to minimize error between output class and target class. This done by using
gradient descent algorithm.
The procedure of animal classification is as follows :
1) Calculate texture features for the extracted foreground.
2) Apply the test features to the classifier.
3) If the maximum class score is greater than a threshold, animal is classified as that class.
## Confusion Matrix:
## GLCM features
Output\Target Tiger Leopard Bear Lion

Tiger            0 0 0 0

Leopard          6 7 3 3

Bear             0 0 2 0

Lion            3 3 3 5

Accuracy = 42.42%
Fourier descriptor
Output\Target Tiger Leopard Bear Lion

Tiger           11 1 0 0

Leopard        1 13 0 0

Bear           0 0 17 1

Lion           0 0 2 11

 Accuracy = 90.7%
## Conclusion :
GLCM and Fourier descriptors both perform well for segmentation. However, the accuracy of
classification for GLCM is low, as only coarseness of texture cannot distinguish between different
patterns found on animal coats. Fourier descriptor performs well for classification as it can distinguish
between periodicity and shape of texture patterns.




