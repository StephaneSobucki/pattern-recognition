clc; clear all; close all;

% X = [1 2 3 4 5 6 7 8 9 10]';
% Y = [1 1 1 -1 -1 1 +1 -1 -1 1]';

X = [6, 7, 9, 9, 8, 10, 10, 8; 3, 3, 5, 6, 4, 4, 2, 2]';
Y = [1 1 1 1 -1 -1 -1 -1]';

m = length(X);
for i = 1:m
    weights(i) = 1/m;
end

T = 5;
alpha_t = [];
Hx = zeros(1,m);
h = zeros(1,m);
eps = 1e-8;
error_percent_tab = [];
for t=1:T
    [theta(t), p(t), n(t), error(t), error_tab(t,:)] = bestWeakClassif(X,Y,weights(t,:));
    alpha_t(t) = 0.5*log((1-error(t))/error(t));
    h(t,:) = weakClassif(X(:,n(t)),theta(t),p(t));
    for i = 1:m
        if h(t,i) ~= Y(i)
            weights(t+1,i) = weights(t,i)*exp(alpha_t(t));
        else
            weights(t+1,i) = weights(t,i)*exp(-alpha_t(t));
        end
    end
    weights(t+1,:) = weights(t+1,:)./sum(weights(t+1,:));
    Hx = sign(sum(alpha_t'.*h));
    error_percent = 1-sum(Hx' == Y)/m;
    error_percent_tab = [error_percent_tab, error_percent]; 
    if(length(error_percent_tab) > 1)
        if(error_percent_tab(t-1) - error_percent_tab(t) < eps)
            T = t;
            break;
        end
    end
end
figure();
plot(1:T,error_percent_tab,'r-');

figure();
plotBoundaries(X,Y,theta,alpha_t,p,n);