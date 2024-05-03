function parameters = get_initial_parameters(stimData)
                
    if sum(stimData.stimInfo.channel == [49 58 17]') == 3 || sum(stimData.stimInfo.channel == [56 3 31]') == 3 || sum(stimData.stimInfo.channel == [17 31 53]')
        % find first timepoint of stimulation presentation
        stim_idx = find(stimData.stimInfo.stimulating == 1);
        if isempty(stim_idx)
            parameters = 'no data available';
        else
            first_stim = stim_idx(1);

            % get level (1-10) values of all final parameters
            amplitude_ch1 = stimData.stimInfo.amplitude(first_stim,1);
            amp_range = sort(stimData.stimInfo.amplitude_ch1);
            amp_level = find(amp_range == amplitude_ch1);

            if numel(amp_level) > 1 % it can happen that there are duplicate values in the amp_range of a particular channel
                amplitude_ch2 = stimData.stimInfo.amplitude(first_stim,2);
                amp_range = sort(stimData.stimInfo.amplitude_ch2);
                amp_level1_and_2 = amp_level;
                amp_level = find(amp_range == amplitude_ch2);
                amp_level1_and_2 = intersect(amp_level1_and_2, amp_level);
            end
            if numel(amp_level) > 1 % chances are very low, to zero, that all 3 channels have duplicate values
                amplitude_ch3 = stimData.stimInfo.amplitude(first_stim,3);
                amp_range = sort(stimData.stimInfo.amplitude_ch3);
                amp_level = find(amp_range == amplitude_ch3);
            end
            if numel(amp_level) > 1 % all three channels share an amplitude level
                amp_level = intersect(amp_level1_and_2,amp_level);
            end
            if numel(amp_level) > 1
                amp_level = min(amp_level);
                mess = 'amp level still multiple!'
            end

            freq = stimData.stimInfo.frequency(first_stim);
            freq_range = sort(floor(stimData.stimInfo.frequency_range));
            freq_level = find(freq_range == freq);

            bio = stimData.stimInfo.biomimetic_factor(first_stim);
            bio_range = sort(stimData.stimInfo.biomimetic_range);
            bio_level = find(bio_range == bio);

            drag = stimData.stimInfo.drag(first_stim);
            drag_range = sort(stimData.stimInfo.drag_range);
            drag_level = find(drag_range == drag);

            parameters = [amp_level, freq_level, bio_level, drag_level];
        end
    else
        parameters = 'no data available';
    end

                    