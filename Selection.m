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