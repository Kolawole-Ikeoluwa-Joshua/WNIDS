% Solve a Pattern Recognition Problem with a Neural Network
% Script generated by Neural Pattern Recognition app
% Created 13-Nov-2019 03:42:46
%
% This script assumes these variables are defined:
%
%   ConvertedInput - input data.
%   TargetData - target data.


 %[y1, y2] = xlsread('MAC adresses.xlsx');
 %g = hex2dec(y2);
 %f = dec2bin(g);
 
 %display(f')
 %xlswrite('MAC adresses.xlsx',f','convertedaddress');
y3 = xlsread('MAC adresses.xlsx','convertedaddress');

x=y3; % ConvertedInput;

t=y3(25:48,:); %t = TargetData;

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainlm';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
hiddenLayerSize = 50;
myNet = patternnet(hiddenLayerSize, trainFcn);

% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
%myNet.input.processFcns = {'removeconstantrows','mapminmax'};

% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivision
myNet.divideFcn = 'dividerand';  % Divide data randomly
myNet.divideMode = 'sample';  % Divide up every sample
myNet.divideParam.trainRatio = 60/100;
myNet.divideParam.valRatio = 20/100;
myNet.divideParam.testRatio = 20/100;

% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
myNet.performFcn = 'crossentropy';  % Cross-Entropy

% Choose Plot Functions
% For a list of all plot functions type: help nnplot
myNet.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
    'plotconfusion', 'plotroc'};

% Setting maximum number of iterations:
net.trainParam.epochs = 1000;

% SPECIFY TRANSFER FUNCTION
 myNet.layers{1}.transferFcn = 'logsig';
 myNet.layers{2}.transferFcn = 'logsig';

% Train the Network
[myNet,tr] = train(myNet,x,t);

% Test the Network
y = myNet(x);
e = gsubtract(t,y);
performance = perform(myNet,t,y)
tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);

% Recalculate Training, Validation and Test Performance
trainTargets = t .* tr.trainMask{1};
valTargets = t .* tr.valMask{1};
testTargets = t .* tr.testMask{1};
trainPerformance = perform(myNet,trainTargets,y)
valPerformance = perform(myNet,valTargets,y)
testPerformance = perform(myNet,testTargets,y)

% Measure performance based on Mean Square Error
MSE = mse(myNet,t,y)

% View the Network
 view(myNet)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotconfusion(t,y)
%figure, plotroc(t,y)

% Deployment
% Change the (false) values to (true) to enable the following code blocks.
% See the help for each generation function for more information.
if (false)
    % Generate MATLAB function for neural network for application
    % deployment in MATLAB scripts or with MATLAB Compiler and Builder
    % tools, or simply to examine the calculations your trained neural
    % network performs.
    genFunction(myNet,'myNeuralNetworkFunction');
    y = myNeuralNetworkFunction(x);
end
if (false)
    % Generate a matrix-only MATLAB function for neural network code
    % generation with MATLAB Coder tools.
    genFunction(net,'myNeuralNetworkFunction','MatrixOnly','yes');
    y = myNeuralNetworkFunction(x);
end
if (false)
    % Generate a Simulink diagram for simulation or deployment with.
    % Simulink Coder tools.
    gensim(net);
end
