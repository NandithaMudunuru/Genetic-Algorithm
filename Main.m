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