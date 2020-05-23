function A = sortforage(A)
i = 1;
j = 1;
for i = 1:length(A(:,1))
    for j = 1:length(A(:,1))
        if A(i,4)<A(j,4);
            %swapping
            b = A(i,:);
            A(i,:) = A(j,:);
            A(j,:) = b;
        end
    end
end     