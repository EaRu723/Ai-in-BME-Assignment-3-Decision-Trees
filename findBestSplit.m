function [best_feature, best_val, best_ig] = findBestSplit(X, Y)

%  ------------ Instructions --------------------------------------------------
% 
%  You may find that if you select a feature with the maximum IG, and then 
%  select a best split value for that feature, you may not get the maximum IG. 
%  The reason for that is while the best feature selected may potentially offer 
%  a maximum IG, a binary split may not be able to achieve that (e.g. when there 
%  are more than two classes for the best feature). Therefore, it would be 
%  better to search through all possible splits of all features to find the best 
%  split with the maximum information gain.
%  
%  you may find function unique() useful.

%initialization 
best_ig = -inf; %best information gain; 
best_feature = 0; %best feature to split on
best_val = 0; % best value to split on

% ====================== YOUR CODE HERE ======================
for i = 1:size(X,2)
    feature = X(:,1)
    
    values = unique(feature);
    splits = 0.5*(values(1:end-1) + values(2:end));
    
    if numel(values) <2
        continue
    end
    
    binary_matrix = double(repmat(feature, [1 numel(splits)]) < repmat(splits', [numel(feature) 1 ]));
    
    H = ent(Y);
    
    H_conditional = zeros(1, size(binary_matrix,2));
    for k = 1:size(binary_matrix,2);
        H_conditional(k) = cond_ent(Y, binary_matrix(:,k));
    end
    
    IG = H - H_conditional;
    
[val ind] = max(IG);
if val > best_ig
    best_ig = val;
    best_feature = i
    best_val = splits(ind);
end
end



















% =============================================================
end
