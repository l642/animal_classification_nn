function [ sum_th sum_rho peaks peaks_ind ] = npeaks_dft3( img )

%Function to find number of peaks in dft of image
%n_peaks=number of peaks
if size(img,3)==3
    img=rgb2gray(img);
end
img=double(img);

%Find dft
m=128;
n=228;
img_dft=abs((fft2(img,m,n)));


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
range_th=max(th)-min(th)+1;
range_rho=max(rho)-min(rho)+1;
sum_th=zeros(1,range_th+1);
sum_rho=zeros(1,range_rho+1);

sum_rho=zeros(1,range_rho+1);

%find descriptors
for i=1:length(th)
    sum_th(th(i)+1)=sum_th(th(i)+1)+z(i);
end

for i=1:length(rho)
    sum_rho(rho(i)+1)=sum_rho(rho(i)+1)+z(i);
end


peaks_ind11=-4*ones(1,floor(numel(sum_rho)/3));
peaks11=zeros(1,floor(numel(sum_rho)/3));
[peaks1 peaks_ind1]=findpeaks(sum_rho,'SORTSTR','descend');
peaks_ind11(1:numel(peaks_ind1))=peaks_ind1;
peaks11(1:numel(peaks_ind1))=peaks1;

peaks_ind=peaks_ind11(1:50);
peaks=peaks11(1:50);


end

