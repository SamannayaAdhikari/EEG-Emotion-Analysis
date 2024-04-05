
% % Convert table to array
% your_dataset_array = table2array(timefeatures1sec);
% 
% % Extract features and labels
% features = your_dataset_array(:, 1:end-1); % Extracting features (all columns except the last one)
% labels = your_dataset_array(:, end); % Extracting labels (last column)
% 
% % Calculate the mean of each column (excluding NaN values)
% features_mean = nanmean(features);
% labels_mean = nanmean(labels);
% 
% % Replace NaN values in features and labels with the column mean
% for i = 1:size(features, 2)
%     nan_indices = isnan(features(:, i)); % Find NaN indices in the current column
%     features(nan_indices, i) = features_mean(i); % Replace NaN values with mean of the column
% end
% nan_indices = isnan(labels); % Find NaN indices in the labels
% labels(nan_indices) = labels_mean; % Replace NaN values in labels with mean
% 
% % Calculate Pearson correlation coefficients
% num_features = size(features, 2);
% correlations = zeros(num_features, 1);
% 
% for i = 1:num_features
%     correlations(i) = corr(features(:, i), labels, 'rows', 'pairwise');
% end
% 
% % Display correlations
% disp('Correlation between each feature and emotions:');
% disp(correlations);
% 
% 
% 
% 
% % Visualize correlations
% figure;
% bar(correlations);
% xlabel('Feature Index');
% ylabel('Correlation with Emotions');
% title('Correlation between Features and Emotions');
% 



% sparsman  

% Convert table to array
your_dataset_array = table2array(timefeatures1sec);

% Extract features and labels
features = your_dataset_array(:, 1:end-1); % Extracting features (all columns except the last one)
labels = your_dataset_array(:, end); % Extracting labels (last column)

% Calculate the mean of each column (excluding NaN values)
features_mean = nanmean(features);
labels_mean = nanmean(labels);

% Replace NaN values in features and labels with the column mean
for i = 1:size(features, 2)
    nan_indices = isnan(features(:, i)); % Find NaN indices in the current column
    features(nan_indices, i) = features_mean(i); % Replace NaN values with mean of the column
end
nan_indices = isnan(labels); % Find NaN indices in the labels
labels(nan_indices) = labels_mean; % Replace NaN values in labels with mean

% Calculate Spearman's rank correlation coefficients
num_features = size(features, 2);
correlations_spearman = zeros(num_features, 1);

for i = 1:num_features
    correlations_spearman(i) = corr(features(:, i), labels, 'type', 'Spearman', 'rows', 'pairwise');
end

% Display Spearman's rank correlations
disp('Spearman''s rank correlation between each feature and emotions:');
disp(correlations_spearman);



% Visualize correlations
figure;
bar(correlations_spearman);
xlabel('Feature Index');
ylabel('Correlation with Emotions');
title('Correlation between Features and Emotions');

