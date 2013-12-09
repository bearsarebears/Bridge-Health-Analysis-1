% WARNING: clears clutter, about to use a lot of memory
clc; close all; clear all;
%%

data_file = 'resampled_data';
libsvm_path = '~/Documents/libsvm-3.17/matlab';
% K-folds to train on
K = 9;
f0 = {'T00','T01','T02','T03','T04','T05','T06','T07','T08','T09','T10'};
f1 = {'S3','S4','S5','S6'};
%f2 = {'F','B'};
%f3 = {'WF','WB','SF', 'SB'};

%fields{1}.f0 = f0;
%fields{1}.f1 = f1;
%fields{1}.f2 = f2;
%fields{1}.f3 = f3;

%fields{2}.f0 = f0;
%fields{2}.f1 = f1;
%fields{2}.f2 = f2;
%fields{2}.f3 = {'WF','WB'};

%fields{3}.f0 = f0;
%fields{3}.f1 = f1;
%fields{3}.f2 = f2;
%fields{3}.f3 = {'SF', 'SB'};

%fields{4}.f0 = f0;
%fields{4}.f1 = f1;
%fields{4}.f2 = f2;
%fields{4}.f3 = {'SF', 'WF'};

%fields{5}.f0 = f0;
%fields{5}.f1 = f1;
%fields{5}.f2 = f2;
%fields{5}.f3 = {'SB', 'WB'};

fields{1}.f0 = f0;
fields{1}.f1 = f1;
fields{1}.f2 = {'F'};
fields{1}.f3 = {'SF','SB','WF','WB'};
f2 = fields{1}.f2;
f3 = fields{1}.f3;


n_field_instances = numel(fields);

% define feature types
features{1}.type = 'wavelet';
features{1}.basis = 'haar';
features{1}.depth = 7;
features{1}.prefilter = 'center';
features{1}.selection = '';

%features{2}.type = 'packet';
%features{2}.basis = 'haar';
%features{2}.depth = 7;
%features{2}.prefilter = 'center';
%features{2}.selection = 'pca';

features{2}.type = 'wavelet';
features{2}.basis = 'coif3';
features{2}.depth = 7;
features{2}.prefilter = 'center';
features{2}.selection = '';

%features{4}.type = 'packet';
%features{4}.basis = 'coiflet';
%features{4}.depth = 7;
%features{4}.prefilter = 'center';
%features{4}.selection = 'pca';

%features{2}.type = 'haar packets';
%features{2}.depth = 5;

n_feature_instances = numel(features);

classifiers{1}.type = 'svm-matlab';
classifiers{1}.kernel = 'polynomial';

%classifiers{2}.type = 'svm-matlab';
%classifiers{2}.kernel = 'linear';

%classifiers{3}.type = 'svm-matlab';
%classifiers{3}.kernel = 'rbf';

n_class_instances = numel(classifiers);
%% Iterate over All Feature instances
experiments = cell(n_feature_instances,n_class_instances,n_field_instances);

for f = 1:n_feature_instances
	load(data_file);
	tic;
	rfeatures = feature_compute(rdata,f0,f1,f2,f3,features{f});
	clear rdata;
	time{f}.features =  toc;
	features{f}.fields = fields;
	features{f}.classifiers = classifiers;
        for c = 1:n_class_instances
		for i = 1 : n_field_instances
			% loads into columns
			[feature_matrix,class_labels] = load_matrix(rfeatures,fields{i}.f0,fields{i}.f1,fields{i}.f2,0);
			experiments{f,c,i} = experiment(feature_matrix,class_labels,K,features{f},classifiers{c});
			clear feature_matrix;clear class_labels;
		end
	end
end
