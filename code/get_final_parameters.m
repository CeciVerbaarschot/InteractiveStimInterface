function parameters = get_final_parameters(trialData)
                
    if sum(trialData.stimInfo.channel == [49 58 17]') == 3 || sum(trialData.stimInfo.channel == [56 3 31]') == 3 || sum(trialData.stimInfo.channel == [17 31 53]')
        % get level (1-10) values of all final parameters
        amplitude_ch1 = trialData.stimInfo.amplitude(1);
        amp_range = sort(trialData.stimInfo.amplitude_ch1);
        amp_level = find(amp_range == amplitude_ch1);

        if numel(amp_level) > 1 % it can happen that there are duplicate values in the amp_range of a particular channel
            amplitude_ch2 = trialData.stimInfo.amplitude(2);
            amp_range = sort(trialData.stimInfo.amplitude_ch2);
            amp_level1_and_2 = amp_level;
            amp_level = find(amp_range == amplitude_ch2);
            amp_level1_and_2 = intersect(amp_level1_and_2, amp_level);
        end
        if numel(amp_level) > 1 % chances are very low, to zero, that all 3 channels have duplicate values
            amplitude_ch3 = trialData.stimInfo.amplitude(3);
            amp_range = sort(trialData.stimInfo.amplitude_ch3);
            amp_level = find(amp_range == amplitude_ch3);
        end
        if numel(amp_level) > 1 % all three channels share an amplitude level
            amp_level = intersect(amp_level1_and_2,amp_level);
        end

        freq = trialData.stimInfo.frequency;
        freq_range = sort(floor(trialData.stimInfo.frequency_range));
        freq_level = find(freq_range == freq);

        bio = trialData.stimInfo.biomimetic_factor;
        bio_range = sort(trialData.stimInfo.biomimetic_range);
        bio_level = find(bio_range == bio);

        drag = trialData.stimInfo.drag;
        drag_range = sort(trialData.stimInfo.drag_range);
        drag_level = find(drag_range == drag);
        
        parameters = [amp_level, freq_level, bio_level, drag_level];
    else
        parameters = 'no data available';
    end

                    