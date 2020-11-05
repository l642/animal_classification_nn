function [animal location]=march23_class_test(f2,nclus,f1,choice)
animal=[];
location=[];
hblob = vision.BlobAnalysis;
hblob.AreaOutputPort = false;
hblob.CentroidOutputPort = false;
hblob.MinimumBlobArea=4000;
hblob.ExcludeBorderBlobs=true;
% color=uint8([255 255 255]);
% shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',color);

class_name{1}='tiger';
class_name{2}='leopard';
class_name{3}='bear';
class_name{4}='lion';
count=0;
for k=1:nclus
    f2=[zeros(size(f2,1),1) f2 zeros(size(f2,1),1);
        zeros(1,size(f2,2)+2)];
    
    obj1=f2==k;
   
   
%     f1=f1(1:size(obj1,1),1:size(obj1,2));
    %             figure;imshow(obj1);
    
%     obj1=imopen(obj1,se);
%     obj2=uint8(obj1).*f1;
    
    bbox=step(hblob,obj1);
    if ~isempty(bbox);
        count=count+1;
        for l=1:size(bbox,1)
            obj=f1(bbox(l,2):bbox(l,2)+bbox(l,4)-1,bbox(l,1):bbox(l,1)+bbox(l,3)-1);
            
            if choice==2
                feat=glcm_features(obj,16);
                net=load('glcm_network.mat');
                net=net.net_glcm;
            elseif choice==3
                [sum_th sum_rho peaks peaks_ind]=fourier_descriptor_classification(obj);
                feat=[sum_rho];
                net=load('fourier_network.mat');
                net=net.net_sumrho;
            end
            
            
            clss1=net(feat.');
            
            if max(clss1)>=0
                clss=vec2ind(clss1);
                %                 figure;imshow(obj);
                %                 title(class_name{clss});
                animal{end+1}=class_name{clss};
                location{end+1}=bbox(l,:);
%                 f3=step(shapeInserter,f3,location{end});
            else
                animal{end+1}='not classified';
                location{end+1}=[1 1 1 1];
            end
            
            
        end
    
        
    end
    
    
end

if count==0
    animal{1}='foreground not detected';
end
