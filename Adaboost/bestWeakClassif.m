function [theta,p,n,error,error_tab] = bestWeakClassif(X,Y,weights)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
param_array = [];
for n = 1:size(X,2)
    for theta = min(X(:,n)):0.5:max(X(:,n))
        for p = [-1,1]
            decision = weakClassif(X(:,n),theta,p);
            [error_tab, error] = classifErrorEval(Y,decision,weights);
            param_array = [param_array; horzcat([theta, p, n, error], error_tab')];
        end
    end
end
[~, index] = min(param_array(:,4));

theta = param_array(index,1);
p = param_array(index,2);
n = param_array(index,3);
error = param_array(index,4);
error_tab = param_array(index,5:end);

