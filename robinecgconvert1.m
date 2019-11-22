function [] = robinecgconvert1()
FontSize=11;
FontName='Times New Roman';
LineWidth=1;
LineType={'-k','--k','-.k',':k'};
addpath('C:\Users\Asus\Desktop\robin\data')
parentDir = 'C:\Users\Asus\Desktop\robin\data';
dataDir = 'data';

[datadir] = uigetdir('Database Folder selection');
sss=dir(datadir);
sss = sss(3:end);
OK=[sss.isdir];
Dir = sss(OK);
sss=sss(~OK);
sss=struct2cell(sss);

sss=sss(1,:);
hFunRotation = @(s) contains(s,'.mat');
OKFile = cellfun(hFunRotation,sss);
s = sss(OKFile);
ss=s';


% determination of the file name related to the lables
hFunRotation = @(s) contains(s,'labels');
OKFile = cellfun(hFunRotation,sss);
FileName = sss(OKFile); % file with rotation speeds
if isempty(FileName)
    Error = 1; % rotation speed file not founded
    return;
end
if length(FileName)>1
    hfln = @(s) length(s);
    NameLength = cellfun(hfln,FileName);
    [~,Imin] = min(NameLength);
    FileName = FileName(Imin);
end
   
label_filepath = [datadir '\' FileName{1}]; % full name of the file with labels

%---------------%----------------%---------------------%--------------------%----------------------
%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:

%% Setup the Import Options
opts = spreadsheetImportOptions("NumVariables", 4);

% Specify sheet and range
opts.Sheet = "Sheet1";
opts.DataRange = "D1:G45";

% Specify column names and types
opts.VariableNames = ["VarName4", "VarName5", "VarName6", "VarName7"];
opts.VariableTypes = ["double", "double", "double", "double"];

% Import the data
table = readtable(label_filepath, opts, "UseExcel", false);


%% Clear temporary variables
clear opts

%----------------------%----------------------%------------------------------
% Creating the Lable data from the loaded lable.xles file

for b=1:size(table,1)
    check1=table2array(table(b,1));
    check2=table2array(table(b,2));
    check3=table2array(table(b,3));
    check4=table2array(table(b,4));
if check1==1
    label='A';
else 
        if check2==1
        label='B';
    else
        if check3==1
        label='C';
        else
            check4==1;
        label='D';
        end
        end
end
    Labels{b,1}=label;
end

%-------loading of ECG Data

for j=1:size(s,2) %loop on all files of various patients
T = load(s{j}); 
X=T.data_block1(1,:); %loading of ECG signal
X=X(1:400000); % extract only first 400000 datapoints of the loaded ECG signal
X= reshape(X, 20000, 20)'; % Splitting the loaded signal in 5 parts of 80000 datasets each

Label_individual=repmat(Labels(j),size(X,1),1);

ECGData.Data=X;
ECGData.Labels=Label_individual;

%save(strcat('ECGData','.mat'),'ECGData');

%------------%-------------%--------------%------------------


helperCreateECGDirectories(ECGData,parentDir,dataDir)

% Fs = 128;
% fb = cwtfilterbank('SignalLength',80000,...
%     'SamplingFrequency',Fs,...
%     'VoicesPerOctave',12);
% sig = ECGData.Data(1,1:80000);
% [cfs,frq] = wt(fb,sig);
% t = (0:79999)/Fs;figure;pcolor(t,frq,abs(cfs))
% set(gca,'yscale','log');shading interp;axis tight;
% title('Scalogram');xlabel('Time (s)');ylabel('Frequency (Hz)')

helperCreateRGBfromTF(ECGData,parentDir,dataDir)

end