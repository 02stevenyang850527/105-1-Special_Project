function is_detected = check_eye_and_mouth(eye, mouth)
    is_detected = 0;
    [m1,~] = size(eye);
    [m2,~] = size(mouth);
    if (m1 == 2 && m2 == 1)
        x1 = eye(1,2); y1 = eye(1,1);
        x2 = eye(2,2); y2 = eye(2,1);
        x3 = mouth(2); y3 = mouth(1);
        if (y1 < y3 && y2 < y3)
            v1 = [x1-x2;y1-y2];
            R = [-v1(2); v1(1)];
            cos_theta = (v1(1)*R(1) + v1(2)*R(2))/(norm(v1)*norm(R));
            if (abs(cos_theta) < 0.088)  % theta is about 85 degrees
                a = [x3-x1; y3-y1];
                b = [x3-x2; y3-y2];
                if (norm(a)/norm(b) > 0.6 && norm(a)/norm(b) < 1.4)
                    is_detected = 1;
                end;
            end;
        end;
    else
        fprintf('too many input candidates\n');
    end;
end