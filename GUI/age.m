function A = age(B)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

A = zeros(1, size(B,2));

for i = 1:1:size(B,2)
    
    A(i) = B(i)-1;
    
end

end
