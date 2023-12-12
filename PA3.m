% AI in BME Class - Programming Assignment 3 - PART II
% Decision Tree

%  ------------ Instructions --------------------------------------------------
% 
%  This file contains code that helps you get started. 
%  You will need to complete the excercise in PA3test.m first.
%   and test the following functions in this exericse:
%
%     stoppingCriteria.m
%     predict.m  
%
%  Although you do not need to edit buildSubtree.m, you need to read
%  buildSubtree.m to understand the tree building process and the how 
%  tree structure information is stored, so that you can access the information
%  to complete predict.m

%% Initialization
clear ; close all; clc

%% Load the data
% 70% of the data used for training, and the rest 30% used for testing
M = load('PA3data.txt');
[m,n] = size(M);
Per = 0.7;    % 70% data used for training
idx = randperm(m);
M_training = M(idx(1:round(Per*m)),:);
M_testing = M(idx(round(Per*m)+1:end),:);

% We want to predict the last column NSP (Normal=1; Suspect=2; Pathologic=3)...
Y = M_training(:,end);
% ...based on the other features (all but the last column)
X = M_training(:,1:end-1);

% feature names
cols = {'LB', 'AC', 'FM', 'UC', 'DL','DS', 'DP','ASTV','MSTV', 'ALTV',...
    'MLTV', 'Width', 'Min', 'Max', 'Nmax', 'Nzeros', 'Mode', 'Mean', ...
    'Median', 'Variance', 'Tendency'};
    
%% ====== Part 1: Build the decision tree =====================================
% Builds a decision tree to predict Y from X.  The tree is grown by
% recursively splitting each node using the feature value that gives the best
% information gain until the leaf is consistent or all inputs have the same
% feature values.
%
% X is an mxn matrix, where m is the number of points and n is the
% number of features.
% Y is an mx1 vector of classes 
%
% RETURNS t, a structure with five entries:
% t.p is a vector with the index of each node's parent node
% t.inds is a cell array, recording the rows of X in each node (non-empty only for leaves)
% t.bestFeatures is a vector with the feature used to split at each decision node 
% t.bestVals is a vector with the feature value used to split at each decision node 
% t.pred is a vector with y prediction at each leaf node and 0 for decision nodes
% t.label is a vector showing the decision that was made to get to that node

inds = {1:size(X,1)}; % A cell per node containing indices of all data in that node
p = 0; % Vector contiaining the index of the parent node for each node
labels = {}; % A label for each node
bestFeatures = 0; % best feature split on of the parent node for each node
bestVals = 0; % best value split on of the parent node for each node


% Create tree by splitting on the root
[inds p labels bestFeatures bestVals] = buildSubtree(X, Y, cols,inds, p, labels, bestFeatures, bestVals, 1);

Ypred = zeros(size(p),1); %

for i = 1:size(p)
  if ~isempty(inds{i})
    if numel(unique(Y(inds{i}))) == 1
      Ypred(i)= unique(Y(inds{i}));
    elseif size(unique(X(inds{i}),'rows'),1) == 1
      Ypred(i)= -1; % inconsistent data
    end
  end
end

t.inds = inds;
t.p = p;
t.bestFeatures = bestFeatures;
t.bestVals = bestVals;
t.pred = Ypred;
t.labels = labels;

%% Display the tree
displayTree(t);

fprintf('\nProgram paused. Press enter to continue.\n');
pause;
%% ====== Part 2: Accuracy on Training and Testing Data sets ===================        

% Compute accuracy on our training set
for i=1:size(Y)
  p(i) = predict(t, X(i,:));
end
fprintf('Training set prediction accuracy: %.2f %%\n', mean(double(p == Y)) * 100);
fprintf('Expected accuracy: 99.7%% (approx)\n');

% Compute accuracy on our testing set
Ytest = M_testing(:,end);
Xtest = M_testing(:,1:end-1);
for i=1:size(Ytest)
  p(i) = predict(t, Xtest(i,:));
end
fprintf('Testing set prediction accuracy: %.2f%%\n', mean(double(p == Y)) * 100);
fprintf('Expected accuracy: 84%%(approx)\n');

