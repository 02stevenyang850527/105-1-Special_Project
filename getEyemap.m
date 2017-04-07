function eyemap = getEyemap(im_test, face_location)
%im_test = imread('TestImagesForPrograms\22.jpg');
[n,m,~] = size(im_test);
mask = zeros(n,m);
mask(face_location) = 255;
se = [0,1,0; 1,1,1; 0,1,0];
mask = imdilate(mask,se);
mask = imerode(mask,se);
face = zeros(n,m,3);
[row, col] = find(mask == 255);
idx = sub2ind(size(mask),row, col);
face(idx) = im_test(idx); face(idx + n*m) = im_test(idx + n*m); face(idx + 2*n*m) = im_test(idx + 2*n*m);
T = [0.299, 0.587, 0.114; -0.169, -0.331, 0.5; 0.5, -0.419, -0.081];
feature_test = double(reshape(face, [n*m,3]));
feature_test1 = T*(feature_test)';
feature_test1 = feature_test1';
im_recover = double(reshape(feature_test1, [n,m,3]));
% image in YCbCr coordinate
Y = im_recover(:,:,1);
Cb = im_recover(:,:,2);
Cr = im_recover(:,:,3);
Cr_MAX = max(max(im_recover(:,:,3)));
Eyemapc = (Cb.^2 + (Cr_MAX - Cr).^2 + (Cb./Cr))/3;
% got Eyemapc
SE = [0,0,0,0,0,1,0,0,0,0,0;
      0,0,1,1,1,1,1,1,1,0,0;
      0,1,1,1,1,1,1,1,1,1,0;
      0,1,1,1,1,1,1,1,1,1,0;
      1,1,1,1,1,1,1,1,1,1,1;
      0,1,1,1,1,1,1,1,1,1,0;
      0,1,1,1,1,1,1,1,1,1,0;
      0,0,1,1,1,1,1,1,1,0,0;
      0,0,0,0,0,1,0,0,0,0,0];
Eyemapl = myNegation(imerode(Y,SE));
% got Eyemapl
Eyemapt_can = extractTexture(im_test); % get 8 Eyemapt 
[~,~,page] = find(Eyemapt_can == max(max(max(Eyemapt_can))));
Eyemapt = Eyemapt_can(:,:,page(1));
eyemap = (myGeneralAnd(Eyemapl,Eyemapc)) .* Eyemapt ;
end