function parameters = get_actual_parameters(trialData)
                
    if sum(trialData.stimInfo.channel == [49 58 17]') == 3 || sum(trialData.stimInfo.channel == [56 3 31]') == 3 || sum(trialData.stimInfo.channel == [17 31 53]')
        % get level (1-10) values of all final parameters
        amplitude_ch1 = trialData.stimInfo.amplitude(1);
        amplitude_ch2 = trialData.stimInfo.amplitude(2);
        amplitude_ch3 = trialData.stimInfo.amplitude(3);
        mean_amp = mean([amplitude_ch1 amplitude_ch2 amplitude_ch3]);

        freq = trialData.stimInfo.frequency;
        
        bio = trialData.stimInfo.biomimetic_factor;

        drag = trialData.stimInfo.drag;
        
        parameters = [mean_amp, freq, bio, drag];
    else
        parameters = 'no data available';
    end
end

                    