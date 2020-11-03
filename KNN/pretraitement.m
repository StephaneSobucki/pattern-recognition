clc;
close all;
clear all;
name=['B'; 'C'; 'D'; 'E'; 'F'; 'G';'H';'I';'J';'K'];

tab_1=zeros(2500,145);
tab_2=tab_1;
tab_3=tab_1;
filter_size = 12;
for lettre=1:10
    for k=1:250
        name1=['data/' name(lettre,:) num2str(k) '.bmp'];
        I=imread(name1);
        [M,N]=size(I);
        nbpoint=0;
        row_value=0;
        column_value=0;
        offset = 5;
        for i = 1 : M
            for j = 1 : N
                if I(i,j)==255
                    row_value=row_value+i;%sommation pondéré en x
                    column_value=column_value+j;%sommation pondéré en y
                    nbpoint=nbpoint+1;% nombre de point total
                end
            end
        end
        row_value_nm=round(row_value/nbpoint);%normalisation sur x
        column_value_nm=round(column_value/nbpoint);%normalisation sur y
        left_most_pixel = find(any(I,1),1); %first column non-zero
        top_most_pixel = find(any(I,2),1);
        right_most_pixel = find(any(I,1), 1, 'last' );
        bottom_most_pixel = find(any(I,2), 1, 'last' );
        width = max(abs(right_most_pixel-column_value_nm),abs(left_most_pixel-column_value_nm))+offset;
        height = max(abs(top_most_pixel-row_value_nm),abs(bottom_most_pixel-row_value_nm))+offset;
        longest = max(width,height);
        
        I1 = imcrop(I,[left_most_pixel-offset,top_most_pixel-offset,2*offset+right_most_pixel-left_most_pixel,2*offset+bottom_most_pixel-top_most_pixel]);
        I1 = imresize(I1,[filter_size filter_size]);
        I1=I1(:)';
        %Methode 2
        I2 = imcrop(I,[column_value_nm-width row_value_nm-height 2*width 2*height]);
        I2 = imresize(I2,[filter_size filter_size]);
        I2=I2(:)';
        %Methode 3
        I3 = imcrop(I,[column_value_nm-longest row_value_nm-longest 2*longest 2*longest]);
        I3 = imresize(I3,[filter_size filter_size]);
        I3=I3(:)';   

        tab_1((lettre-1)*250+k,:)=[I1 lettre];
        tab_2((lettre-1)*250+k,:)=[I2 lettre];
        tab_3((lettre-1)*250+k,:)=[I3 lettre];
    end
end
save tab_1 tab_1;
save tab_2 tab_2;
save tab_3 tab_3;  