function y = predict(t, x)
% t is a structure with four entries:
% t.p is a vector with the index of each node's parent node
% t.inds is the rows of X in each node (non-empty only for leaves)
% t.bestFeatures is a vector with the feature used to split at each decision node 
% t.bestVals is a vector with the feature value used to split at each decision node  
% t.pred is a vector with y prediction at each leaf node and 0 for decision nodes

node = 1; % node number

% ====================== YOUR CODE HERE ======================
% check if the current node is a decision node
while isempty(t.inds{node})
    a = find(t.p==node);
    if x(t.bestFeatures(a(1)))
        node = a(1);
    else
        node = a(2);
    end
end







% predict based on the data in the leaf

y= t.pred(node);




% =============================================================
end
