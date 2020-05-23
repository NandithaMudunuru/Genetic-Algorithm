function child = crossover(parent,optimizing_function)

%initializing child array
child = rand(length(parent(:,1)),4);

%Weighted algorithmic crossover for parents 1-2, 2-3, 3-4 ..... (n-1)-n
%resulting in one offspring per pair
for i = 1:length(parent(:,1))-1
    if parent(i,3)<parent(i+1,3)%comparing fitness
        x = parent(i,1:2);
        y = parent(i+1,1:2);
    else
        x = parent(i+1,1:2);
        y = parent(i,1:2);
    end
    child(i,1) = 0.6*(x(1))+0.3*(y(1));%twice the weightage to fitter parent
    child(i,2) = 0.6*(x(2))+0.3*(y(2));%twice the weightage to fitter parent
    child(i,3) = optimizing_function(child(i,1:2));
    child(i,4) = 1;
end

%Weighted algorithmic crossover for parents n,1
%resulting in one offspring
if parent(length(parent(:,1)),3)<parent(1,3)%comparing fitness
    x = parent(length(parent(:,1)),1:2);
    y = parent(1,1:2);
else
    x = parent(1,1:2);
    y = parent(length(parent(:,1)),1:2);
end
child(length(parent(:,1)),1) = 0.6*(x(1))+0.3*(y(1));%twice the weightage to fitter parent
child(length(parent(:,1)),2) = 0.6*(x(2))+0.3*(y(2));%twice the weightage to fitter parent
child(length(parent(:,1)),3) = optimizing_function(child(length(parent(:,1)),1:2));
child(length(parent(:,1)),4) = 1;
end
