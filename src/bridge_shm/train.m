function [ model ] = train(rfeatures,labels,classifier)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    switch classifier
        case 'svm' 
            kernel = 'poly';
            isotropic = 0;
            C = 20;
            model.p1 = 1;
            model.kernel = 'linear';
            [model.X,model.A,model.B] = normsv(rfeatures,kernel,isotropic);
            [model.b,model.alpha,model.Ynew,model.cl] = ...
                multiclass(model.X,labels,model.kernel,p1,C,'');
    end
end

