function [ sum_th sum_rho peaks peaks_ind] = fourier_segment_feats( img )


if size(img,3)==3
    img=rgb2gray(img);
end
img=double(img);

%Find dft
% img_dft=angle((fft2(img)));
img_dft=abs((fft2(img)));
[m n]=size(img_dft);

%Cartesian coordinates
k=1;
for i=1:n           %x=horz axis,y=vertical axis
    for j=1:m
    x(k)=i;
    y(k)=j;
    k=k+1;
    end
end
z1=reshape(img_dft.',1,m*n); %x,y,z is image in cartesian co-ordinates

%convert to polar coordinates
[th rho z]=cart2pol(x,y,z1);
th=th.*180./pi;
th=round(th);
rho=round(rho);
range_th=max(th)+1;
range_rho=max(rho)+1;
sum_th=zeros(1,range_th);
sum_rho=zeros(1,range_rho);


%find descriptors
for i=1:length(th)
    sum_th(th(i)+1)=sum_th(th(i)+1)+z(i);
end

for i=1:length(rho)
    sum_rho(rho(i)+1)=sum_rho(rho(i)+1)+z(i);
end

peaks_ind=-4*ones(1,floor(numel(sum_rho)/2));
peaks=zeros(1,floor(numel(sum_rho)/2));
[peaks1 peaks_ind1]=findpeaks(sum_rho,'SORTSTR','descend');
peaks_ind(1:numel(peaks_ind1))=peaks_ind1;
peaks(1:numel(peaks_ind1))=peaks1;

end

