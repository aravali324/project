# project

For Scikit_Learn.ipynb File:

Steps Included:

1. We have been given with excel sheet data set of 45 patients with 4 class. The classes of given data are imabalanced so  we have implemented SMOTE technique for class balancing. 
2.There are various features whose values differes greatly, therefore it affects our model if we feed them directly for training our model. So, i have used min max scalar function for scaling all feature on common range. 
3. It is important to predict on Blind dataset for prediction of any model's performance so i have made two separate data set one exclusively used for training and validation and second is used for testing of our model. 
It is important to notice correlation between the features so i have implemented correlation function to get the correlation coefficient among the feature and set certain thershold for dropping the highly correlated feature. 
4. After preprocessing of the data, There are various classification method for classification of the target signals. here, I have implemented XGboost, AdaBoost and Grdaient boosting classifier.  


For Processing of the ECG Signals following files are used:
(helperCreateECGDirectories.m, helperCreateRGBfromTF.m, robinecganalysis.m, robinecgconvert1.m) 

1. These files are used for preprocessing the ECG signals and segregate the signals on the basis of their class (target) 
2. It then Filter out the unnecessary signals from the ECG signals 
3. then it cut the 1,00,000 samples into 10,000 * 10 so we have total 10 signals of 10,000 samples of each target. 
4. Then it make the spectrogram of each signal and save it as the .jpg image corrosponding to the respectuve class folder. 
5. AlexNet neural network have been used for processing these images and predict the targets on blind dataset. 


For recuurent_plot.ipynb file:

1. This model is used for feature fusion process. 
2. The input to this model contains excel sheet data set and spectrogram images of the ECG data. 
3. The CNN model is used for processing images and Neural network is used for processing the excel sheet dataset. 
4. In the end, Neural network is used for feature level fusion and classified the classes. 

