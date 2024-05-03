function check_across_session_replay_performance(data_folder, subject)

    objects = {'images\cat.png','images\apple.png','images\key.png','images\towel.png','images\toast.png'};

    if strcmp(subject,'P2')
        session = [34, 35];
        stim_set = {{1}, {1}};
        block = {{3},{4,5}};
        trials = {...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}}};
        date = {'04-Apr-2022','11-Apr-2022'};
    elseif strcmp(subject,'P3')
        session = [15, 16];
        stim_set = {{1}, {1}};
        block = {{3},{4,5}};
        trials = {...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}},...
                 {{1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}}};
        date = {'12-Apr-2022','14-Apr-2022'};

    elseif strcmp(subject,'C1')
        session = [11, 12];
        stim_set = {{1}, {1}};
        block = {{3},{4,5}};
        trials = {...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}},...
                 {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}}};
        date = {'18-Apr-2022','19-Apr-2022'};
    end

    selected_files = load(fullfile(data_folder,subject,'selected_objects_for_replay.mat'));
    selected_files = selected_files.selected_files;

    data = [];
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
                        dataFile = fullfile(['SensationObjectMappingData.Set000',num2str(stim_set{s}{ss}),block_nr,num2str(block{s}{b}),'.Trial000',num2str(trials{s}{b}{t}),'.',date{s},'.json']);
                    else
                        choiceFile = fullfile(['SensationObjectMappingChoice.Set000',num2str(stim_set{s}{ss}),block_nr,num2str(block{s}{b}),'.Trial00',num2str(trials{s}{b}{t}),'.',date{s},'.json']);
                        dataFile = fullfile(['SensationObjectMappingData.Set000',num2str(stim_set{s}{ss}),block_nr,num2str(block{s}{b}),'.Trial00',num2str(trials{s}{b}{t}),'.',date{s},'.json']);
                    end
                    choiceData{t} = jsondecode(fileread(choiceFile));
                    allData{t} = jsondecode(fileread(dataFile));
                    allChoices = allData{t}.userInfo.chose_objects;
                    uniqueChoices = unique(allChoices);
                    timeSpendOnObjects = zeros(size(objects));
                    for u=1:numel(uniqueChoices)
                        idx = find(strcmp(objects,uniqueChoices(u)));
                        if ~isempty(idx)
                            timeSpendOnObjects(idx) = sum(strcmp(allChoices,uniqueChoices(u)));
                            timeSpendOnObjects(idx) = round(timeSpendOnObjects(idx)/numel(allChoices)*100);
                        end
                    end
                    trialData{t} = choiceData{t}.trialInfo.replay_files(choiceData{t}.trialInfo.replay_order(choiceData{t}.trialInfo.replay_idx+1)+1); 
                    [a, object_nr] = ismember(trialData{t},selected_files);

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

                    data = [data; actual_object chosen_object choiceData{t}.userInfo.certainty actual_object==chosen_object session(s) object_nr timeSpendOnObjects];

                end
            end
        end
    end

    [a,idx] = sort(data(:,6));
    data_sorted = data(idx,:);

    data_sorted(data_sorted(:,1)==1,6)
    choices = [];
    for d=1:15 % 15 unique sensations
        this_sensation = data_sorted(data_sorted(:,6)==d,:);
        [m,f] = mode(this_sensation(:,2));
        if f > 1
            choices = [choices; unique(this_sensation(:,1)) m f]; % most frequency choice
        else
            choices = [choices; unique(this_sensation(:,1)) -1 f]; % random choice
        end
    end
    sum(choices(:,1)==choices(:,2))

    % performance per session
    perf_per_session = [];
    p = 1;
    for s=min(data(:,5)):max(data(:,5))
        if numel(find(data(:,5)==s))>0
            sdata = data(find(data(:,5)==s),:);
            perf_per_session(p) = sum(sdata(:,4))/size(sdata,1)*100;
            p = p+1;
        end
    end

    save([subject,'_replay_perf.mat'],'perf_per_session');

    % performance
    perf = mean(perf_per_session)
    perf_across = sum(data(:,4))/size(data,1)*100
end