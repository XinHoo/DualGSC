
clear;	
load('patch_group.mat');


%Construct graphs, and graph laplacians
rng('default');
options.WeightMode = 'HeatKernel';options.t = 1;
Wc = constructW(patch_in', options);%灰度值%
Wr = constructW(patch_in, options);
Lc = graph_laplacian(Wc);% 
Lr = graph_laplacian(Wr);
params = struct();
params.Y = patch_in';
params.D = patch_group_D;
params.T = T;
params.alpha = 1; params.Lr = Lr;
params.beta  =1;  params.Lc = Lc;
params.Z = OMP(U,patch_in',3);
X = DUAL_ADMM(params);
patch_group = D*X;