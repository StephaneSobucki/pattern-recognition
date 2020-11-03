function [label_classif] = test_ppv(base_ref,label_ref,ex,k,S)
%
%function [label_classif] = test_ppv(base_ref,label_ref,ex,k)
%
% IN  --> base_ref      : classe des plus proches voisins
%     --> label_ref     : 
%     --> ex            : exemple dans la base de validation
%     --> k             : nombre de voisins observ�s
%
% OUT --> label_classif : vecteur des labels des k plus proches voisins
error = zeros(1,size(base_ref,1));
idx = 1:size(base_ref,1);
for i = 1:size(base_ref,1)
    %error(i) = sqrt(sum((base_ref(i,:) - ex).^2));
    error(i) = Mahal(ex,base_ref(i,:),pinv(reshape(S(i,:,:),size(S(i,:,:),1)*size(S(i,:,:),2),size(S(i,:,:),3))));
end

[~, index] = sort(error,'ascend');
idx = idx(index);

label_classif = label_ref(idx(1:k));
