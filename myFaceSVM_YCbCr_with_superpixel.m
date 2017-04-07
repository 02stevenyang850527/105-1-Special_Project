% my face recognition using SVM from LIBSVM
addpath('ERS');
% add superpixel-related functions
% convert RGB to YCbCr
T = [0.299, 0.587, 0.114; -0.169, -0.331, 0.5; 0.5, -0.419, -0.081];
% test data
im_test = imread('TestImagesForPrograms\24.jpg');  
[n,m,~] = size(im_test);
% using superpixel
num = 1500;
% im_test1 = mysuperpixel(im_test,num);
im_test1 = im_test;
% transform RGB to YCbCr
feature_test = double(reshape(im_test1, [n*m,3]));
label_2 = double(zeros(n*m,1));
feature_test1 = T*(feature_test)';
feature_test1 = feature_test1';
% scaling
% mf = mean(feature_YCbCr);
% nrm=diag(1./std(feature_YCbCr,1));
% feature_1 = (feature_YCbCr -ones(N1 + N2,1)*mf)*nrm;
% feature_2 = (double(feature_test1) -ones((n*m),1)*mf)*nrm;
%SVM
%model = myFace_train;
%test
[predicted, accuracy, d_values] = svmpredict(label_2, feature_test1, model);
% predicted: the SVM output of the test data
im_recover = reshape( predicted, [n,m]);
% morphology
t1 = 3;  % for opening method 3
t2 = 6;  % for closing method 5
se = [0,1,0; 1,1,1; 0,1,0];
im_recover = myMorphology(im_recover, se, t1,t2);

% do the face mask
[mask, face_location] = mySkinMask(im_recover);
% get eyemap & mouthmap
[cnt,~] = size(face_location);
for k = 1: cnt
    eyemap = getEyemap(im_test, face_location(k,:));
    mouthmap = getMouthmap(im_test, face_location(k,:));
    [loc, eye, mouth] = geteye_and_mouth(eyemap, mouthmap);
    is_detected = check_eye_and_mouth(eye, mouth);
    if (is_detected == 1)
        se = [0,1,0; 1,1,1; 0,1,0];
        mask = imdilate(mask,se);
        mask = imerode(mask,se);
    face = zeros(n,m,3);
    [row, col] = find(mask == 255);
    idx = sub2ind(size(mask),row, col);
    face(idx) = im_test(idx); face(idx + n*m) = im_test(idx + n*m); face(idx + 2*n*m) = im_test(idx + 2*n*m);
    figure; image(uint8(face));
    else
    mask = imdilate(mask,se);
    mask = imerode(mask,se);
    colormap('gray');image(mask*255);
    fprintf('face not found\n');
    end;
end;
% result
%colormap(gray); image(im_recover .*255);
figure; image(uint8(im_test));
%figure; colormap(gray); image(mask-255*loc);