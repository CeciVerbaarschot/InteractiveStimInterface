function compare_able_bodied_and_participant_survey_ratings(data_folder)

    objects = {'apple','banana peel','book','cat','cinnamon roll','glass','pair of glasses','pair of rubber gloves','hammer','hand',...
               'ice cube','electric toothbrush','rock','key','knife','needle','orange','pencil','smartphone','rabbit',...
               'boiled rice','pair of scissors','pair of socks','used sponge','sweater','teddy bear','piece of toast','roll of toilet paper','towel','wig'};
    
    questions = {'compliance','temperature','friction','moisture','macro texture','micro texture','pleasantness','familiarity'};
    
    load(fullfile(data_folder,'able_bodied_survey_data.mat'))
    nr_subjects = size(data,1);

    % get able-bodied ratings per object
    rating_per_object = [];
    current_column = 3;
    mean_within_object = zeros(length(objects),length(questions));
    std_within_object = zeros(length(objects),length(questions));
    all_ratings = [];
    all_objects = [];
    all_subjects = [];
    % for each object
    for t=1:length(objects)
        ratings = zeros(size(data,1),length(questions));
        % get subject ratings for each question on this object
        for q=1:length(questions)
            ratings(:,q) = table2array(data(:,current_column)); 
            current_column = current_column+1;
        end
        ratings(find(ratings == -99)) = 50; % value not changed, so remains at 'neither'
        rating_per_object{t} = ratings;
        all_ratings = [all_ratings; ratings]; % concatenate ratings of all objects
        all_objects = [all_objects; ones(nr_subjects,1)*t]; % remember what object it is
        all_subjects = [all_subjects; [1:nr_subjects]']; % remember what subject it is
        mean_within_object(t,:) = round(mean(ratings,1),2);
        std_within_object(t,:) = round(std(ratings,1),2);
    end
    all_labels = objects(all_objects)';

    idx_cat = find(strcmp(all_labels,'cat'));
    idx_apple = find(strcmp(all_labels,'apple'));
    idx_key = find(strcmp(all_labels,'key'));
    idx_towel = find(strcmp(all_labels,'towel'));
    idx_toast = find(strcmp(all_labels,'piece of toast'));

    selected_data = all_ratings([idx_cat; idx_apple; idx_key; idx_towel; idx_toast],:);
    selected_labels = all_labels([idx_cat; idx_apple; idx_key; idx_towel; idx_toast]);

    selected_data = selected_data(:,1:6);

    % Original values
    cat_score = selected_data(find(strcmp(selected_labels,'cat')),:);
    apple_score = selected_data(find(strcmp(selected_labels,'apple')),:);
    key_score = selected_data(find(strcmp(selected_labels,'key')),:);
    towel_score = selected_data(find(strcmp(selected_labels,'towel')),:);
    toast_score = selected_data(find(strcmp(selected_labels,'piece of toast')),:);

    % Between-object Euclidean distance able-bodied data survey
    euclidean_dist = zeros(5,5);
    for s=1:numel(unique(all_subjects))
        for o1=1:5
            if o1==1
                obj1 = cat_score(s,:);
            elseif o1==2
                obj1 = apple_score(s,:);
            elseif o1==3
                obj1 = key_score(s,:);
            elseif o1==4
                obj1 = towel_score(s,:);
            elseif o1==5
                obj1 = toast_score(s,:);
            end
            for o2=1:5  
                if o2==1
                    obj2 = cat_score(s,:);
                elseif o2==2
                    obj2 = apple_score(s,:);
                elseif o2==3
                    obj2 = key_score(s,:);
                elseif o2==4
                    obj2 = towel_score(s,:);
                elseif o2==5
                    obj2 = toast_score(s,:);
                end
                euclidean_dist(s,o1,o2) = pdist2(obj1, obj2);
            end
        end
    end

    labels = {'towel-toast', 'apple-key','cat-towel','key-towel','cat-apple','key-toast','cat-toast','cat-key','apple-towel','apple-toast'};

    mean_dist = zeros(10,numel(unique(all_subjects)));
    for s=1:numel(unique(all_subjects))
        mean_dist(1,s) = 1-(euclidean_dist(s,4,5)/max(max(euclidean_dist(s,:,:))));
        mean_dist(2,s) = 1-(euclidean_dist(s,2,3)/max(max(euclidean_dist(s,:,:))));
        mean_dist(3,s) = 1-(euclidean_dist(s,1,4)/max(max(euclidean_dist(s,:,:))));
        mean_dist(4,s) = 1-(euclidean_dist(s,3,4)/max(max(euclidean_dist(s,:,:))));
        mean_dist(5,s) = 1-(euclidean_dist(s,1,2)/max(max(euclidean_dist(s,:,:))));
        mean_dist(6,s) = 1-(euclidean_dist(s,3,5)/max(max(euclidean_dist(s,:,:))));
        mean_dist(7,s) = 1-(euclidean_dist(s,1,5)/max(max(euclidean_dist(s,:,:))));
        mean_dist(8,s) = 1-(euclidean_dist(s,1,3)/max(max(euclidean_dist(s,:,:))));
        mean_dist(9,s) = 1-(euclidean_dist(s,2,4)/max(max(euclidean_dist(s,:,:))));
        mean_dist(10,s)= 1-(euclidean_dist(s,2,5)/max(max(euclidean_dist(s,:,:))));
    end
    overall_dist = mean(mean_dist,2);
    [a,i] = sort(overall_dist,'descend')

    % plot object similary able-bodied data
    figure
    bar(overall_dist(i)); hold on
    er = errorbar([1:10],overall_dist(i),std(mean_dist')*0,std(mean_dist'));  
    xticklabels(labels(i))
    xtickangle(45)
    ylim([0 1])
    ylabel('object similarity')

    % load replay data
    P2_replay = load(fullfile(data_folder,'P2','replay_data.mat'));
    P2_replay = P2_replay.confusion;
    C1_replay = load(fullfile(data_folder,'C1','replay_data.mat'));
    C1_replay = C1_replay.confusion;

    % divide into object pairs
    appleKeyAll = mean_dist(2,:);
    catToastAll = mean_dist(7,:);
    catTowelAll = mean_dist(3,:);
    appleTowelAll = mean_dist(9,:);
    catAppleAll = mean_dist(5,:);
    catKeyAll = mean_dist(8,:);

    % plot most similar/most dissimilar objects (able-bodied survey)
    % and most confused/least confused objects (participant replay)
    figure;
    data = {};
    data.similar = [appleKeyAll catToastAll catTowelAll]; 
    data.different = [catKeyAll catAppleAll appleTowelAll];
    violinplot(data); hold on;
    plot([0.5 1.5],[P2_replay(2) P2_replay(2)],'k');
    plot([0.5 1.5],[P2_replay(7) P2_replay(7)],'k');
    plot([0.5 1.5],[C1_replay(2) C1_replay(2)],'r');
    plot([0.5 1.5],[C1_replay(3) C1_replay(3)],'r');
    plot([1.5 2.5],[P2_replay(5) P2_replay(5)],'k');
    plot([1.5 2.5],[P2_replay(8) P2_replay(8)],'k');
    plot([1.5 2.5],[C1_replay(5) C1_replay(5)],'r');
    plot([1.5 2.5],[C1_replay(9) C1_replay(9)],'r');
    ylim([0 1])
    set(gca,'FontSize',15)
end
