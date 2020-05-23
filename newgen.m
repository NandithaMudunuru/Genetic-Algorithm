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
