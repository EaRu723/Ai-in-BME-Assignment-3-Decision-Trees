function result = cond_ent(Y, X)
% Calculates the conditional entropy of y given x

result = 0;

% ====================== YOUR CODE HERE ======================
values = unique(X);
m = size(X,1);
prob = zeros(size(values));
H = zeros(size(values));
%proability
for i=1:size(values)
    prob(i) = size(find(X == values(i)),1) / m;
    H(i) = ent(Y(X==values(i)));
end
%specific entropy
  
    result = sum(prob .* H);








% =============================================================

end