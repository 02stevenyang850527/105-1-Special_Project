function model = myFace_train()
% input training data
feature_RGB_face = xlsread('face.xls');  % data of face
feature_RGB_notface = xlsread('notface.xls'); % data of not-face
feature_RGB = [feature_RGB_face; feature_RGB_notface];

% first column: R
% second column: G
% third column: B
[N1,~] = size(feature_RGB_face);
[N2,~] = size(feature_RGB_notface);
label_1 = [ones(N1,1); zeros(N2,1)];
% 1: face, 0: not-face

% convert RGB to YCbCr
T = [0.299, 0.587, 0.114; -0.169, -0.331, 0.5; 0.5, -0.419, -0.081];
feature_YCbCr = T *(feature_RGB)';
feature_YCbCr = feature_YCbCr';
model = svmtrain(label_1, feature_YCbCr,'-c 1 -g 0.008');
end