function [] = robinecganalysis()

parentDir = 'C:\Users\Vanraj\Desktop\robin_project\data';
dataDir = 'data';

allImages = imageDatastore(fullfile(parentDir,dataDir),...
    'IncludeSubfolders',true,...
    'LabelSource','foldernames');

rng default
[imgsTrain,imgsValidation] = splitEachLabel(allImages,0.8,'randomized');
disp(['Number of training images: ',num2str(numel(imgsTrain.Files))]);
disp(['Number of validation images: ',num2str(numel(imgsValidation.Files))]);

alex = alexnet;
layers = alex.Layers

layers(23) = fullyConnectedLayer(4);
layers(25) = classificationLayer;

inputSize = alex.Layers(1).InputSize;
augimgsTrain = augmentedImageDatastore(inputSize(1:2),imgsTrain);
augimgsValidation = augmentedImageDatastore(inputSize(1:2),imgsValidation);

rng default
mbSize = 10;
mxEpochs = 10;
ilr = 1e-4;
plt = 'training-progress';

opts = trainingOptions('sgdm',...
    'InitialLearnRate',ilr, ...
    'MaxEpochs',mxEpochs ,...
    'MiniBatchSize',mbSize, ...
    'ValidationData',augimgsValidation,...
    'ExecutionEnvironment','cpu',...
    'Plots',plt);

trainedAN = trainNetwork(augimgsTrain,layers,opts);

trainedAN.Layers(end-2:end)
end