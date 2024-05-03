function [total_charge, train_length, total_overlap, max_mode_amp, freq] = get_actual_stim_values(session, set, block, trial, voltageData)

% find the stim trains in this trial
data = voltageData(find(voltageData(:,1)==session & voltageData(:,2)==set & voltageData(:,3)==block & voltageData(:,4)==trial),5:7);

min_hz = 17;
pulse_length = 200*(10^-6); % each pulse is 200uS in length

if ~isempty(data)
    % transform timestamps in samples to seconds
    start_samp = data(1,2);
    data_new = data;
    data_new(:,2) = data_new(:,2)-start_samp;
    data_new(:,2) = data_new(:,2)*(1/100000); % voltage monitor data is sampels at 100kHz

    % separate data into different channels, make sure that data is sorted in
    % time
    channels = unique(data_new(:,1));
    if ismember(0,channels)
        channels(find(channels == 0)) = [];
    end
    chan1 = data_new(find(data_new(:,1) == channels(1)),:);
    chan1 = sortrows(chan1,2);
    chan2 = data_new(find(data_new(:,1) == channels(2)),:);
    chan2 = sortrows(chan2,2);
    chan3 = data_new(find(data_new(:,1) == channels(3)),:);
    chan3 = sortrows(chan3,2);

    % check out the signals
%     figure
%     for i=1:size(chan1,1)
%         plot([chan1(i,2), chan1(i,2)],[0 chan1(i,3)],'Color',[0 0 1 0.7])
%         hold on;   
%     end
%     for i=1:size(chan3,1)
%         plot([chan3(i,2), chan3(i,2)],[0 chan3(i,3)],'Color',[0 1 0 0.7])
%         hold on;   
%     end
%     for i=1:size(chan2,1)
%         plot([chan2(i,2), chan2(i,2)],[0 chan2(i,3)],'Color',[1 0 0 0.7])
%         hold on;   
%     end
%     xlim([0,max(chan1(:,2))])
%     xlabel('time(s)')
%     ylabel('amplitude(uA)')
%     sgtitle(['session ', num2str(session), ', set ', num2str(set), ', block ', num2str(block), ', trial ', num2str(trial)])

    % delete last stim train because it may be incomplete
    diff_chan1 = diff(chan1(:,2));
    breaks = find(diff_chan1>1);
    if ~isempty(breaks)
        if breaks(end) > 1
            chan1(breaks(end)+1:end,:) = [];
            diff_chan1(breaks(end):end) = [];
        end
    end
    
    diff_chan2 = diff(chan2(:,2));
    breaks = find(diff_chan2>1);
    if ~isempty(breaks)
        if breaks(end) > 1
            chan2(breaks(end)+1:end,:) = [];
            diff_chan2(breaks(end):end) = [];
        end
    end
    
    diff_chan3 = diff(chan3(:,2));
    breaks = find(diff_chan3>1);
    if ~isempty(breaks) 
        if breaks(end) > 1
            chan3(breaks(end)+1:end,:) = [];
            diff_chan3(breaks(end):end) = [];
        end
    end

    % find last stim train on a given channel
    chan1_hz = 1./diff_chan1;
    idx = find(chan1_hz<min_hz);
    if ~isempty(idx)
        if idx(end) == numel(chan1_hz)
            idx(end) = [];
        end
    else 
        idx = 1;
    end
    start_idx = idx(end)+1;
    end_idx = size(chan1,1);
    last_train_chan1 = chan1(start_idx:end_idx,:);
    last_train_chan1(:,3) = last_train_chan1(:,3)*(10^-6); % convert microampere to ampere
    charge_chan1 = sum(last_train_chan1(:,3) .* pulse_length); % total charge: current * time = Ampere * Seconds
    train_length1 = last_train_chan1(end,2)-last_train_chan1(1,2);

    chan2_hz = 1./diff_chan2;
    idx = find(chan2_hz<min_hz);
    if ~isempty(idx)
        if idx(end) == numel(chan2_hz)
            idx(end) = [];
        end
    else
        idx = 1;
    end
    start_idx = idx(end)+1;
    end_idx = size(chan2,1);
    last_train_chan2 = chan2(start_idx:end_idx,:);
    last_train_chan2(:,3) = last_train_chan2(:,3)*(10^-6); % convert microampere to ampere
    charge_chan2 = sum(last_train_chan2(:,3) .* pulse_length); % total charge: current * time = Ampere * Seconds
    train_length2 = last_train_chan2(end,2)-last_train_chan2(1,2);

    chan3_hz = 1./diff_chan3;
    idx = find(chan3_hz<min_hz);
    if ~isempty(idx)
        if idx(end) == numel(chan3_hz)
            idx(end) = [];
        end
    else
        idx = 1;
    end
    start_idx = idx(end)+1;
    end_idx = size(chan3,1);
    last_train_chan3 = chan3(start_idx:end_idx,:);
    last_train_chan3(:,3) = last_train_chan3(:,3)*(10^-6); % convert microampere to ampere
    charge_chan3 = sum(last_train_chan3(:,3) .* pulse_length); % total charge: current * time = Ampere * Seconds
    train_length3 = last_train_chan3(end,2)-last_train_chan3(1,2);
    
    % calculate the amount of time that multiple channels were active at
    % the same time
    overlap_chan1_chan2 = numel(intersect(last_train_chan1(:,2),last_train_chan2(:,2)));
    overlap_chan1_chan3 = numel(intersect(last_train_chan1(:,2),last_train_chan3(:,2)));
    overlap_chan2_chan3 = numel(intersect(last_train_chan2(:,2),last_train_chan3(:,2)));
    total_overlap = (overlap_chan1_chan2+overlap_chan1_chan3+overlap_chan2_chan3)/...
                    (numel(last_train_chan1(:,2)) + numel(last_train_chan2(:,2)) + numel(last_train_chan3(:,2)))*100;
    
    % maximum amplitude
    max_amp = [max(last_train_chan1(:,3)) max(last_train_chan2(:,3)) max(last_train_chan3(:,3))];
    
    % max - median amplitude
    max_mode_amp = mode(max_amp - ([mode(last_train_chan1(:,3)) mode(last_train_chan2(:,3)) mode(last_train_chan3(:,3))]));
    
    % frequency
    freq = round(mean([mode(chan1_hz) mode(chan2_hz) mode(chan3_hz)]));
    
%     % plot last stim train
%     figure;
%     for i=1:size(last_train_chan1,1)
%         plot([last_train_chan1(i,2), last_train_chan1(i,2)],[0 last_train_chan1(i,3)],'Color',[0 0 1 0.7])
%         hold on;   
%     end
% 
%     for i=1:size(last_train_chan3,1)
%         plot([last_train_chan3(i,2), last_train_chan3(i,2)],[0 last_train_chan3(i,3)],'Color',[0 1 0 0.7])
%         hold on;   
%     end
%     for i=1:size(last_train_chan2,1)
%         plot([last_train_chan2(i,2), last_train_chan2(i,2)],[0 last_train_chan2(i,3)],'Color',[1 0 0 0.7])
%         hold on;   
%     end
%     xlabel('time(s)')
%     ylabel('amplitude(A)')
%     sgtitle(['last train: session ', num2str(session), ', set ', num2str(set), ', block ', num2str(block), ', trial ', num2str(trial)])

    % save total charge to variable
    total_charge = [charge_chan1 charge_chan2 charge_chan3];
    train_length = [train_length1 train_length2 train_length3];
else
    total_charge = [NaN NaN NaN];
    train_length = [NaN NaN NaN];
    total_overlap = NaN;
    max_mode_amp = NaN;
    freq = NaN;
end
