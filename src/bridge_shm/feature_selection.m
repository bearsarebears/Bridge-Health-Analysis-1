function [model, selected_features] = feature_selection(rfeatures,feature_type,train);
	[n_runs,run_len] = size(rfeatures);
	if train
		switch feature_type.selection 
		case 'pca'
			%% first perform mean variance normalization
			model.mean = (sum(rfeatures,1)/n_runs);
			rfeatures = rfeatures - repmat(model.mean,n_runs,1);
			for i = 1:n_runs
				rfeatures(i,:) = rfeatures(i,:)/sqrt(sum(rfeatures(i,:).^2));
			end
			[model.coeff,selected_features] = pca(rfeatures);
			% use pinv because singular to working precision
			model.coeff = pinv(diag(std(rfeatures)))*model.coeff;
		otherwise
			model = [];
			selected_features = rfeatures;
		end
	else
		switch feature_type.selection 
		case 'pca'
			size(rfeatures);
			size(feature_type.model.mean)
			rfeatures = rfeatures - repmat(feature_type.model.mean,n_runs,1);
			for i = 1:n_runs
				rfeatures(i,:) = rfeatures(i,:)/sqrt(sum(rfeatures(i,:).^2));
			end
			selected_features = rfeatures*(feature_type.model.coeff);
		otherwise
			model = [];
			selected_features = rfeatures;
		end
		model = [];
	end
end
	
