function helperCreateRGBfromTF(ECGData,parentFolder,childFolder)
% This function is only intended to support the ECGAndDeepLearningExample.
% It may change or be removed in a future release.

imageRoot = fullfile(parentFolder,childFolder);

data = ECGData.Data;
labels = ECGData.Labels;

[~,signalLength] = size(data);

fb = cwtfilterbank('SignalLength',signalLength,'VoicesPerOctave',12);
r = size(data,1);

for ii = 1:r
    cfs = abs(fb.wt(data(ii,:)));
    im = ind2rgb(im2uint8(rescale(cfs)),jet(128));
    imgLoc = fullfile(imageRoot,char(labels(ii)));
    zz=dir(imgLoc);
    zz = zz(3:end);
    if isempty(zz)
        zzzz=1;
    else
    OOK=[zz.isdir];
    zz=zz(~OOK);
    zz=struct2cell(zz);
    zz=zz(1,:);
    zzzz=length(zz)+1;
    % I need to find a method to get the maximum number of the jp
  %  zzz=zz(length(zz)); 
    % Boom Done
   % zzzz=str2num(zzz{1}(end-6:end-4))+1;
    end
    imFileName = strcat(char(labels(ii)),'_0',num2str(zzzz),'.jpg');
    imwrite(imresize(im,[224 224]),fullfile(imgLoc,imFileName));
end
end

