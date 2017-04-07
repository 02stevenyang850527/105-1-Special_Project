% im: input image
% se: structuring element
% t1: times of opening method
% t2: times of closing method
function result = myMorphology(im, se, t1, t2)
for k = 1:t1
im = imerode(im,se);
end;

for k = 1:t1
im = imdilate(im,se);
end;
%--closing
for k = 1:t2
im = imdilate(im,se);
end;

for k = 1:t2
im = imerode(im,se);
end;
result = im;
end