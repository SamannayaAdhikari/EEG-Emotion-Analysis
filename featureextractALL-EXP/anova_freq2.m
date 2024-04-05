% This is Anova & Tukey accross IMFs (Apha 1 , alpha2,
% alpha3,alpha4,alpha5 ......) i n same emotion
% ____________________________________________________________________________________________






% Load the dataset for Happy emotion
% data(any(data{:,:} == 0, 2), :) = [];

data = table2array(Frequencyfeatures15s) % Replace 'happy_data.mat' with the path to your Happy emotion dataset
% happy_data =table2array(happy_data)
% Separate features and labels
features = data(:, 1:25);
labels = data(:, 26);

% Extract features for each emotion
happy_data = features(labels == 0, :);
sad_features = features(labels == 1, :);
fear_features = features(labels == 2, :);

% Define the number of IMFs and features per IMF
num_imfs = 5; % Assuming 5 IMFs
features_per_imf = 5; % Assuming 5 features per IMF (alpha, beta, gamma, delta, theta)

% Initialize arrays to store p-values and significant differences
p_values = [];
c_values=[]

% Iterate over each feature within Happy emotion
for feature_idx = 1:num_imfs
    % Extract data for the current IMF
    feature_data = sad_features(:,feature_idx:5:feature_idx + 20);
    
    % Perform ANOVA for all features within the current IMF
    [p, tbl, stats] = anova1(feature_data, [], 'off');
    % Perform Tukey's HSD test
    [c,~,~,gnames] = multcompare(stats);
    
    % Store p-values and other ANOVA results for further analysis
    p_values(feature_idx)=p
    c_values(:,:,feature_idx)=c
    % (e.g., post-hoc tests)
%     p_values(imf_idx) = p;
%     anova_tbl{imf_idx} = tbl;
%     anova_stats{imf_idx} = stats;
end




