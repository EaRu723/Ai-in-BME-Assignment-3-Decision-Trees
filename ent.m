function result = ent(Y)
% Calculates the entropy of a vector of values 

result = 0;
% ====================== YOUR CODE HERE ======================
% you may find function unique useful. 

values = unique(Y);
m = size(Y,1);
freq = zeros(size(values));
for i=1:size(values)
    freq(i) = size(find(Y==values(i)), 1)/m;
end

result = -sum(freq .*log2(freq));
    







% =============================================================

end