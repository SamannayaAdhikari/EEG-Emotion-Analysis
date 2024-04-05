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
    filtered_data = filtfilt(b_low, 1, filtfilt(b_high, 1, d1));
    
    
    
    
    
    
    
    
    
    % Define the parameters for the Savitzky-Golay filter
    frame_length = 127;  % Adjust this parameter as needed
    order = 5;  % Adjust this parameter as needed
    
    % Apply the Savitzky-Golay filter
    smoothed_signal = sgolayfilt(filtered_data, order, frame_length);
    
    % Remove the average trend in the EEG data
    artifact_free_data = filtered_data - smoothed_signal;