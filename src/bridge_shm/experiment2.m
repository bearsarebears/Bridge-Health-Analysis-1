c = who('rfeatures');
if numel(c) == 0
	clc; close all; clear all;
data_file = 'resampled_data';
K = 8;
feature_type = 'haar wavelet';
depth = 7;
classifier_type = 'svm';
n_experiments = 1;

%% Compute All Features;
load(data_file);
tic;
f0 = {'T00','T01','T02','T03','T04','T05','T06','T07','T08','T09','T10'};
f1 = {'S3','S4','S5','S6'};
f2 = {'F','B'};
f3 = {'WF','WB','SF', 'SB'};
rfeatures = feature_compute(rdata,f0,f1,f2,f3,feature_type,depth);
feature_time = toc;
clear rdata;
end
%% run experiment
for i = 1:n_experiments
	switch i
		case 1
		f1 = {'S3','S4','S5','S6'};
		f2 = {'F'};
	end
	[feature_matrix,class_labels] = load_matrix(rfeatures,f0,f1,f2,0);

	experiments{i} = ...
    		experiment(feature_matrix,class_labels,K,classifier_type);
	clear feature_matrix;clear class_labels; pack;
end
