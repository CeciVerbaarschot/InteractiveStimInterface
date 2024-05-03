clear all
close all

% add code path
addpath('/Volumes/MyBackupDrive/interactive_interface/analysis/code')

% main folder where the data is stored
data_folder = '/Volumes/MyBackupDrive/interactive_interface/data/';

% Check the pre and post session amplitude intensity matching results.
plot_pre_and_post_amplitude(data_folder, 'P2'); % participant P2
plot_pre_and_post_amplitude(data_folder, 'P3'); % participant P3
plot_pre_and_post_amplitude(data_folder, 'C1'); % participant C1

% Check the pre and post session frequency intensity results.
plot_pre_and_post_frequency_intensity(data_folder, 'P2'); % participant P2
plot_pre_and_post_frequency_intensity(data_folder, 'P3'); % participant P3
plot_pre_and_post_frequency_intensity(data_folder, 'C1'); % participant C1

% Check the cursor behavior in the object-sensation mapping trials. For
% example, what is the percentage of explored parameter space in each trial, 
% how long did each trial take, etc. Saves this information in
% "cursor_data.mat".
get_cursor_info(data_folder, 'P2'); % participant P2
get_cursor_info(data_folder, 'P3'); % participant P3
get_cursor_info(data_folder, 'C1'); % participant C1

% Plot the single-trial cursor movement within the parameter spaces during
% the object-sensation mapping task. Careful, this will plot EVERY trial! 
plot_single_trial_cursor_movement(data_folder, 'P2'); % participant P2
plot_single_trial_cursor_movement(data_folder, 'P3'); % participant P3
plot_single_trial_cursor_movement(data_folder, 'C1'); % participant C1

% Plot the cursor behavior in the stimulus parameter space per object and 
% participant.
plot_cursor_exploration(data_folder, 'P2'); % participant P2
plot_cursor_exploration(data_folder, 'P3'); % participant P3
plot_cursor_exploration(data_folder, 'C1'); % participant C1

% Read in chosen stimulus parameters and object satisfaction ratings in
% object-sensation mapping trials. This saves, e.g., "P2_all_data.mat"
% which contains all chosen stimulation parameters, total charge, object
% labels, satisfaction scores, etc.
read_object_sensation_mapping_data(data_folder,'P2'); % participant P2
read_object_sensation_mapping_data(data_folder,'P3'); % participant P3
read_object_sensation_mapping_data(data_folder,'C1'); % participant C1

% Plot chosen stimulation parameters per object and participant.
% Loads the "P2_all_data.mat" generated by read_object_sensation_mapping_data().
plot_stim_parameters(data_folder, 'P2'); % participant P2
plot_stim_parameters(data_folder, 'P3'); % participant P3
plot_stim_parameters(data_folder, 'C1'); % participant C1

% Read in object choices and certainty ratings during the within session
% replay trials. This saves "replay_data.mat" which contains the stimulation 
% details of replay trials, object choices and the confusions between objects.
read_replay_data(data_folder,'P2'); % participant P2
read_replay_data(data_folder,'P3'); % participant P3
read_replay_data(data_folder,'C1'); % participant C1

% Plot the total charge for each created object sensation, based on the
% replay data (because the stimulation parameters do not change anymore in
% these trials). Needs the "replay_data.mat" generated by
% read_replay_data(). 
plot_charge(data_folder, 'P2'); % participant P2
plot_charge(data_folder, 'P3'); % participant P3
plot_charge(data_folder, 'C1'); % participant C1

% Check the replay performance within sessions. Needs the "replay_data.mat" 
% generated by read_replay_data(). 
plot_within_session_replay_performance(data_folder, 'P2'); % participant P2
plot_within_session_replay_performance(data_folder, 'P3'); % participant P3
plot_within_session_replay_performance(data_folder, 'C1'); % participant C1

% Check how well participants recognized a sensation from previous sessions
% (final across session replay task)
check_across_session_replay_performance(data_folder, 'P2'); % participant P2
check_across_session_replay_performance(data_folder, 'P3'); % participant P2
check_across_session_replay_performance(data_folder, 'C1'); % participant P2

% Read in tactile characteristics survey, object choices and certainty
% ratings in the final across session replay trials.
% This saves "object_survey_data.mat", containing the differences in survey
% ratings when feeling a sensation with and without a visual context.
read_survey_data(data_folder, 'P2'); % participant P2
read_survey_data(data_folder, 'P3'); % participant P3
read_survey_data(data_folder, 'C1'); % participant C1

% Perform linear discriminant analysis on chosen stimulation parameters in
% object-sensation mapping trials. Uses object identity as class labels.
% This function loads, e.g., "P2_all_data.mat", created by 
% read_object_sensation_mapping_data(). 
classify_on_stim_parameters(data_folder,'P2'); % participant P2
classify_on_stim_parameters(data_folder,'P3'); % participant P3
classify_on_stim_parameters(data_folder,'C1'); % participant C1

% Perform linear discriminant analysis on chosen stimulation parameters in
% object-sensation mapping trials. Uses tactile characteristics (compliance, 
% friction, etc.) as classes. This function loads, e.g., "P2_all_data.mat", 
% created by read_object_sensation_mapping_data(). 
classify_on_tactile_characteristics(data_folder,'P2'); % participant P2
classify_on_tactile_characteristics(data_folder,'P3'); % participant P3
classify_on_tactile_characteristics(data_folder,'C1'); % participant C1

% Compare object similarity (able-bodied survey) and confusion scores
% (participant replay). Needs the "replay_data.mat" generated by
% read_replay_data(). 
compare_able_bodied_and_participant_survey_ratings(data_folder); % all participants

% Plot the tactile survey ratings while experiencing the sensation with or 
% without a visual object representation (final replay session). Loads the
% "object_survey_data.mat" generated by read_survey_data(). 
plot_visual_vs_nonvisual_context(data_folder); % all participants