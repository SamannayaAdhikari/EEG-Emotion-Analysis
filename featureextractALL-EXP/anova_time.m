% Load the dataset
data = table2array(timefeatures1sec)

% Separate features and labels
features = data(:, 1:15);
labels = data(:, 16);

% Extract features for each emotion
happy_features = features(labels == 0, :);
sad_features = features(labels == 1, :);
fear_features = features(labels == 2, :);

% Visualize the distributions of Hjorth parameters using boxplots
figure;
boxplot(happy_features, 'Labels', { '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'});
title('Distribution of Hjorth Parameters for Happy Emotion');

figure;
boxplot(sad_features, 'Labels', {'1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'});
title('Distribution of Hjorth Parameters for Sad Emotion');

figure;
boxplot(fear_features, 'Labels', {'1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'});
title('Distribution of Hjorth Parameters for Fear Emotion');

% Explore pairwise differences between groups using Tukey's HSD
[~, p_values_happy_sad] = ttest2(happy_features, sad_features);
[~, p_values_happy_fear] = ttest2(happy_features, fear_features);
[~, p_values_sad_fear] = ttest2(sad_features, fear_features);

% Display p-values
disp('Tukey''s HSD p-values for Happy vs. Sad:');
disp(p_values_happy_sad);

disp('Tukey''s HSD p-values for Happy vs. Fear:');
disp(p_values_happy_fear);

disp('Tukey''s HSD p-values for Sad vs. Fear:');
disp(p_values_sad_fear);
