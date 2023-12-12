% AI in BME Class - Programming Assignment 3 - Part I
% Decision Tree

%  ------------ Instructions --------------------------------------------------
% 
%  This file contains code that helps you get started. 
%  You will need to complete and test the following functions in this exericse:
%
%     ent.m
%     cond_ent.m
%     findBestSplit.m
%     PA3test.m line #61-63

%% Initialization
clear ; close all; clc
       
%% === Part 1: Compute Entropy, Conditional Entropy and Information Gain=======

%-- Test ent(Y) and cond_ent(Y, X) function using the example discussed in class --
% A: 1 -BME; 2 - CS; 3 - History
% B: 1 - in "AI in BME" class; 0 - not in "AI in BME" class;
A = [1 1 2 3 2 1 3 1]';  
B = [1 1 0 0 1 1 0 0]';

% Compute and display entropy for A and B
H_A = ent(A);       %++ you need to complete ent.m +++
H_B = ent(B);
fprintf('Entropy for A is: %.2f\n', H_A);
fprintf('Expected entropy H(A) is: 1.5\n');
fprintf('Entropy for B is: %.2f\n', H_B);
fprintf('Expected entropy H(B)is: 1\n');

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

% Compute and display conditional entropy for B given A
H_B_A = cond_ent(B, A); % ++ you need to complete cond_ent.m ++
fprintf('Conditional entropy for B given A is: %.2f\n', H_B_A);
fprintf('Expected conditional entropy H(B|A)is: 0.66\n');

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%-- Compute ent(Y) and cond_ent(Y,X1) of the Cardiotocography Data --

% Compute and display entropy H(Y), conditional entropy H(Y|X1), 
% and the information gain IG(Y|X1) 
 
% Load the data 
M = load('PA3data.txt');
% We want to predict the last column NSP (Normal=1; Suspect=2; Pathologic=3)...
Y = M(:,end);
% ...based on the other features (all but the last column)
X = M(:,1:end-1);
% feature names
cols = {'LB', 'AC', 'FM', 'UC', 'DL','DS', 'DP','ASTV','MSTV', 'ALTV',...
    'MLTV', 'Width', 'Min', 'Max', 'Nmax', 'Nzeros', 'Mode', 'Mean', ...
    'Median', 'Variance', 'Tendency'};
% ++ you will need to change this; ++
H_Y = ent(Y);
X1 = X(:,1);
H_Y_X1 = cond_ent(Y,X1) ; %X1 is the first feature 'LB'
% compute the information gain if split on X1
IG_X1 = H_Y - H_Y_X1;    

fprintf('Entropy for Y is: %f\n', H_Y);
fprintf('Conditional Entropy H(Y|X1)is: %.3f\n', H_Y_X1);
fprintf('Information Gain IG(Y|X1)is: %.3f\n', IG_X1);
fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% ============= Part 2: Test your findBestSplit function ==============

[best_feature, best_val, best_ig] ...
        = findBestSplit(X, Y);  % you need to complete findBestplit.m

fprintf('The best feature and value to split on: %s at %.2f\n',cols{best_feature}, best_val);
fprintf('The maximum information gain (IG) is: %.4f\n', best_ig);
fprintf('The expected best binary slit is to split ASTV feature at 59.50 with IG = 0.2156\n');


 
 
