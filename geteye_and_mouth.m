function [loc, eye, mouth] = geteye_and_mouth(eyemap, mouthmap)
    [n,m] = size(eyemap);
    loc = zeros(n,m);
    [rr,cc] = meshgrid(1:30);
    C = sqrt((rr-20).^2 + (cc-20).^2) <= 10;
    eyemap = conv2(eyemap,double(C),'same');
    mouthmap = conv2(mouthmap,double(C),'same');
    threshold_eye = 0.8*max(max(eyemap));
    threshold_mouth = 0.5*max(max(mouthmap));
    for k = 1:n*m
            if (eyemap(k) > threshold_eye)
                loc(k) = 1;
            else
                eyemap(k) = 0;
            end;
    end;
    %eye1 = [median(find(loc(1:floor(n*m/2)) == 1)); median(find(loc(floor(n*m/2)+1: end) == 1))];
    [r1,col1] = find(eyemap > threshold_eye);
    A = [r1,col1];
    [~,eye] = kmeans(A,2);
    for k = 1:n*m
            if (mouthmap(k) > threshold_mouth && loc(k) == 0)
                loc(k) = 1;
            end;
    end;
    [r2,col2] = find(mouthmap > threshold_mouth);
    mouth = [median(r2), median(col2)];
end
