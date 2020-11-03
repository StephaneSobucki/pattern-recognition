clear all;
close all

load tab_2
%time_vec = zeros(1,150);
%taux_vec = zeros(1,150);
taille=size(tab_2,2)-1;
for nb_ref = 150

    Nb_classe = 10;

    base_ref=zeros(nb_ref*Nb_classe,taille);
    etiq_ref=zeros(nb_ref*Nb_classe,1);
    base_val=zeros(50*Nb_classe,taille);
    etiq_val=zeros(50*Nb_classe,1);
    base_test=zeros(50*Nb_classe,taille);
    etiq_test=zeros(50*Nb_classe,1);

    mean_ref=zeros(Nb_classe,taille);
    S = zeros(Nb_classe, taille, taille);
    for lettre =1:Nb_classe
        Pix=find(tab_2(:,end)==lettre);
        %base de reference
        base_ref(nb_ref*(lettre-1)+1 : nb_ref*lettre, 1 : taille) = tab_2(Pix(1:nb_ref), 1 : taille) ;
        %etiq_ref(nb_ref*(lettre-1)+1 : nb_ref*lettre) = tab_2(Pix(1:nb_ref),end) ;
        mean_ref(lettre,:)=mean(base_ref(nb_ref*(lettre-1)+1 : nb_ref*lettre, 1 : taille));
        etiq_ref(lettre) = lettre;
        S(lettre,:,:) = cov(base_ref(nb_ref*(lettre-1)+1 : nb_ref*lettre,1 :taille));

        % base de validation
        base_val(50*(lettre-1)+1 : 50*lettre, 1 : taille) =tab_2(Pix(151:200), 1 : taille) ;
        etiq_val(50*(lettre-1)+1 : 50*lettre) = tab_2(Pix(151:200), end) ;

         % base de test
        base_test(50*(lettre-1)+1 : 50*lettre, 1 : taille) =tab_2(Pix(201:250), 1 : taille) ;
        etiq_test(50*(lettre-1)+1 : 50*lettre) = tab_2(Pix(201:250), end) ;

    end

    confusion=zeros(Nb_classe, Nb_classe+1);
    %evolution_taux = zeros(1,100);
    for k = 1:1
        tic;
        for num_ex=1:size(base_val,1)
            ex=base_val(num_ex,:);
            [label_classif] = test_ppv(mean_ref,etiq_ref,ex,k,S);
            classe(num_ex) = classe_maj(label_classif);
        end

        time=toc;
        [Conf, Taux] = calc_res(classe,etiq_val);

        confusion=[Conf, Taux];
        time
        mean(Taux);
        %taux_vec(nb_ref)=mean(Taux);
        %time_vec(nb_ref)=time;
    end
    %plot(1:100,evolution_taux(k));
end
%%
disp("Matrice de confusion:")
disp(Conf)
disp(sprintf("Taux de bonne classification: %2.2f %%",mean(Taux)*100))
% plot(1:150,time_vec);
% hold on;
% plot(1:150,taux_vec);
% xticks(0:10:150); 
% xlabel("Nombre d'exemples dans baseref");
% legend({"Temps de calcul","Taux de bonne classification"});