function plot_pre_and_post_amplitude(data_folder, subject)

    if strcmp(subject,'P2')
        possible_amp_range = [10, 16, 22, 30, 36, 42, 48, 54, 62, 68, 74, 80, 88, 94, 100];  
        standard_amps = [48,10,100];
        session = [8 9 10 11 12 15 16 17 19 20 21 22 23 24 27 28 29 30 31 32 33]; % starting at session 7 with satisfaction ratings.
        stim_set = {{1},{1, 3},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},...         
                      {1},{1},{1},{1},{1},{1},{1},{1}};      
        block = {{1, 5},{1},{1, 6},{1, 7},{1, 7},{1, 6},{1, 6},{1, 6},{1, 6},...        
                 {1, 6},{1, 6}, {1, 6},{1, 6},{1, 6},{1, 6},{1, 6},{1, 5},{1, 5},...
                 {1, 6},{1, 6},{1, 6}};       
        order = {{1, 2},{1},{1, 2},{1, 2},{1, 2},{1, 2},{1, 2},{1, 2},{1, 2},{1, 2},...        
                 {1, 2},{1, 2},{1, 2},{1, 2},{1, 2},{1, 2},{1, 2},{1, 2},{1, 2},...
                 {1, 2},{1, 2}};       
        trials = [1:3];
        date = {'23-Jun-2021','25-Jun-2021','28-Jun-2021',...
                '07-Jul-2021','12-Jul-2021','21-Jul-2021','20-Sep-2021',...
                '22-Sep-2021','27-Sep-2021', '29-Sep-2021','04-Oct-2021',...
                '06-Oct-2021','18-Oct-2021','20-Oct-2021','28-Oct-2021',...
                '01-Nov-2021', '03-Nov-2021','08-Nov-2021','23-Nov-2021',...
                '29-Nov-2021','02-Dec-2021'};
    elseif strcmp(subject,'P3')
        possible_amp_range = [10, 14, 20, 24, 30, 34, 40, 44, 50, 54, 60, 64, 70, 74, 80];
        standard_amps = [44,10,80];
        session = [3, 5, 6, 7, 8, 9, 11, 11, 12, 13, 13, 14, 14];
        stim_set = {{1}, {1}, {1}, {2}, {1}, {1}, {1}, {2}, {1}, {1}, {2}, {1}, {3}};
        block = {{1, 7}, {1, 7}, {1, 9}, {1, 4}, {1, 7}, {1, 7}, {1}, {1}, {1 5}, {1}, {1}, {1}, {1}};
        order = {{1, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 2}, {1}, {2}, {1, 2}, {1}, {2}, {1}, {2}};
        trials = [1:3];
        date = {'17-Aug-2021','09-Sep-2021','24-Sep-2021','28-Sep-2021','01-Oct-2021',...
                '07-Oct-2021','24-Nov-2021','24-Nov-2021','18-Jan-2022','08-Feb-2022','08-Feb-2022','22-Mar-2022','22-Mar-2022'};
    elseif strcmp(subject,'C1')
        possible_amp_range = [10, 16, 22, 28, 32, 38, 44, 50, 56, 62, 68, 72, 78, 84, 90]; 
        standard_amps = [44,10,90];
        session = [1, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 8, 9, 9, 10];
        stim_set = {{1},{2},{1},{1},{2},{1},{1},{1},{2},{1},{1},{2},{1},{2},{1}};
        block = {{1},{1},{1,5},{1},{1},{1,5},{1,5},{1},{1},{1,5},{1},{1},{1},{5},{1,5}};
        order = {{1},{2},{1,2},{1},{2},{1,2},{1,2},{1},{2},{1,2},{1},{2},{1},{2},{1,2}};
        trials = [1,2,3];
        date = {'15-Nov-2021','15-Nov-2021','20-Dec-2021','27-Dec-2021','27-Dec-2021','04-Jan-2022','07-Jan-2022','28-Jan-2022','28-Jan-2022','14-Feb-2022',...
                  '21-Feb-2022','21-Feb-2022','11-Mar-2022','11-Mar-2022','01-Apr-2022'};
    end

    axes = {'frequency','amplitude','biomimetic factor','drag'};

    all_amps = [];
    amp_min = [];
    amp_max = [];
    for s=1:numel(session)
        datapath = fullfile(data_folder,subject,['session.',num2str(session(s))]);

        cd(datapath)
        for ss=1:numel(stim_set{s})
            for b=1:numel(block{s})
                for t=1:numel(trials)
                    trialFile = fullfile(['AmplitudeData.Set000',num2str(stim_set{s}{ss}),'.Block000',num2str(block{s}{b}),'.Trial000',num2str(trials(t)),'.',date{s},'.json']);
                    trialData{t} = jsondecode(fileread(trialFile));

                    amps = trialData{t}.stimInfo.current_amplitude;
                    all_amps = [all_amps; amps' order{s}{b}];

                    if t==3
                        [minValue,closestIndex] = min(abs(possible_amp_range-mean(trialData{t}.stimInfo.amplitude_ch1(:,1)))); closestValue1 = possible_amp_range(closestIndex); 
                        [minValue,closestIndex] = min(abs(possible_amp_range-mean(trialData{t}.stimInfo.amplitude_ch2(:,1)))); closestValue2 = possible_amp_range(closestIndex); 
                        [minValue,closestIndex] = min(abs(possible_amp_range-mean(trialData{t}.stimInfo.amplitude_ch3(:,1)))); closestValue3 = possible_amp_range(closestIndex); 
                        amp_min = [amp_min; closestValue1 closestValue2 closestValue3 order{s}{b}];

                        [minValue,closestIndex] = min(abs(possible_amp_range-mean(trialData{t}.stimInfo.amplitude_ch1(:,2)))); closestValue1 = possible_amp_range(closestIndex); 
                        [minValue,closestIndex] = min(abs(possible_amp_range-mean(trialData{t}.stimInfo.amplitude_ch2(:,2)))); closestValue2 = possible_amp_range(closestIndex); 
                        [minValue,closestIndex] = min(abs(possible_amp_range-mean(trialData{t}.stimInfo.amplitude_ch3(:,2)))); closestValue3 = possible_amp_range(closestIndex); 
                        amp_max = [amp_max; closestValue1 closestValue2 closestValue3 order{s}{b}];
                    end
                end
            end
        end
    end

    % divide pre and post amp ranges
    amp_min_pre = amp_min(amp_min(:,4)==1,1:3);
    amp_min_post = amp_min(amp_min(:,4)==2,1:3);
    amp_max_pre = amp_max(amp_max(:,4)==1,1:3);
    amp_max_post = amp_max(amp_max(:,4)==2,1:3);

    figure;
    subplot(1,2,1)
    a = -0.25;
    b = 0.25;
    r = (b-a).*rand(size([amp_min_pre(:,1); amp_max_pre(:,1)])) + a;
    scatter(ones(size([amp_min_pre(:,1); amp_max_pre(:,1)]))+r,[amp_min_pre(:,1); amp_max_pre(:,1)],100,'filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4); hold on;
    rectangle('Position',[0.75 mean(amp_min_pre(:,1)) 0.5 mean(amp_max_pre(:,1))-mean(amp_min_pre(:,1))]);
    scatter(ones(size([amp_min_pre(:,2); amp_max_pre(:,2)]))*2+r,[amp_min_pre(:,2); amp_max_pre(:,2)],100,'filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4)
    rectangle('Position',[1.75 mean(amp_min_pre(:,2)) 0.5 mean(amp_max_pre(:,2))-mean(amp_min_pre(:,2))]);
    scatter(ones(size([amp_min_pre(:,3); amp_max_pre(:,3)]))*3+r,[amp_min_pre(:,3); amp_max_pre(:,3)],100,'filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4)
    rectangle('Position',[2.75 mean(amp_min_pre(:,3)) 0.5 mean(amp_max_pre(:,3))-mean(amp_min_pre(:,3))]);
    ylim([0 100])
    xticks([1, 2, 3])
    xticklabels({'channel 1', 'channel 2', 'channel 3'})
    ylabel('amplitude(\muA)')
    title([subject, ' - pre'])
    set(gca,'FontSize',15)
    subplot(1,2,2)
    a = -0.25;
    b = 0.25;
    r = (b-a).*rand(size([amp_min_post(:,1); amp_max_post(:,1)])) + a;
    scatter(ones(size([amp_min_post(:,1); amp_max_post(:,1)]))+r,[amp_min_post(:,1); amp_max_post(:,1)],100,'filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4); hold on;
    rectangle('Position',[0.75 mean(amp_min_post(:,1)) 0.5 mean(amp_max_post(:,1))-mean(amp_min_post(:,1))]);
    scatter(ones(size([amp_min_post(:,2); amp_max_post(:,2)]))*2+r,[amp_min_post(:,2); amp_max_post(:,2)],100,'filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4)
    rectangle('Position',[1.75 mean(amp_min_post(:,2)) 0.5 mean(amp_max_post(:,2))-mean(amp_min_post(:,2))]);
    scatter(ones(size([amp_min_post(:,3); amp_max_post(:,3)]))*3+r,[amp_min_post(:,3); amp_max_post(:,3)],100,'filled','MarkerFaceAlpha',.4,'MarkerEdgeAlpha',.4)
    rectangle('Position',[2.75 mean(amp_min_post(:,3)) 0.5 mean(amp_max_post(:,3))-mean(amp_min_post(:,3))]);
    ylim([0 100])
    xticks([1, 2, 3])
    xticklabels({'channel 1', 'channel 2', 'channel 3'})
    ylabel('amplitude(\muA)')
    title([subject, ' - post'])
    set(gca,'FontSize',15)
end
