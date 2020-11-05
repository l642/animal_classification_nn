function [f2 nclus]=march_23_seg(f1,choice)

%RETURN NCLUS AND F2

blk_size=16;
frame_no=1;
nclus=2;
se=strel('square',blk_size);


f1=rgb2gray(f1);
[m n]=size(f1);

%divide img into blk_size sized blocks
nblk_i=floor(m/blk_size)-1;
nblk_j=floor(n/blk_size)-1;
for i=1:nblk_i
    for j=1:nblk_j
        blk=f1(blk_size*(i-1)+1:blk_size*(i),blk_size*(j-1)+1:blk_size*(j));
        [sum_th sum_rho peaks peaks_ind]=fourier_segmentation_features(blk);
        glcmfeat=glcm_features(blk,16);
        if choice==2
            feat=[glcmfeat];
        elseif choice==3
            feat=[ peaks peaks_ind];
        end
        %                 feat=[sum_rho];
        %         feat=[sum_th sum_rho];
        
        peak_feat(:,i,j)=feat; %1 image=horizontal plane in 3d, downward cols=features of that image
    end
end


peak_feat_reshape=reshape(peak_feat,numel(feat),nblk_i*nblk_j);

%================== kmeans ===================
[idx ctrs sumD]=kmeans(peak_feat_reshape.',2,'emptyaction','drop');
sumDmean=mean(sumD);

idx2=reshape(idx.',nblk_i,nblk_j);

for cl=3:5
    [idx ctrs sumD]=kmeans(peak_feat_reshape.',cl,'emptyaction','singleton','start','uniform');
    
    sumDmean2=mean(sumD);
    if sumDmean2>sumDmean
        idx2=reshape(idx.',nblk_i,nblk_j);
        nclus=cl;
        
    end
    sumDmean=sumDmean2;
end

for i=1:nblk_i
    for j=1:nblk_j
        f2(blk_size*(i-1)+1:blk_size*(i),blk_size*(j-1)+1:blk_size*(j))=idx2(i,j);
        
    end
end
% figure;imagesc(f2);
f1=f1(1:size(f2,1),1:size(f2,2));

%---------------------------------------------------------------------




