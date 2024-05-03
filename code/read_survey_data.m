function read_survey_data(data_folder, subject)

    % ACROSS SESSIONS (final replay sessions)
    objects = {'images\cat.png','images\apple.png','images\key.png','images\towel.png','images\toast.png'};

    % determine what data to load
    if strcmp(subject,'P2')
        session = 34;
        stim_set = {{1}};
        block = {{1,3}};
        trials = {{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16}}};
        date = {'04-Apr-2022'};
    elseif strcmp(subject,'P3')
        session = 15;
        stim_set = {{1}};
        block = {{1,3}};
        trials = {{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16}}};
        date = {'12-Apr-2022'};
    elseif strcmp(subject,'C1')
        session = 11;
        stim_set = {{1}};
        block = {{1,3}};
        trials = {{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16}}};
        date = {'18-Apr-2022'};
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
                        affectiveFile = fullfile(['AffectiveQuestionnaireData.Set000',num2str(stim_set{s}{ss}),block_nr,num2str(block{s}{b}),'.Trial000',num2str(trials{s}{b}{t}),'.',date{s},'.json']);
                        objectFile = fullfile(['ObjectQuestionnaireData.Set000',num2str(stim_set{s}{ss}),block_nr,num2str(block{s}{b}),'.Trial000',num2str(trials{s}{b}{t}),'.',date{s},'.json']);
                    else
                        affectiveFile = fullfile(['AffectiveQuestionnaireData.Set000',num2str(stim_set{s}{ss}),block_nr,num2str(block{s}{b}),'.Trial00',num2str(trials{s}{b}{t}),'.',date{s},'.json']);
                        objectFile = fullfile(['ObjectQuestionnaireData.Set000',num2str(stim_set{s}{ss}),block_nr,num2str(block{s}{b}),'.Trial00',num2str(trials{s}{b}{t}),'.',date{s},'.json']);
                    end
                    % survey data
                    affectiveData{t} = jsondecode(fileread(affectiveFile));
                    objectData{t} = jsondecode(fileread(objectFile));
                    trialFile = affectiveData{t}.trialInfo.replay_files(affectiveData{t}.trialInfo.replay_order(affectiveData{t}.trialInfo.replay_idx+1)+1); 
                    [a, object_nr] = ismember(trialFile,selected_files);

                    chosen_object = -1;
                    if b == 2 % b == 1 (without object image), b == 2 (with object image)
                        if trials{s}{b}{t} < 10
                            choiceFile = fullfile(['SensationObjectMappingChoice.Set000',num2str(stim_set{s}{ss}),block_nr,num2str(block{s}{b}),'.Trial000',num2str(trials{s}{b}{t}),'.',date{s},'.json']);
                        else
                            if trials{s}{b}{t} == 16
                                choiceFile = fullfile(['SensationObjectMappingChoice.Set000',num2str(stim_set{s}{ss}),block_nr,num2str(block{s}{b}),'.Trial0015','.',date{s},'.json']);
                            else
                                choiceFile = fullfile(['SensationObjectMappingChoice.Set000',num2str(stim_set{s}{ss}),block_nr,num2str(block{s}{b}),'.Trial00',num2str(trials{s}{b}{t}),'.',date{s},'.json']);
                            end
                        end
                        choiceData{t} = jsondecode(fileread(choiceFile));
                        choice = choiceData{t}.userInfo.chosen_object;

                        if strcmp(choice,objects(1))
                            chosen_object = 1;
                        elseif strcmp(choice,objects(2))
                            chosen_object = 2;
                        elseif strcmp(choice,objects(3))
                            chosen_object = 3;
                        elseif strcmp(choice,objects(4))
                            chosen_object = 4;
                        elseif strcmp(choice,objects(5))
                            chosen_object = 5;
                        end
                    end

                    trialFile = char(fullfile(data_folder,subject,'all_sensation_files',trialFile));
                    trialData{t} = jsondecode(fileread(trialFile));
                    object = trialData{t}.trialInfo.object;

                    actual_object = -1;
                    if strcmp(object,objects(1))
                        actual_object = 1;
                    elseif strcmp(object,objects(2))
                        actual_object = 2;
                    elseif strcmp(object,objects(3))
                        actual_object = 3;
                    elseif strcmp(object,objects(4))
                        actual_object = 4;
                    elseif strcmp(object,objects(5))
                        actual_object = 5;
                    end

                    naturalness = affectiveData{t}.userInfo.naturalness;
                    pleasantness = affectiveData{t}.userInfo.pleasantness;
                    familiarity = affectiveData{t}.userInfo.familiarity;
                    pain = affectiveData{t}.userInfo.pain;

                    compliance = objectData{t}.userInfo.compliance;
                    friction = objectData{t}.userInfo.friction;
                    moisture = objectData{t}.userInfo.moisture;
                    micro_struct = objectData{t}.userInfo.micro_struct;
                    macro_struct = objectData{t}.userInfo.macro_struct;
                    temperature = objectData{t}.userInfo.object_temp;

                    data = [data; object_nr b actual_object naturalness pleasantness familiarity pain compliance friction moisture micro_struct macro_struct temperature chosen_object];
                end
            end
        end
    end

    % able-bodied survey data (control).
    % Consists of the median rating across the object survey questions 
    % (columns: compliance, friction, column 3 = moisture, micro-struct, macro-struct, temperature)
    % for each object (rows: cat, apple, key, towel, toast)
    cd(data_folder)
    control_data = load('able_bodied_survey_summary.mat');
    control_data = control_data.bar_data;

    % actual object = chosen object
    data_copy = data;
    [a idx1] = sort(data(data(:,2)==1,1));
    [a idx2] = sort(data(data(:,2)==2,1));
    data_copy(data_copy(:,2)==1,:) = data_copy(idx1,:);
    data_copy(data_copy(:,2)==2,:) = data_copy(idx2+15,:);
    data_copy(data_copy(:,2)==1,3) = data_copy(data_copy(:,2)==2,14);
    data_copy(data_copy(:,2)==2,3) = data_copy(data_copy(:,2)==2,14);

    % look at abs difference in mean across all questions and objects between
    % actual object is chosen object
    object = 1;
    nv_cat = data_copy(data_copy(:,2)==1 & data_copy(:,3)==object,8:13); % non visual
    v_cat = data_copy(data_copy(:,2)==2 & data_copy(:,3)==object,8:13); % visual
    object = 2;
    nv_apple = data_copy(data_copy(:,2)==1 & data_copy(:,3)==object,8:13); % non visual
    v_apple = data_copy(data_copy(:,2)==2 & data_copy(:,3)==object,8:13); % visual
    object = 3;
    nv_key = data_copy(data_copy(:,2)==1 & data_copy(:,3)==object,8:13); % non visual
    v_key = data_copy(data_copy(:,2)==2 & data_copy(:,3)==object,8:13); % visual
    object = 4;
    nv_towel = data_copy(data_copy(:,2)==1 & data_copy(:,3)==object,8:13); % non visual
    v_towel = data_copy(data_copy(:,2)==2 & data_copy(:,3)==object,8:13); % visual
    object = 5;
    nv_toast = data_copy(data_copy(:,2)==1 & data_copy(:,3)==object,8:13); % non visual
    v_toast = data_copy(data_copy(:,2)==2 & data_copy(:,3)==object,8:13); % visual

    % visual and non visual context
    std_visual = [];
    std_nvisual = [];
    diff_means = [];
    diff_means_v = [];
    diff_means_nv = [];
    if size(v_cat,1)>1 % at least two repetitions of this object
        std_visual = [std_visual; std(v_cat)];
        std_nvisual = [std_nvisual; std(nv_cat)];
        diff_means = [diff_means; abs(mean(v_cat)-mean(nv_cat))]; 
        diff_means_v = [diff_means_v; abs(control_data(1,:)-mean(v_cat))];
        diff_means_nv = [diff_means_nv; abs(control_data(1,:)-mean(nv_cat))];
    else
        diff_means_v = [diff_means_v; abs(control_data(1,:)-v_cat)];
        diff_means_nv = [diff_means_nv; abs(control_data(1,:)-nv_cat)];
    end
    if size(v_apple,1)>1 % at least two repetitions of this object
        std_visual = [std_visual; std(v_apple)];
        std_nvisual = [std_nvisual; std(nv_apple)];
        diff_means = [diff_means; abs(mean(v_apple)-mean(nv_apple))]; 
        diff_means_v = [diff_means_v; abs(control_data(2,:)-mean(v_apple))];
        diff_means_nv = [diff_means_nv; abs(control_data(2,:)-mean(nv_apple))];
    else
        diff_means_v = [diff_means_v; abs(control_data(2,:)-v_apple)];
        diff_means_nv = [diff_means_nv; abs(control_data(2,:)-nv_apple)];
    end
    if size(v_key,1)>1 % at least two repetitions of this object
        std_visual = [std_visual; std(v_key)];
        std_nvisual = [std_nvisual; std(nv_key)];
        diff_means = [diff_means; abs(mean(v_key)-mean(nv_key))]; 
        diff_means_v = [diff_means_v; abs(control_data(3,:)-mean(v_key))];
        diff_means_nv = [diff_means_nv; abs(control_data(3,:)-mean(nv_key))];
    else
        diff_means_v = [diff_means_v; abs(control_data(3,:)-v_key)];
        diff_means_nv = [diff_means_nv; abs(control_data(3,:)-nv_key)];
    end
    if size(v_towel,1)>1 % at least two repetitions of this object
        std_visual = [std_visual; std(v_towel)];
        std_nvisual = [std_nvisual; std(nv_towel)];
        diff_means = [diff_means; abs(mean(v_towel)-mean(nv_towel))]; 
        diff_means_v = [diff_means_v; abs(control_data(4,:)-mean(v_towel))];
        diff_means_nv = [diff_means_nv; abs(control_data(4,:)-mean(nv_towel))];
    else
        diff_means_v = [diff_means_v; abs(control_data(4,:)-v_towel)];
        diff_means_nv = [diff_means_nv; abs(control_data(4,:)-nv_towel)];
    end
    if size(v_toast,1)>1 % at least two repetitions of this object
        std_visual = [std_visual; std(v_toast)];
        std_nvisual = [std_nvisual; std(nv_toast)];
        diff_means = [diff_means; abs(mean(v_toast)-mean(nv_toast))]; 
        diff_means_v = [diff_means_v; abs(control_data(5,:)-mean(v_toast))];
        diff_means_nv = [diff_means_nv; abs(control_data(5,:)-mean(nv_toast))];
    else
        diff_means_v = [diff_means_v; abs(control_data(4,:)-v_towel)];
        diff_means_nv = [diff_means_nv; abs(control_data(4,:)-nv_towel)];
    end

    within_std_v = mean(mean(std_visual));
    within_std_nv = mean(mean(std_nvisual));

    across_std_v = mean(std([v_cat; v_apple; v_towel; v_toast; v_key]));
    across_std_nv = mean(std([nv_cat; nv_apple; nv_towel; nv_toast; nv_key]));

    cd(fullfile(data_folder,subject));
    save('object_survey_data.mat','std_visual','std_nvisual','diff_means_v','diff_means_nv');
end
