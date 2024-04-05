
% This is Anova & tukey accross IMFs (alpha 1, beta 1, gamma1, delta 1, theta 1 ...) in same emotion 
% _______________________________________________________________________________________________________






% Load the dataset for Happy emotion
% data(any(data{:,:} == 0, 2), :) = [];

% data = table2array(Frequencyfeatures15s) % Replace 'happy_data.mat' with the path to your Happy emotion dataset
% % happy_data =table2array(happy_data)
% % Separate features and labels
% features = data(:, 1:25);
% labels = data(:, 26);
% 
% % Extract features for each emotion
% happy_data = features(labels == 0, :);
% sad_features = features(labels == 1, :);
% fear_features = features(labels == 2, :);

happy_data=table2array(Happyfreq15s)

% Define the number of IMFs and features per IMF
num_imfs = 5; % Assuming 5 IMFs
features_per_imf = 5; % Assuming 5 features per IMF (alpha, beta, gamma, delta, theta)

% Initialize arrays to store p-values and significant differences
p_values = [];
c_values=[]


% Iterate over each feature within Happy emotion
for imf_idx = 1:features_per_imf
    % Extract data for the current IMF
    imf_data = happy_data(:,(imf_idx - 1) * features_per_imf + 1 : imf_idx * features_per_imf);
    
    % Perform ANOVA for all features within the current IMF
    [p, tbl, stats] = anova1(imf_data, [], 'off');
    [c,~,~,gnames] = multcompare(stats);
    
    % Store p-values and other ANOVA results for further analysis
    p_values(imf_idx)=p
    c_values(:,:,feature_idx)=c
    % (e.g., post-hoc tests)
%     p_values(imf_idx) = p;
%     anova_tbl{imf_idx} = tbl;
%     anova_stats{imf_idx} = stats;
end



