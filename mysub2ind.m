function idx = mysub2ind (A, x, y)
n = A(1);
m = A(2);
[n1,~] = size(x);
[n2,~] = size(y);   % n1 should be the same as n2
    if (n1 ~= n2)
        fprintf('fuck\n');
    end;
idx = zeros(n1,1);
    for k = 1: n1
        if (x(k) > n)
            x(k) = n;
        end;
        if (y(k) > m)
            y(k) = m;
        end;
            idx(k) = (y(k)-1)*n + x(k);
    end;
end