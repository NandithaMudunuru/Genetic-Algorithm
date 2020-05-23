%ps = 0.66,0.33,0.16
%pc = 0.33*generation population [0.38 = 0.66/3 + 0.33/3 + 0.16/3]
%pm = 0.2*generation population
%pold = 0.2*children
%pweek = 0.8*children

%procedure:
%initial population 300
%fitness
%sorting based on fitness
%selection
%crossover
%mutation
%new generation
%go back to line9 

% optim_function = @stalagmite;
% I = [0,0.6];
% J = I;

function output = geneticalgorithm(optim_function,I,J)

%input
ll1 = I(1);
ul1 = I(2);
ll2 = J(1);
ul2 = J(2);

%initial data set
x = linspace(ll1,ul1,20);
y = linspace(ll2,ul2,20);
[X,Y] = meshgrid(x,y);

k = 1;
for i = 1:length(X(:,1))
    for j = 1:length(X(1,:))
        %column1-variable,column2-variable,column3-fitness,column4-age:
        original_population(k,:) = [X(i,j),Y(i,j),0,1];
        k = k+1;
    end
end

%rearranging
original_population = rearrange(original_population);

%population initialisation
for i = 300
    population(i,:) = original_population(i,:);
end

%fitness function
for i = 1:length(population(:,1))
    population(i,3) = optim_function(population(i,:));
end

%sort
sorted = foldsort(population);
population = sorted;

for count = 1:100
    %Aging before going to new generation
    population(:,4) = population(:,4)+1;


    %selection by rank
    selection = Selection(population);
    parents = rearrange(selection);

    %crossover by weighted arithmatic recombination
    children = crossover(parents, optim_function);

    %new generation
    Newgen = newgen(population,children);
    population = Newgen;

    for count2 = 1:60
        %mutation by random resetting
        population = mutation(population, optim_function);
    end

    population = rearrange(population);

    %sort
    sorted = foldsort(population);
    population = sorted;

end

%output
output = population(1,1:3);

end
