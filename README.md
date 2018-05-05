Vehicle Registration Plate Detection and Recognition 


 
164050016 - Chintan Tundia 
174050011 - Shabana KM
174050012 - Sukanya Bhattacharjee


Abstract

In this project, we aim to build an automated pipeline to perform license plate detection from images of vehicles and perform recognition of characters in the number plate. This would involve first localizing the number plate in the image followed by recognizing the characters on the plate. 



Solution Approach


Number Plate Localization


Preprocessing

In this process we sharpen the image and then convert it to gray scale. Finally we binarize the image. 


Approach - 1 :-

Edge Detection
We perform edge detection in order to find the closed regions in the image which are close to the shape and size of a number plate.



Morphological Closing
Since we need closed regions, so we perform morphological closing on the edge detected image.

Detection of ROI
From the closed regions obtained in previous step we need to find the candidates for the number plate. To do this we use bounding boxes which satisfy properties specific to  a number plate


Problems:-
Lots of Hyperparameters so tuning was difficult
Although the approach was producing decent results  on an average but it was not able to give exact and clean results as well as the percentage of false positives was high
More restrictive model due to high dependence on heuristical properties of a number plate



Approach-2

We modified Approach-1 to overcome some of its problems as discussed above. The key idea behind this approach is that the size of a number plate is fixed when considered for a particular country in general. In order to figure out the regions in the image of this particular size, we follow image difference method.

Steps:-
Removal of objects which are very small or very large as compared to the known size of the number plate. This gives us Image1.
Now we remove the objects from the Image1 which are of comparable size to the number plate. This gives us Image2.
Taking the difference of Image1 and Image2 we obtain the candidate number plates. 
We use circularity i.e how similar the shape of an object is to a circle (in our case we need it to be close to a rectangle) to get the final output as the number plate

This method reduces dependency of finding the number plate on a large number of properties of a number plate. Moreover, it has lesser number of false positives as compared to Approach-1.



Character Recognition

We extract the characters from the localized number plate before doing the recognition  so as to make the recognition step less complex. 

Segmentation
For segmenting characters from the localized number plate, we use method of vertical projections. Here we want to find out the spaces which separate the consecutive characters in the number plate. These spaces are used to split the number plate resulting into regions having individual characters.

Character Recognition
In this step we attempted following methods:
Template based classification
Single instance matching
In this method, the test image is matched with templates of characters ranging from A-Z and digits 0-9 using similarity measures. The test image is recognized as the character represented by the template having highest similarity with it.
        
Multiple instance matching
In this method, we synthetically generated character templates of different fonts. The similarity is calculated for a test image with respect to either all the instances or the average of them.  

k-Nearest Neighbor
In this method, we use the inbuilt kNN classifier to train the model and then we predict the character using this model.


All of the above mentioned methods work well for clean and properly formatted data. 


Neural Nets
    Due to lack of sufficient data to train and constraints of MATLAB 2015, we could not get results for this method.

