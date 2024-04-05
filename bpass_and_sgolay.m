% Specify the directory where your .mat files are located
matFilesDir = 'E:\BCI7thsem\emotionclips\filtered_data\filtered_data_mat';
outputDir = 'E:\BCI7thsem\emotionclips\filtered_data\filtered_data_mat\filter_wd_sgf_fir';

% Get a list of all .mat files in the specified directory
matFiles = dir(fullfile(matFilesDir, '*.mat'));

% Iterate through each .mat file
for i = 1:length(matFiles)
    % Load the EEG data from the .mat file
    load(fullfile(matFilesDir, matFiles(i).name), 'EEG');
    
    % Extract the EEG data and assign it to 'EEGdata'
    EEGdata = EEG.data;
    EEGdata=double(EEGdata)

    ICs=EEGdata'
    sampling_frequency = 128;  % Hz
    
    % Define the frequency range for band-pass filtering
    low_cutoff = 0.5;  % Hz
    high_cutoff = 45;  % Hz
    
    % Design a low-pass filter
    filter_order = 200;  % You can adjust this order as needed
    low_pass_cutoff_norm = high_cutoff / (sampling_frequency / 2);
    b_low = fir1(filter_order, low_pass_cutoff_norm, 'low');
    
    % Design a high-pass filter
    high_pass_cutoff_norm = low_cutoff / (sampling_frequency / 2);
    b_high = fir1(filter_order, high_pass_cutoff_norm, 'high');
    
    % Apply the band-pass filter to EEG data by cascading low-pass and high-pass filters
    filtered_data = filtfilt(b_low, 1, filtfilt(b_high, 1, ICs));
    
    % At this point, 'filtered_data' contains the EEG data after band-pass filtering
    
    % Save the filtered EEG data to a new file (replace 'filtered_eeg_data.mat' with your desired filename)
    % save('filtered_sub11t11Hfir.mat', 'filtered_data');
    
        
    % Define the parameters for the Savitzky-Golay filter
    frame_length = 127;  % Adjust this parameter as needed
    order = 5;  % Adjust this parameter as needed
    
    % Apply the Savitzky-Golay filter
    smoothed_signal = sgolayfilt(filtered_data, order, frame_length);
    
    % Remove the average trend in the EEG data
    artifact_free_data = filtered_data - smoothed_signal;
    
    % At this point, 'artifact_free_data' contains the EEG data with the average trend removed
    
    %end of rest of your code

    % Save the artifact-free EEG data to a new file with '-2' appended
    outputFileName = strrep(matFiles(i).name, '.mat', '-2.mat');
    outputFilePath = fullfile(outputDir, outputFileName);
    save(outputFilePath, 'artifact_free_data');
    
    % Display a message for each file processed
    fprintf('Processed and saved: %s\n', matFiles(i).name);
end
