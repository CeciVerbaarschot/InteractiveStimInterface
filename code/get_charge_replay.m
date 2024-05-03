function [total_charge, train_length, freq, total_overlap, max_mode_amp, max_amp] = get_charge_replay(session, set, block, trial, voltageData)

% find the stim trains in this trial
data = voltageData(find(voltageData(:,1)==session & voltageData(:,2)==set & voltageData(:,3)==block & voltageData(:,4)==trial),5:7);

% amp =  stimdata(i).amplitude(chan);               % microAmplitude
% pulse_length = 1/stimdata(i).frequency;           % length of a single stim pulse
% numPulses = stimdata(i).duration / pulse_length ; % how many pulses in this stim train
% chargedelivered = width1*amp * numPulses;         % microampere * seconds = microcoulomb

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
    if numel(channels)>0
        if sum(data_new(:,1) == channels(1))>0
            chan1 = data_new(find(data_new(:,1) == channels(1)),:);
            chan1 = sortrows(chan1,2);
        end
        total_overlap = 0;
    else
        chan1 = [];
    end
    if numel(channels) > 1
        if sum(data_new(:,1) == channels(2))>0
            chan2 = data_new(find(data_new(:,1) == channels(2)),:);
            chan2 = sortrows(chan2,2);
        end
    else
        chan2 = [];
    end
    if numel(channels) > 2
        if sum(data_new(:,1) == channels(3))>0
            chan3 = data_new(find(data_new(:,1) == channels(3)),:);
            chan3 = sortrows(chan3,2);
        end
    else
        chan3 = [];
    end
    
    if numel(channels) == 3
        overlap_chan1_chan2 = numel(intersect(chan1(:,2),chan2(:,2)));
        overlap_chan1_chan3 = numel(intersect(chan1(:,2),chan3(:,2)));
        overlap_chan2_chan3 = numel(intersect(chan2(:,2),chan3(:,2)));
        total_overlap = (overlap_chan1_chan2+overlap_chan1_chan3+overlap_chan2_chan3)/...
                        (numel(chan1(:,2)) + numel(chan2(:,2)) + numel(chan3(:,2)))*100;
                    
        % maximum amplitude
        max_amp = [max(chan1(:,3)) max(chan2(:,3)) max(chan3(:,3))]; 
        % max - median amplitude
        max_mode_amp = mode(max_amp - ([mode(chan1(:,3)) mode(chan2(:,3)) mode(chan3(:,3))])); 
    elseif numel(channels) == 2
        overlap_chan1_chan2 = numel(intersect(chan1(:,2),chan2(:,2)));
        total_overlap = overlap_chan1_chan2/(numel(chan1(:,2)) + numel(chan2(:,2)))*100;
        
        % maximum amplitude
        max_amp = [max(chan1(:,3)) max(chan2(:,3))]; 
        % max - median amplitude
        max_mode_amp = mode(max_amp - ([mode(chan1(:,3)) mode(chan2(:,3))])); 
        
        max_amp = [max_amp 0];
    else  
        total_overlap = 0;
        
        % maximum amplitude
        max_amp = max(chan1(:,3)); 
        % max - median amplitude
        max_mode_amp = max_amp - mode(chan1(:,3)); 
        max_amp = [max_amp 0 0];
    end

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


    % find last stim train on a given channel
    if ~isempty(chan1)
        chan1_hz = round(mode(1./diff(chan1(:,2))));
        charge_chan1 = sum(chan1(:,3) .* pulse_length); % total charge: current * time = Ampere * Seconds, because amplitude is in microampere, charge is in microcoulomb (1 Coulomb/Second = 1 Ampere, 1 Ampere = 1*(10^-6) microampere)
    else
        charge_chan1 = 0;
        chan1_hz = 0;
    end

    if ~isempty(chan2)
        chan2_hz = round(mode(1./diff(chan2(:,2))));
        charge_chan2 = sum(chan2(:,3) .* pulse_length); % total charge: current * time = Ampere * Seconds, because amplitude is in microampere, charge is in microcoulomb (1 Coulomb/Second = 1 Ampere, 1 Ampere = 1*(10^-6) microampere)
    else
        charge_chan2 = 0;
        chan2_hz = 0;
    end

    if ~isempty(chan3)
        chan3_hz = round(mode(1./diff(chan3(:,2))));
        charge_chan3 = sum(chan3(:,3) .* pulse_length); % total charge: current * time = Ampere * Seconds, because amplitude is in microampere, charge is in microcoulomb (1 Coulomb/Second = 1 Ampere, 1 Ampere = 1*(10^-6) microampere)
    else
        charge_chan3 = 0;
        chan3_hz = 0;
    end
   
    % save total charge to variable
    total_charge = [charge_chan1 charge_chan2 charge_chan3];
    
    freq = round(mean([mode(chan1_hz) mode(chan2_hz) mode(chan3_hz)]));
    pulses = [size(chan1,1) size(chan2,1) size(chan3,1)];
    
    train_length = pulses*(1/freq);
else
    total_charge = [NaN NaN NaN];
    train_length = [NaN NaN NaN];
    max_amp = [NaN NaN NaN];
    pulses = [NaN NaN NaN];
    freq = NaN;
    total_overlap = NaN;
    max_mode_amp = NaN;
end
