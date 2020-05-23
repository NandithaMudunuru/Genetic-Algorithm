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