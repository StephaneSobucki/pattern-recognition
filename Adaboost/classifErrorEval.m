
function [error_tab, error] = classifErrorEval(Y,decision,weights)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
error_tab = (Y ~= decision).*weights';
error = sum(error_tab);
end

