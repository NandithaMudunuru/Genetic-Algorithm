%% Main
clear all
close all
clc

%Input
x = linspace(0,0.6,150);
y = linspace(0,0.6,150);
[X,Y] = meshgrid(x,y);
optimization_func = @stalagmite_func;

for i = 1:length(X)
    for j = 1:length(Y)
      in(1) = X(i,j);
      in(2) = Y(i,j);
        f(i,j) = -optimization_func(in);
    end
end


for i = 1:50
    optim_result(i,:) = geneticalgorithm(optimization_func,[0,0.6],[0,0.6]);
end

subplot(2,1,1)
surfc(X,Y,f)
xlabel('X')
ylabel('Y')
zlabel('Stalagmite')
hold on
shading interp
plot3(optim_result(:,1),optim_result(:,2),-optim_result(:,3),'*','color',[0 0 0])
subplot(2,1,2)
plot(-optim_result(:,3))
ylabel('Stalagmite optimization results')
xlabel('Iteration')
axis([1 length(optim_result(:,3)) 0.5 1.1])




%% Staligmite function
function f = stalagmite_func(I)
    A = (sin(0.5+(5.1*pi*I))).^6;
    B = exp(-4*log(2)*((I-0.0667).^2)/0.64);
    f = -A(1)*B(1)*A(2)*B(2);
end




%% Genetic Algorithm
function output = geneticalgorithm(optim_function,I,J)
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





%% Selection
function selection = Selection(population)
    %ps = 0.5,0.33,0.16
    % 0.5 * 1st 1/3 population will become parents
    % 0.33 2nd 1/3 population will become parents
    % 0.16 3rd 1/3 population will become  parents

    %initializing array
    selection = [];

    %first 1/3
    for i = 1:floor(length(population(:,3))/3)
        a(i,:) = population(i,:);
    end
    a = rearrange(a);
    for i = 1:floor(2*length(a(:,1))/3)
        selection(i,:) = a(i,:);
    end

    %second 1/3
    j = 1;
    for i = floor(length(population(:,3))/3)+1:floor(2*length(population(:,3))/3)
        a(j,:) = population(i,:);
        j = j+1;
    end
    a = rearrange(a);
    if size(selection) ~= [0,0]
        j = length(selection(:,1))+1;
    else
        j = 1;
    end
    for i = 1:floor(length(a(:,1))/3)
        selection(j,:) = a(i,:);
        j = j+1;
    end

    %third 1/3
    j = 1;
    for i = floor(2*length(population(:,3))/3)+1:length(population(:,3))
        a(j,:) = population(i,:);
        j = j+1;
    end
    a = rearrange(a);
    if size(selection) ~= [0,0]
        j = length(selection(:,1))+1;
    else
        j = 1;
    end
    for i = 1:floor(length(a(:,1))/6)
        selection(j,:) = a(i,:);
        j = j+1;
    end
end




%% crossover
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





%% Mutation
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




%% New Generation
function newgeneration = newgen(population,children)

    %sorting based on fitness
    sorted = foldsort(population);

    %replacing week fits with offsprings
    for i = 1:floor(length(children)*0.8)
        sorted(length(sorted)-i+1,:) = children(i,:);
    end

    %sorting based on age
    Sortforage = sortforage(sorted);

    %replacing older population with offsprings
    j = 1;
    for i = floor(length(children)*0.8)+1:length(children)
        Sortforage(length(Sortforage)-j+1,:) = children(i,:);
        j = j+1;
    end

    %output
    newgeneration = Sortforage;
end




%% Sort for age
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
end



%% Rearrange
function Data = rearrange(Data1)
    if size(Data1) == [0,0]
        Data = Data1;
    elseif length(Data1(:,1)) == 1
        Data = Data1;
    else
        a = randperm(length(Data1(:,1)));
        for i = 1:length(Data1(:,1))
            Data(i,:) = Data1(a(i),:);
        end
    end
end




%% Fold sort
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
end