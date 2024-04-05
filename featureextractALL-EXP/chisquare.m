
% Convert table to array
your_dataset_array = table2array(timefeatures1sec);

% Extract features and labels
features = your_dataset_array(:, 1:end-1); % Extracting features (all columns except the last one)
labels = your_dataset_array(:, end); % Extracting labels (last column)

% Convert labels to categorical array
labels_cat = categorical(labels);

% Perform chi-square test
[~, ~, stats] = contingency(features, labels_cat);
chi2stat = stats.chi2;
pval = stats.p;

% Display results
disp(['Chi-square test statistic: ', num2str(chi2stat)]);
disp(['P-value: ', num2str(pval)]);
