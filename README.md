# project

For Scikit_Learn File:
Steps Included:

1. We have been given with excel sheet data set of 45 patients with 4 class. The classes are imabalanced so that we have SMOTE technique for class balancing. 
2. We have various features whose values differes greatly, therefore it affects our model if we use these directly for training our model. So, i have used min max scalar function for scaling all feature on common range. 
3. It is important to predict on Blind dataset for prediction of any model's performance so i have made two separate data set one exclusively used for training and validation and second is used for testing of our model. 
It is important to notice correlation between the features so i have implemented correlation function to get the correlation coefficient among the feature and set certain thershold for dropping the highly correlated feature. 
4. After preprocessing of the data, There are various classification method for classification of the target signals. 
