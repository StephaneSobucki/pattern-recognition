function [Conf, Taux] = calc_res(liste_class,liste_vrai)
%CALC_RES Summary of this function goes here
%   Detailed explanation goes here
Conf = zeros(10,11);
Taux = zeros(10,1);
%TP Conf(1,1), FP Conf(1,2), FN Conf(2,1) & TN Conf(2,2)
for i = 1:10
    for j = 1:50
        if liste_class((i-1)*50+j) == liste_vrai((i-1)*50+j)
            Conf(i,i) = Conf(i,i) + 1;
        elseif liste_class((i-1)*50+j) == -1
            Conf(i,end) = Conf(i,end) + 1;    
        else
            Conf(i,liste_class((i-1)*50+j)) = Conf(i,liste_class((i-1)*50+j)) + 1;
        end
    end
    Taux(i) = Conf(i,i)/sum(Conf(i,:));
end
end

