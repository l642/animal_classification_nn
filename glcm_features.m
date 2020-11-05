function [ features ] = glcm_features( img,n_levels )

%Function to compute glcm features

G=glc_matrix(img,n_levels);
N=sum(sum(G));
p=G/N;
[m n]=size(G);
tol=1e-4;

r=1:m;
c=1:n;

prow=(sum(p,2));      %sum(p,2)=sum of cols of p=marginal probability of rows
pcol=(sum(p,1));      %sum(p,1)=sum of rows of p=marginal probability of cols
mean_r=sum(r.*(prow.'));      %row mean=>
mean_c=sum(c.*pcol);      %col mean=>
var_r=sum(((r-mean_r).^2).*(prow.'));
var_c=sum(((c-mean_c).^2).*pcol);
sigma_r=sqrt(var_r);
sigma_c=sqrt(var_c);

%1) Maximum Probability
max_p=max(max(p));

%2)Correlation
temp=((r-mean_r).')*(c-mean_c);     %for summantion over i,j
correlation=sum(sum(temp.*p))./(sigma_r*sigma_c);

%3)Contrast
contrast=0;
for i=1:m
    for j=1:n
        contrast=contrast + ((i-j)^2)*p(i,j);
    end
end

%4)Uniformity (energy)
uniformity=sum(sum(p.^2));

%5)Homogeneity
homogeneity=0;
for i=1:m
    for j=1:n
        homogeneity=homogeneity + p(i,j)/(1 + abs(i-j));
    end
end

%6)Entropy
entropy= -1*sum(sum(p.*(log2(p+tol))));

% features.MaxProbability=max_p;
% features.Contrast=contrast;
% features.Uniformity=uniformity;
% features.Homogeneity=homogeneity;
% features.Entropy=entropy;
% features.Correlation=correlation;

features=[max_p contrast uniformity homogeneity entropy correlation].';


end

