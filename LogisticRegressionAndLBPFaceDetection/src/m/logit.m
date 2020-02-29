%% Initialization
clear ; close all; clc

%% Load Data
%  The first 256 columns contains the exam scores and the 257th column
%  contains the label.

data = load('data.txt');
X = data(:, [1 : 256]); y = data(:, 257);


%% ============ Part 2: Compute Cost and Gradient ============
%  In this part of the exercise, you will implement the cost and gradient
%  for logistic regression. You neeed to complete the code in 
%  costFunction.m

%  Setup the data matrix appropriately, and add ones for the intercept term
[m, n] = size(X);  % num of samples:        m
                   % dimension of a sample: n

% Add intercept term to x and X_test
X = [ones(m, 1) X];

% Initialize fitting parameters
initial_theta = zeros(n + 1, 1);

% Compute and display initial cost and gradient
[cost, grad] = costFunction(initial_theta, X, y);

fprintf('Cost at initial theta (zeros): %f\n', cost);
fprintf('Gradient at initial theta (zeros): \n');
fprintf(' %f \n', grad);


%% ============= Part 3: Optimizing using fminunc  =============
%  In this exercise, you will use a built-in function (fminunc) to find the
%  optimal parameters theta.

%  Set options for fminunc
options = optimset('GradObj', 'on', 'MaxIter', 500);

%  Run fminunc to obtain the optimal theta
%  This function will return theta and the cost 
[theta, cost] = ...
	fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);

% Print theta to screen
fprintf('Cost at theta found by fminunc: %f\n', cost);
fprintf('theta: \n');
fprintf(' %f \n', theta);


%% ============== Part 4: Predict and Accuracies ==============
%  After learning the parameters, you'll like to use it to predict the outcomes
%  on unseen data. In this part, you will use the logistic regression model
%  to predict the probability that a student with score 20 on exam 1 and 
%  score 80 on exam 2 will be admitted.
%
%  Furthermore, you will compute the training and test set accuracies of 
%  our model.
%
%  Your task is to complete the code in predict.m

%  Predict probability for a student with score 45 on exam 1 
%  and score 85 on exam 2 


pos_test = [88 17 1 8 25 1 9 21 11 0 0 0 15 1 6 34 28 6 0 0 3 0 1 1 18 1 1 0 67 3 56 26 11 0 0 0 1 0 1 1 3 0 0 0 0 0 1 0 26 1 1 0 4 0 0 0 51 3 0 1 233 2 49 18 40 4 0 2 8 3 2 2 1 0 0 0 2 0 0 1 3 1 0 0 2 0 1 1 7 0 0 0 2 1 2 0 19 1 1 0 3 0 0 0 2 0 0 0 1 0 1 3 76 7 0 1 1 0 0 0 153 3 0 0 104 7 30 9 1 4 0 17 2 1 0 50 0 0 0 1 0 0 1 25 1 1 0 1 0 0 0 2 0 1 0 4 0 1 0 14 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 6 0 0 0 0 2 3 0 5 4 1 0 29 16 35 0 38 1 3 0 20 0 0 0 1 1 0 1 11 1 0 0 0 0 0 0 2 0 0 0 0 1 1 1 4 33 71 0 27 3 1 0 16 3 4 0 0 1 2 6 15 56 59 2 18 2 1 0 9 43 29 2 22 28 17 33 121] ;

neg_test = [223 54 6 15 44 6 14 24 13 3 1 3 16 3 20 19 61 15 3 3 8 3 4 4 18 7 1 1 25 6 44 31 12 4 0 0 1 0 0 1 0 0 0 0 4 0 2 2 21 7 1 2 1 0 0 2 21 3 2 2 19 2 17 17 35 10 2 3 12 0 5 6 1 0 1 1 1 0 3 3 4 1 0 0 0 1 0 2 3 0 1 0 5 1 3 7 9 5 1 1 1 0 1 1 2 0 2 3 4 1 5 0 42 4 1 0 4 0 1 3 28 1 3 1 30 2 23 19 5 12 1 11 0 3 3 10 1 0 0 4 0 1 3 10 3 5 0 6 0 0 0 1 2 1 0 1 0 3 4 11 2 2 0 2 0 0 1 0 0 0 0 0 0 0 1 2 1 5 0 4 0 2 0 0 2 1 1 6 2 1 2 42 13 29 2 16 0 4 7 19 2 0 0 1 2 2 2 12 5 5 0 2 1 1 1 2 2 0 0 2 0 4 2 21 37 33 0 12 4 0 8 10 4 3 0 3 3 1 14 35 51 39 1 21 1 5 0 8 36 29 2 28 27 15 64 321] ;
prob = sigmoid([1 pos_test] * theta);
fprintf(['For a student with scores 45 and 85, we predict an admission ' ...
         'probability of %f\n\n'], prob);

prob = sigmoid([1 neg_test] * theta);
fprintf(['For a student with scores 45 and 85, we predict an admission ' ...
         'probability of %f\n\n'], prob);

% Compute accuracy on our training set
p = predict(theta, X);

fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);


pos = find(y == 1);
neg = find(y == 0);

xx = X * theta;
yy = sigmoid(xx);
xx = xx.*10;
%plot(xx, y)

plot(xx(pos, 1), y(pos, 1), '+')
hold on;
plot(xx(neg, 1), y(neg, 1), 'o')
hold on;
