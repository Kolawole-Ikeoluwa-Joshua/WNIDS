% Array for number of neurons
x = [5, 8, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60];
% Array for Mean Square Error
y = [0.2184, 0.1888, 0.1562, 0.1062, 0.0706, 0.0631, 0.0563, 0.0360, 0.0336, 0.0290, 0.0289, 0.0252, 0.0260];
% Array for Number of iterations
y1 = [12, 12, 12, 11, 13, 17, 11, 11, 11, 10, 9, 9, 9];
% Plot graph 1
figure, plot(x, y)
title('MSE-Neurons Plot')
xlabel('Number of neurons')
ylabel('Mean Square Error')
% Plot graph 2
figure, plot(x, y1)
title('Iteration-Neurons Plot')

xlabel('Number of neurons')
ylabel('Number of Epochs')

