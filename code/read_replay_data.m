function read_replay_data(data_folder,subject)

    % WITHIN SESSION
    voltageFile = 'voltageMonitorData.json';
    objects = {'images\cat.png','images\apple.png','images\key.png','images\towel.png','images\toast.png'};

    % determine what data to load
    if strcmp(subject,'P2')
        session = [15 16 17 20 21 22 23 24 27 28 29 30 31 32 33];
        stim_set = {{1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}};
        block = {{8}, {8}, {8}, {8}, {8}, {8}, {8}, {8}, {8}, {8}, {7}, {7}, {8}, {8}, {8}};
        trials = {{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}}};
        date = {'21-Jul-2021','20-Sep-2021','22-Sep-2021', '29-Sep-2021','04-Oct-2021',...
                '06-Oct-2021','18-Oct-2021','20-Oct-2021','28-Oct-2021','01-Nov-2021',...
                '03-Nov-2021','08-Nov-2021','23-Nov-2021','29-Nov-2021','02-Dec-2021'};
    elseif strcmp(subject,'P3')
        session = [5, 6, 7, 11, 12, 12, 13, 14];
        stim_set = {{2}, {1}, {2}, {2}, {1}, {2}, {2}, {3}};
        block = {{9}, {11}, {6}, {7,8}, {7}, {7}, {7,8}, {7}};
        trials = {{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                  {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                  {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}},...
                  {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}},...
                  {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}},...
                  {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}},...
                  {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}},...
                  {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}}};
        date = {'09-Sep-2021','24-Sep-2021','28-Sep-2021','24-Nov-2021','18-Jan-2022','18-Jan-2022','08-Feb-2022', '22-Mar-2022'};
    elseif strcmp(subject,'C1')
        session = [1,2,3,4,5,5,6,6,7,8,9,10];
        stim_set = {{2},{1},{2},{1},{2},{1},{1},{2},{1},{2},{2},{2}};
        block = {{8},{7,8},{7},{7},{7,8},{7,8},{7},{7,8},{7,8},{7},{7,8},{7,8}};
        trials = {{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}},...
                 {{2, 5, 7, 8}, {1, 3, 4, 5, 7, 8}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}},...
                 {{1, 2, 3, 4, 5, 6}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}}};
        date = {'15-Nov-2021','20-Dec-2021','27-Dec-2021','04-Jan-2022','07-Jan-2022',...
            '07-Jan-2022','28-Jan-2022','28-Jan-2022','14-Feb-2022','21-Feb-2022','11-Mar-2022','01-Apr-2022'};
    end

    % read in voltage data
    voltageData = jsondecode(fileread(fullfile(data_folder,subject,voltageFile)));

    % convert cell array voltage data into matrix of numbers
    a = [voltageData.voltageData.info{:}];
    S = sprintf('%s ', a{2:end,:});
    D = sscanf(S, '%f');
    C = reshape(D,[7,size(voltageData.voltageData.info,1)]);
    voltageDataMat = C';

    data = [];
    files = [];
    f = 1;
    replayFiles = [];
    for s=1:numel(session)
        datapath = fullfile(data_folder,subject,['session.',num2str(session(s))]);

        cd(datapath)
        for ss=1:numel(stim_set{s})
            for b=1:numel(block{s})
                if block{s}{b} > 10
                    block_nr = '.Block00';
                else
                    block_nr = '.Block000';
                end
                for t=1:numel(trials{s}{b})
                    if trials{s}{b}{t} < 10
                        choiceFile = fullfile(['SensationObjectMappingChoice.Set000',num2str(stim_set{s}{ss}),block_nr,num2str(block{s}{b}),'.Trial000',num2str(trials{s}{b}{t}),'.',date{s},'.json']);
                    else
                        choiceFile = fullfile(['SensationObjectMappingChoice.Set000',num2str(stim_set{s}{ss}),block_nr,num2str(block{s}{b}),'.Trial00',num2str(trials{s}{b}{t}),'.',date{s},'.json']);
                    end
                    % sensation-object mapping choice
                    choiceData{t} = jsondecode(fileread(choiceFile));
                    replayFile = choiceData{t}.trialInfo.replay_files(choiceData{t}.trialInfo.replay_order(choiceData{t}.trialInfo.replay_idx+1)+1); 
                    trialFile = char(fullfile(data_folder,subject,'all_sensation_files',replayFile));
                    trialData{t} = jsondecode(fileread(trialFile));

                    % satisfaction with previously created sensation
                    satisfactionFile = erase(replayFile,'TrialSummary');
                    satisfactionFile = ['ObjectSensationMappingSatisfaction' satisfactionFile{1}];
                    if isfile(satisfactionFile)
                        scoreData = jsondecode(fileread(satisfactionFile));
                        satisfaction = round(scoreData.userInfo.satisfaction);
                    else
                        satisfaction = -1;
                    end

                    % chosen stimulation parameters in corresponding
                    % object-sensation mapping trial
                    amplitude_ch1 = trialData{t}.stimInfo.amplitude(1);
                    amp_range = sort(trialData{t}.stimInfo.amplitude_ch1);
                    amp_level = find(amp_range == amplitude_ch1);

                    if numel(amp_level) > 1 % it can happen that there are duplicate values in the amp_range of a particular channel
                        amplitude_ch2 = trialData{t}.stimInfo.amplitude(2);
                        amp_range = sort(trialData{t}.stimInfo.amplitude_ch2);
                        amp_level1_and_2 = amp_level;
                        amp_level = find(amp_range == amplitude_ch2);
                        amp_level1_and_2 = intersect(amp_level1_and_2, amp_level);
                    end
                    if numel(amp_level) > 1 % chances are very low, to zero, that all 3 channels have duplicate values
                        amplitude_ch3 = trialData{t}.stimInfo.amplitude(3);
                        amp_range = sort(trialData{t}.stimInfo.amplitude_ch3);
                        amp_level = find(amp_range == amplitude_ch3);
                    end
                    if numel(amp_level) > 1 % all three channels share an amplitude level
                        amp_level = intersect(amp_level1_and_2,amp_level);
                    end

                    freq = trialData{t}.stimInfo.frequency;
                    freq_range = sort(floor(trialData{t}.stimInfo.frequency_range));
                    freq_level = find(freq_range == freq);

                    bio = trialData{t}.stimInfo.biomimetic_factor;
                    bio_range = sort(trialData{t}.stimInfo.biomimetic_range);
                    bio_level = find(bio_range == bio);

                    drag = trialData{t}.stimInfo.drag;
                    drag_range = sort(trialData{t}.stimInfo.drag_range);
                    drag_level = find(drag_range == drag);

                    % real object
                    actual_object = -1;
                    if strcmp(choiceData{t}.userInfo.actual_object,objects(1))
                        actual_object = 1;
                    elseif strcmp(choiceData{t}.userInfo.actual_object,objects(2))
                        actual_object = 2;
                    elseif strcmp(choiceData{t}.userInfo.actual_object,objects(3))
                        actual_object = 3;
                    elseif strcmp(choiceData{t}.userInfo.actual_object,objects(4))
                        actual_object = 4;
                    elseif strcmp(choiceData{t}.userInfo.actual_object,objects(5))
                        actual_object = 5;
                    end

                    % subject choice
                    chosen_object = -1;
                    if strcmp(choiceData{t}.userInfo.chosen_object,objects(1))
                        chosen_object = 1;
                    elseif strcmp(choiceData{t}.userInfo.chosen_object,objects(2))
                        chosen_object = 2;
                    elseif strcmp(choiceData{t}.userInfo.chosen_object,objects(3))
                        chosen_object = 3;
                    elseif strcmp(choiceData{t}.userInfo.chosen_object,objects(4))
                        chosen_object = 4;
                    elseif strcmp(choiceData{t}.userInfo.chosen_object,objects(5))
                        chosen_object = 5;
                    end

                    [total_charge, train_length, freq, total_overlap, max_mode_amp, max_amp] = get_charge_replay(session(s), stim_set{s}{ss}, block{s}{b}, trials{s}{b}{t}, voltageDataMat);

                    data = [data; actual_object chosen_object choiceData{t}.userInfo.certainty actual_object==chosen_object,...
                            amp_level freq_level bio_level drag_level session(s) satisfaction total_charge train_length];
                    files{f} = replayFile;
                    f = f+1;
                    replayFiles = [replayFiles; replayFile];

                end
            end
        end
    end

    data_labels = {'actual object (1=cat, 2=apple, 3=key, 4=towel, 5=toast)','chosen object','certainty (0-100)','accuracy (1=correct, 2=incorrect)', ...
                   'amplitude', 'frequency', 'bio-factor', 'drag', 'session', 'satisfaction (0-100)', 'total_charge (ch1)', 'total_charge (ch2)', 'total_charge (ch3)',...
                   'train_length (ch1)', 'train_length (ch2)', 'train_length (ch3)'};

    % nr apples classified as key + nr keys classified as apple/ nr wrongly classified apples + nr wrongly classified keys
    appleKey   = (sum(data(data(:,1)==2,2)==3) + sum(data(data(:,1)==3,2)==2)) / (sum(data(data(:,1)==2,2)~=2) + sum(data(data(:,1)==3,2)~=3));
    catTowel   = (sum(data(data(:,1)==1,2)==4) + sum(data(data(:,1)==4,2)==1)) / (sum(data(data(:,1)==1,2)~=1) + sum(data(data(:,1)==4,2)~=4));
    towelToast = (sum(data(data(:,1)==4,2)==5) + sum(data(data(:,1)==5,2)==4)) / (sum(data(data(:,1)==4,2)~=4) + sum(data(data(:,1)==5,2)~=5));
    catApple   = (sum(data(data(:,1)==1,2)==2) + sum(data(data(:,1)==2,2)==1)) / (sum(data(data(:,1)==1,2)~=1) + sum(data(data(:,1)==2,2)~=2));
    catKey     = (sum(data(data(:,1)==1,2)==3) + sum(data(data(:,1)==3,2)==1)) / (sum(data(data(:,1)==1,2)~=1) + sum(data(data(:,1)==3,2)~=3));
    keyToast   = (sum(data(data(:,1)==3,2)==5) + sum(data(data(:,1)==5,2)==3)) / (sum(data(data(:,1)==3,2)~=3) + sum(data(data(:,1)==5,2)~=5));
    catToast   = (sum(data(data(:,1)==1,2)==5) + sum(data(data(:,1)==5,2)==1)) / (sum(data(data(:,1)==1,2)~=1) + sum(data(data(:,1)==5,2)~=5));
    appleTowel = (sum(data(data(:,1)==2,2)==4) + sum(data(data(:,1)==4,2)==2)) / (sum(data(data(:,1)==2,2)~=2) + sum(data(data(:,1)==4,2)~=4));
    appleToast = (sum(data(data(:,1)==2,2)==5) + sum(data(data(:,1)==5,2)==2)) / (sum(data(data(:,1)==2,2)~=2) + sum(data(data(:,1)==5,2)~=5));
    keyTowel   = (sum(data(data(:,1)==3,2)==4) + sum(data(data(:,1)==4,2)==3)) / (sum(data(data(:,1)==3,2)~=3) + sum(data(data(:,1)==4,2)~=4));

    confusion = [towelToast, appleKey catTowel keyTowel catApple keyToast catToast catKey appleTowel appleToast];

    cd(fullfile(data_folder,subject));
    save('replay_data.mat','data','data_labels','confusion')

    % plot replay confusion
    figure;
    barData = [catTowel towelToast appleKey catToast catApple keyToast appleTowel appleToast keyTowel catKey];
    [a, i] = sort(barData,'descend');
    labels = {'cat-towel', 'towel-toast','apple-key','cat-toast','cat-apple','key-toast','apple-towel','apple-toast','key-towel', 'cat-key'};
    labels = labels(i);
    bar(barData(i));
    xticklabels(labels)
    xtickangle(45)
    ylim([0 1])
    ylabel('replay confusion')
    set(gca,'FontSize',15)
end