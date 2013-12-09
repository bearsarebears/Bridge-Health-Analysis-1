function [confusion, accuracy] = test(model,rfeatures,labels,classifier)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [n_test,feaature_len] = size(rfeatures);
    confusion = zeros(2,numel(labels));
    confusion(2,:) = labels;
    switch classifier.type
    	case 'svm-matlab'
		n_classes = max(labels);
		for n = 1:n_test
        		model_result = zeros(n_classes,1);
			for class = 1:n_classes
				size(rfeatures)
				model_result(class) = svmclassify(model.model{class},rfeatures(n,:));
			end	
			inds = find(model_result);
			if numel(inds) == 0
			    confusion(1,n) = 0;
			else
			    confusion(1,n) = inds(1);
			end
		end
    end
    accuracy = sqrt((confusion(1,:) - confusion(2,:)).^2/n_test);
end

