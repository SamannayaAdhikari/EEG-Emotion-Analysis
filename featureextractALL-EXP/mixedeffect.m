
data=table2array(timefeatures1sec)

% Extract features and labels
features = data(:, 1:15); % Extract Hjorth parameters
labels = data(:, 16); % Extract emotion labels

% Create a table for mixed-effects modeling
tbl = array2table(features, 'VariableNames', {'Activity_IMF1', 'Mobility_IMF1', 'Complexity_IMF1', ...
                                             'Activity_IMF2', 'Mobility_IMF2', 'Complexity_IMF2', ...
                                             'Activity_IMF3', 'Mobility_IMF3', 'Complexity_IMF3', ...
                                             'Activity_IMF4', 'Mobility_IMF4', 'Complexity_IMF4', ...
                                             'Activity_IMF5', 'Mobility_IMF5', 'Complexity_IMF5'});
tbl.Emotion = categorical(labels); % Add emotion labels as a categorical variable
% Loop through each value and assign it to the corresponding range
len_values=floor(28864/480)
start_idx = 1;
num_rows=480
obdata = zeros(28864, 1)
for i = 1:len_values
    end_idx = start_idx + num_rows - 1;
    obdata(start_idx:min(end_idx,28864)) = i;
    start_idx = end_idx + 1;
end

tbl.Observation=obdata

% Fit mixed-effects models
activity_model = fitlme(tbl, 'Activity_IMF1 + Activity_IMF2 + Activity_IMF3 + Activity_IMF4 + Activity_IMF5 ~ Emotion + (1|Observation)');
mobility_model = fitlme(tbl, 'Mobility_IMF1 + Mobility_IMF2 + Mobility_IMF3 + Mobility_IMF4 + Mobility_IMF5 ~ Emotion + (1|Observation)');
complexity_model = fitlme(tbl, 'Complexity_IMF1 + Complexity_IMF2 + Complexity_IMF3 + Complexity_IMF4 + Complexity_IMF5 ~ Emotion + (1|Observation)');
