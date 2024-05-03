function plot_cursor_exploration(data_folder, subject)
    % determine what data to load
    if strcmp(subject,'P2')
        session = [7 8 9 10 11 12 15 16 17 19 20 21 22 23 24 27 28 29 30 31 32 33]; 
        stim_set = {{1}, {1}, {3}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, ...
                    {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}};           
        block = {{3, 4, 5}, {3, 4}, {3, 4}, {3, 4, 5}, {3, 4, 5, 6}, {3, 4}, ...          
                 {3, 4}, {3, 4}, {3, 4, 5}, {3, 4}, {3, 4}, {3, 4}, {3, 4, 5},...
                 {3, 4, 5}, {3, 4, 5}, {3, 4, 5}, {3, 4, 5}, {3, 4}, {3, 4}, ...
                 {3, 4}, {3, 4}, {3, 4}};
        trials = {{{1, 2, 3}, {1, 2, 3}, {1, 2}},...
                 {{1, 2, 3}, {1, 2, 3}}, ...
                 {{1, 2, 3}, {1, 2, 3}}, ...     
                 {{1, 2, 3}, {1, 2, 3}, {1, 2, 3}}...       
                 {{1, 2, 3}, {1, 2, 3}, {1, 2, 3}, {1, 2, 3}},... 
                 {{1, 2, 3}, {1, 2, 3}},...                      
                 {{1, 2, 3}, {1, 2, 3}},...                    
                 {{1, 2, 3}, {1, 2, 3}},...                      
                 {{1, 2, 3}, {1, 2, 3}, {1, 2, 3}},...          
                 {{1, 2, 3}, {1, 2, 3}},...                     
                 {{1, 3}, {1, 2, 3}},...                        
                 {{1, 2, 3}, {1, 2, 3}},...                      
                 {{1, 2, 3}, {1, 3}, {1, 2, 3}},...             
                 {{1, 2, 3}, {1, 2, 3}, {1, 2, 3}},...            
                 {{1, 2, 3}, {1, 2, 3}, {1, 2, 3}},...            
                 {{1, 2, 3}, {1, 2}, {1}},...                
                 {{1, 2, 3}, {1, 2, 3}, {1, 2, 3}},...      
                 {{1, 3}, {1, 2}},...                         
                 {{1, 2, 3}, {1, 2, 3}},...                 
                 {{1, 2, 3}, {1, 2, 3}},...                   
                 {{1, 2, 3}, {1, 2, 3}},...                     
                 {{1, 2, 3}, {3}}};                            
        date = {'21-Jun-2021', '23-Jun-2021','25-Jun-2021','28-Jun-2021',...
                '07-Jul-2021','12-Jul-2021','21-Jul-2021','20-Sep-2021',...
                '22-Sep-2021','27-Sep-2021', '29-Sep-2021','04-Oct-2021',...
                '06-Oct-2021','18-Oct-2021','20-Oct-2021','28-Oct-2021',...        
                '01-Nov-2021', '03-Nov-2021','08-Nov-2021','23-Nov-2021',...
                '29-Nov-2021','02-Dec-2021'};
    elseif strcmp(subject,'P3')
        session = [3, 5, 6, 7, 8, 9, 11, 12, 13, 13, 14, 14];
        stim_set = {{1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {2}, {1}, {3}};
        block = {{3, 4, 5, 6}, {3, 4, 5, 6}, {3, 4, 5, 6, 7, 8}, {3, 4, 5, 6}, {3, 4}, {3, 4}, {3, 4}, {3, 4}, {3}, {3}, {3}, {4}};
        trials = {{{1, 2, 3}, {1, 2, 3}, {1, 2, 3}, {1, 2, 3}},...
                  {{1, 2, 3}, {1, 2, 3}, {1, 2, 3}, {1, 2, 3}},...
                  {{1, 2, 3}, {1, 2, 3}, {1, 2}, {1, 2, 3}, {1, 2, 3}, {1, 2, 3}},...
                  {{1, 2, 3}, {1, 2}, {1, 2, 3}, {1, 2, 3}},...
                  {{1, 2, 3},{1, 2, 3}},...
                  {{1, 2, 3},{1, 2, 3}},...
                  {{2, 3, 4, 5}, {2, 4, 5}},...
                  {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}},...
                  {{1, 2, 3, 4, 5}},...
                  {{1, 2, 3, 4, 5}},...
                  {{1, 2, 3, 4, 5}},...
                  {{1, 2, 3, 4, 5}}};
        date = {'17-Aug-2021','09-Sep-2021','24-Sep-2021','28-Sep-2021','01-Oct-2021',...
                '07-Oct-2021','24-Nov-2021','18-Jan-2022','08-Feb-2022','08-Feb-2022','22-Mar-2022','22-Mar-2022'};
    elseif strcmp(subject,'C1')
        session = [1,1,2,3,4,5,6,7,8,8,9,10];
        stim_set = {{1},{2},{1},{1},{1},{1},{1},{1},{1},{2},{1},{1}};
        block = {{3},{3,4},{3,4},{3,4},{3,4},{3,4},{3,4},{3,4},{3},{4},{3,4},{3,4}};
        trials = {{{1,2,3,4,5}},...
                 {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5},{1, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}}};
        date = {'15-Nov-2021','15-Nov-2021','20-Dec-2021','27-Dec-2021',...
                  '04-Jan-2022','07-Jan-2022','28-Jan-2022','14-Feb-2022',...
                  '21-Feb-2022','21-Feb-2022','11-Mar-2022','01-Apr-2022'};
    end

    cat_amp_freq = zeros(10,10); 
    cat_bio_drag = zeros(10,10); 
    towel_amp_freq = zeros(10,10);
    towel_bio_drag = zeros(10,10);
    apple_amp_freq = zeros(10,10);
    apple_bio_drag = zeros(10,10);
    key_amp_freq = zeros(10,10);
    key_bio_drag = zeros(10,10);
    toast_amp_freq = zeros(10,10);
    toast_bio_drag = zeros(10,10);
    nr_stims_cat = 0;
    nr_stims_apple = 0;
    nr_stims_toast = 0;
    nr_stims_towel = 0;
    nr_stims_key = 0;
    for s=1:numel(session)
        datapath = fullfile(data_folder,subject,['session.',num2str(session(s))]);

        cd(datapath)
        for ss=1:numel(stim_set{s})
            for b=1:numel(block{s})
                for t=1:numel(trials{s}{b})
                    stimFile = fullfile(['StimData.Set000',num2str(stim_set{s}{ss}),'.Block000',num2str(block{s}{b}),'.Trial000',num2str(trials{s}{b}{t}),'.',date{s},'.json']);
                    stimData{t} = jsondecode(fileread(stimFile));
                    scoreFile = fullfile(['ObjectSensationMappingSatisfaction.Set000',num2str(stim_set{s}{ss}),'.Block000',num2str(block{s}{b}),'.Trial000',num2str(trials{s}{b}{t}),'.',date{s},'.json']);
                    if isfile(scoreFile)
                        scoreData{t} = jsondecode(fileread(scoreFile));
                        satisfaction = round(scoreData{t}.userInfo.satisfaction);
                    else
                        satisfaction = -1;
                    end

                    if satisfaction >= 50 % take only good trials
                        % find idx where participant felt stimulation (stim was on)
                        stim_on_idx = find(stimData{t}.stimInfo.stimulating == 1);

                        % find all amplitudes when stim was on
                        amp_on = stimData{t}.stimInfo.amplitude(stim_on_idx,1);
                        amp_range = sort(stimData{t}.stimInfo.amplitude_ch1);
                        if size(unique(amp_range),1) < 10
                            amp_on = stimData{t}.stimInfo.amplitude(stim_on_idx,2);
                            amp_range = sort(stimData{t}.stimInfo.amplitude_ch2);
                            if size(unique(amp_range),1) < 10
                                amp_on = stimData{t}.stimInfo.amplitude(stim_on_idx,3);
                                amp_range = sort(stimData{t}.stimInfo.amplitude_ch3);
                            end
                        end
                        % convert stim parameters to levels
                        [tf, amp_level] = ismember(amp_on,amp_range);

                        % get frequencies when stim was on and convert to levels
                        freq_on = stimData{t}.stimInfo.frequency(stim_on_idx);
                        freq_range = sort(floor(stimData{t}.stimInfo.frequency_range));
                        [tf, freq_level] = ismember(freq_on,freq_range);

                        % same for bio
                        bio_on = stimData{t}.stimInfo.biomimetic_factor(stim_on_idx);
                        bio_range = sort(stimData{t}.stimInfo.biomimetic_range);
                        [tf, bio_level] = ismember(bio_on,bio_range);

                        % same for drag
                        drag_on = stimData{t}.stimInfo.drag(stim_on_idx);
                        drag_range = sort(stimData{t}.stimInfo.drag_range);
                        [tf, drag_level] = ismember(drag_on,drag_range);
                        drag_level = drag_level;

                        % get all parameter frequencies in one matrix
                        amp_freq_counts = zeros(10,10);
                        bio_drag_counts = zeros(10,10);
                        for i=1:numel(amp_level) % all parameters inputs (amp_level, freq_level, etc.) are the same size
                            amp_freq_counts(amp_level(i), freq_level(i)) = amp_freq_counts(amp_level(i), freq_level(i)) + 1;
                            bio_drag_counts(bio_level(i), drag_level(i)) = bio_drag_counts(bio_level(i), drag_level(i)) + 1;
                        end

                        object = erase(stimData{t}.trialInfo.object,'images\');

                        if strcmp(object, 'cat.png')
                            cat_amp_freq = cat_amp_freq + amp_freq_counts;
                            cat_bio_drag = cat_bio_drag + bio_drag_counts;
                            nr_stims_cat = nr_stims_cat + numel(amp_level);
                        elseif strcmp(object, 'towel.png')
                            towel_amp_freq = towel_amp_freq + amp_freq_counts;
                            towel_bio_drag = towel_bio_drag + bio_drag_counts;
                            nr_stims_towel = nr_stims_towel + numel(amp_level);
                        elseif strcmp(object, 'apple.png')
                            apple_amp_freq = apple_amp_freq + amp_freq_counts;
                            apple_bio_drag = apple_bio_drag + bio_drag_counts;
                            nr_stims_apple = nr_stims_apple + numel(amp_level);
                        elseif strcmp(object, 'toast.png')
                            toast_amp_freq = toast_amp_freq + amp_freq_counts;
                            toast_bio_drag = toast_bio_drag + bio_drag_counts;
                            nr_stims_toast = nr_stims_toast + numel(amp_level);
                        elseif strcmp(object, 'key.png')
                            key_amp_freq = key_amp_freq + amp_freq_counts;
                            key_bio_drag = key_bio_drag + bio_drag_counts;
                            nr_stims_key = nr_stims_key + numel(amp_level);
                        end

                    end

                end
            end
        end
    end

    cd(data_folder)

    % plot cursor behavior across all trials of a particular object
    figure;
    subplot(1,2,1);
    data = round(cat_amp_freq/nr_stims_cat*100,2);
    clims = [0 max(max(data))];
    blue = [0, 0, 1];
    white = [1, 1, 1];
    length = 100;
    cmap = [linspace(white(1),blue(1),length)', linspace(white(2),blue(2),length)', linspace(white(3),blue(3),length)'];
    imagesc(flipud(data'),clims);
    xlabel('amplitude(level)')
    ylabel('frequency(level)');
    yticklabels({'10','9','8','7','6','5','4','3','2','1'});
    colormap(cmap)
    colorbar
    set(gca,'FontSize',14)
    subplot(1,2,2);
    data = round(cat_bio_drag/nr_stims_cat*100,2);
    imagesc(flipud(data'),clims);
    xlabel('biomimetic factor(level)')
    ylabel('drag(level)');
    colormap(cmap)
    yticklabels({'10','9','8','7','6','5','4','3','2','1'});
    colorbar
    sgtitle('cat')
    set(gca,'FontSize',14)

    figure;
    subplot(1,2,1);
    data = round(apple_amp_freq/nr_stims_apple*100,2) - round(cat_amp_freq/nr_stims_cat*100,2);
    clims = [0 max(max(data))];
    blue = [0, 0, 1];
    white = [1, 1, 1];
    length = 100;
    cmap = [linspace(white(1),blue(1),length)', linspace(white(2),blue(2),length)', linspace(white(3),blue(3),length)'];
    imagesc(flipud(data'),clims);
    xlabel('amplitude(level)')
    ylabel('frequency(level)');
    colormap(cmap)
    colorbar
    yticklabels({'10','9','8','7','6','5','4','3','2','1'});
    set(gca,'FontSize',14)
    subplot(1,2,2);
    data = round(apple_bio_drag/nr_stims_apple*100,2);
    clims = [0 max(max(data))];
    imagesc(flipud(data'),clims);
    xlabel('biomimetic factor(level)')
    ylabel('drag(level)');
    colormap(cmap)
    yticklabels({'10','9','8','7','6','5','4','3','2','1'});
    colorbar
    sgtitle('apple')
    set(gca,'FontSize',14)

    figure;
    subplot(1,2,1);
    data = round(towel_amp_freq/nr_stims_towel*100,2);
    clims = [0 max(max(data))];
    blue = [0, 0, 1];
    white = [1, 1, 1];
    length = 100;
    cmap = [linspace(white(1),blue(1),length)', linspace(white(2),blue(2),length)', linspace(white(3),blue(3),length)'];
    imagesc(flipud(data'),clims);
    xlabel('amplitude(level)')
    ylabel('frequency(level)');
    yticklabels({'10','9','8','7','6','5','4','3','2','1'});
    colormap(cmap)
    colorbar
    set(gca,'FontSize',14)
    subplot(1,2,2);
    data = round(towel_bio_drag/nr_stims_towel*100,2);
    clims = [0 max(max(data))];
    imagesc(flipud(data'),clims);
    xlabel('biomimetic factor(level)')
    yticklabels({'10','9','8','7','6','5','4','3','2','1'});
    ylabel('drag(level)');
    colormap(cmap)
    colorbar
    sgtitle('towel')
    set(gca,'FontSize',14)

    figure;
    subplot(1,2,1);
    data = round(toast_amp_freq/nr_stims_toast*100,2);
    clims = [0 max(max(data))];
    blue = [0, 0, 1];
    white = [1, 1, 1];
    length = 100;
    cmap = [linspace(white(1),blue(1),length)', linspace(white(2),blue(2),length)', linspace(white(3),blue(3),length)'];
    imagesc(flipud(data'),clims);
    xlabel('amplitude(level)')
    ylabel('frequency(level)');
    yticklabels({'10','9','8','7','6','5','4','3','2','1'});
    colormap(cmap)
    colorbar
    set(gca,'FontSize',14)
    subplot(1,2,2);
    data = round(toast_bio_drag/nr_stims_toast*100,2);
    clims = [0 max(max(data))];
    imagesc(flipud(data'),clims);
    xlabel('biomimetic factor(level)')
    ylabel('drag(level)');
    colormap(cmap)
    yticklabels({'10','9','8','7','6','5','4','3','2','1'});
    colorbar
    sgtitle('toast');
    set(gca,'FontSize',14)

    figure;
    subplot(1,2,1);
    data = round(key_amp_freq/nr_stims_key*100,2);
    clims = [0 max(max(data))];
    blue = [0, 0, 1];
    white = [1, 1, 1];
    length = 100;
    cmap = [linspace(white(1),blue(1),length)', linspace(white(2),blue(2),length)', linspace(white(3),blue(3),length)'];
    imagesc(flipud(data'),clims);
    xlabel('amplitude(level)')
    ylabel('frequency(level)');
    yticklabels({'10','9','8','7','6','5','4','3','2','1'});
    colormap(cmap)
    colorbar
    set(gca,'FontSize',14)
    subplot(1,2,2);
    data = round(key_bio_drag/nr_stims_key*100,2);
    clims = [0 max(max(data))];
    imagesc(flipud(data'),clims);
    xlabel('biomimetic factor(level)')
    ylabel('drag(level)');
    yticklabels({'10','9','8','7','6','5','4','3','2','1'});
    colormap(cmap)
    colorbar
    sgtitle('key')
    set(gca,'FontSize',14)
end