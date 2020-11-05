function [ G ] = glc_matrix( img,n_levels )
%Function to compute graylevel co-occurrence matrix----
%G=glcm
%n_levels=no. of quantizatized of gray levels

img=double(img);        %since uint8 division rounds off instead of truncating
[m n]=size(img);
G=zeros(n_levels,n_levels);
div=256/n_levels;       %no. of gray-levels per each quantized level
for i=1:m
    for j=1:n-1
        pixel_1=floor(img(i,j)/div);    %use floor to quantize
        pixel_2=floor(img(i,j+1)/div);
        G(pixel_1+1,pixel_2+1)=G(pixel_1+1,pixel_2+1)+1;  %increment count for gray level pair
    end
end

end

