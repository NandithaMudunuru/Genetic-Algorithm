function A = foldsort(A)
i = 1;
j = 1;
for i = 1:length(A(:,1))
    for j = 1:length(A(:,1))
        if A(i,3)<A(j,3);
            %swapping
            b = A(i,:);
            A(i,:) = A(j,:);
            A(j,:) = b;
        end
    end
end

        