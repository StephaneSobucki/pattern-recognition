function decision = weakClassif(x,theta,p)
%WEAK Summary of this function goes here
%   Detailed explanation goes here
if p == 1
    for i = 1:length(x)
        if x(i) < theta
            x(i) = 1;
        else
            x(i) = -1;
        end
    end
else
    for i = 1:length(x)
        if x(i) > theta
            x(i) = 1;
        else
            x(i) = -1;
        end
    end
end

decision = x;

