function mutation_set = mutation(selected_parents,optim_func)

a = length(selected_parents(:,1));
a = randi([1,a]);%random integer between 1 and length of the parent array

%assigning values of the random element from population to random element in parent
I = [0.6*rand,0.6*rand];
f = optim_func(I);
selected_parents(a,1:2) = I;
selected_parents(a,3) = f;
selected_parents(a,4) = 1;

%output
mutation_set = selected_parents;
end