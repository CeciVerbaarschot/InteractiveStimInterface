function plot_distances_replay(data_folder, subject) 

    load(fullfile(data_folder, subject,'replay_data.mat')); 
    
    % normalize satisfaction scores
    data(:,10) = (data(:,10) - (min(data(:,10)))) / (max(data(:,10))-min(data(:,10)))*100;
     
    files = unique(replayFiles);
    correct_objects = [];
    incorrect_objects = [];
    consistent_objects = [];
    all_objects = [];
    for i=1:numel(files)
        pdata = data(strcmp(replayFiles,files{i}),:);
        if sum(pdata(:,1)==pdata(:,2)) == size(pdata,1) % all correct
            correct_objects = [correct_objects; pdata(1,:)]; % need to add only one of the reps
        elseif size(pdata,1)>2 && (sum(pdata(:,1)==pdata(:,2)) >= 2) % 2 out of 3 correct
            correct_objects = [correct_objects; pdata(1,:)]; % need to add only one of the reps
        elseif numel(unique(pdata(:,2)))==1 && numel(pdata(:,2))>1 % at least two repetitions & they are all the same class, albeit not the target class
            consistent_objects = [consistent_objects; pdata(1,:)];
        else
            incorrect_objects = [incorrect_objects; pdata(1,:)];
        end
        if pdata(1,10) > 50 % delete all objects < 50 satisfaction
            all_objects = [all_objects; pdata(1,:)];
        end
    end

    % normalize parameters
    norm_correct_objects = all_objects;
    norm_correct_objects(:,5) = (norm_correct_objects(:,5) - (min(norm_correct_objects(:,5)))) / (max(norm_correct_objects(:,5))-min(norm_correct_objects(:,5)))*10;
    norm_correct_objects(:,6) = (norm_correct_objects(:,6) - (min(norm_correct_objects(:,6)))) / (max(norm_correct_objects(:,6))-min(norm_correct_objects(:,6)))*10;
    norm_correct_objects(:,7) = (norm_correct_objects(:,7) - (min(norm_correct_objects(:,7)))) / (max(norm_correct_objects(:,7))-min(norm_correct_objects(:,7)))*10;
    norm_correct_objects(:,8) = (norm_correct_objects(:,8) - (min(norm_correct_objects(:,8)))) / (max(norm_correct_objects(:,8))-min(norm_correct_objects(:,8)))*10;
    
    save([subject,'norm_all.mat'],'norm_correct_objects');
    
    cat = all_objects(all_objects(:,1)==1,5:8);
    apple = all_objects(all_objects(:,1)==2,5:8);
    key = all_objects(all_objects(:,1)==3,5:8);
    towel = all_objects(all_objects(:,1)==4,5:8);
    toast = all_objects(all_objects(:,1)==5,5:8);
    
    [X,Y,Z] = sphere(200);

    dim = [1 2 3 4];
    labels = {'amplitude','frequency','biomimetic factor','drag'};
    idx = [3 1 2];

    xcat = ((iqr(cat(:,dim(idx(1))))/2)*X(:))+prctile(cat(:,dim(idx(1))),25)+(iqr(cat(:,dim(idx(1))))/2);
    ycat = ((iqr(cat(:,dim(idx(2))))/2)*Y(:))+prctile(cat(:,dim(idx(2))),25)+(iqr(cat(:,dim(idx(2))))/2);
    zcat = ((iqr(cat(:,dim(idx(3))))/2)*Z(:))+prctile(cat(:,dim(idx(3))),25)+(iqr(cat(:,dim(idx(3))))/2);
    
    xapple = ((iqr(apple(:,dim(idx(1))))/2)*X(:))+prctile(apple(:,dim(idx(1))),25)+(iqr(apple(:,dim(idx(1))))/2);
    yapple = ((iqr(apple(:,dim(idx(2))))/2)*Y(:))+prctile(apple(:,dim(idx(2))),25)+(iqr(apple(:,dim(idx(2))))/2);
    zapple = ((iqr(apple(:,dim(idx(3))))/2)*Z(:))+prctile(apple(:,dim(idx(3))),25)+(iqr(apple(:,dim(idx(3))))/2);
     
    xkey = ((iqr(key(:,dim(idx(1))))/2)*X(:))+prctile(key(:,dim(idx(1))),25)+(iqr(key(:,dim(idx(1))))/2);
    ykey = ((iqr(key(:,dim(idx(2))))/2)*Y(:))+prctile(key(:,dim(idx(2))),25)+(iqr(key(:,dim(idx(2))))/2);
    zkey = ((iqr(key(:,dim(idx(3))))/2)*Z(:))+prctile(key(:,dim(idx(3))),25)+(iqr(key(:,dim(idx(3))))/2);
    
    xtowel = ((iqr(towel(:,dim(idx(1))))/2)*X(:))+prctile(towel(:,dim(idx(1))),25)+(iqr(towel(:,dim(idx(1))))/2);
    ytowel = ((iqr(towel(:,dim(idx(2))))/2)*Y(:))+prctile(towel(:,dim(idx(2))),25)+(iqr(towel(:,dim(idx(2))))/2);
    ztowel = ((iqr(towel(:,dim(idx(3))))/2)*Z(:))+prctile(towel(:,dim(idx(3))),25)+(iqr(towel(:,dim(idx(3))))/2);
    
    xtoast = ((iqr(toast(:,dim(idx(1))))/2)*X(:))+prctile(toast(:,dim(idx(1))),25)+(iqr(toast(:,dim(idx(1))))/2);
    ytoast = ((iqr(toast(:,dim(idx(2))))/2)*Y(:))+prctile(toast(:,dim(idx(2))),25)+(iqr(toast(:,dim(idx(2))))/2);
    ztoast = ((iqr(toast(:,dim(idx(3))))/2)*Z(:))+prctile(toast(:,dim(idx(3))),25)+(iqr(toast(:,dim(idx(3))))/2);
    
    mn = {};
    mn.cat = median(all_objects(all_objects(:,1)==1,5:8));
    mn.apple = median(all_objects(all_objects(:,1)==2,5:8));
    mn.key = median(all_objects(all_objects(:,1)==3,5:8));
    mn.towel = median(all_objects(all_objects(:,1)==4,5:8));
    mn.toast = median(all_objects(all_objects(:,1)==5,5:8));
    
    figure
    scatter3(mn.cat(dim(idx(1))), mn.cat(dim(idx(2))), mn.cat(dim(idx(3))),100,'k','filled'); hold on;
    scatter3(xcat,ycat,zcat,10,'r')
    
    scatter3(mn.apple(dim(idx(1))),mn.apple(dim(idx(2))), mn.apple(dim(idx(3))),100,'k','filled'); hold on;
    scatter3(xapple,yapple,zapple,10,'b')
    
    scatter3(mn.key(dim(idx(1))), mn.key(dim(idx(2))), mn.key(dim(idx(3))), 100,'k','filled'); hold on;
    scatter3(xkey,ykey,zkey,10,'g'); 
    
    scatter3(mn.towel(dim(idx(1))), mn.towel(dim(idx(2))), mn.towel(dim(idx(3))),100,'k','filled'); 
    scatter3(xtowel,ytowel,ztowel,10,'c')
    
    scatter3(mn.toast(dim(idx(1))), mn.toast(dim(idx(2))), mn.toast(dim(idx(3))),100,'k','filled'); 
    scatter3(xtoast,ytoast,ztoast,10,'m'); 
    
    view(-60,15) 
    
    xlim([0 10]);
    ylim([0 10]);
    zlim([0 10]);
    yticks([0 5 10])
    zlim([0 10]);
    zticks([0 5 10])
    
    xlabel(labels(idx(1)))
    ylabel(labels(idx(2)))
    zlabel(labels(idx(3)))
    
    title([subject,' correct'])
    set(gca,'FontSize',15)
    
    % % %
    % compliance: soft (cat, towel), hard (key, apple, toast)
    % temperature: cold (key, apple), warm (cat, toast, towel)
    % friction: slippery (key, apple, cat), sticky (toast, towel)
    % macro struct: round (cat, towel, apple), toast (key, toast)
    % micro struct: smooth (cat, apple, key), rough (towel, toast)
    
    compliance = [];
    temperature = [];
    friction = [];
    macroStruct = [];
    microStruct = [];
    for a=1:size(all_objects,1)
        if (all_objects(a,1) == 1 || all_objects(a,1) == 4) % soft
            compliance = [compliance; all_objects(a,:)];
        end
        if (all_objects(a,1) == 2 || all_objects(a,1) == 3 || all_objects(a,1) == 5) % hard
             compliance = [compliance; all_objects(a,:)];
        end
        if (all_objects(a,1) == 2 || all_objects(a,1) == 3) % cold
            temperature = [temperature; all_objects(a,:)];
        end
        if (all_objects(a,1) == 1 || all_objects(a,1) == 4 || all_objects(a,1) == 5) % warm
            temperature = [temperature; all_objects(a,:)];
        end
        if (all_objects(a,1) == 1 || all_objects(a,1) == 2 || all_objects(a,1) == 4) % round
            macroStruct = [macroStruct; all_objects(a,:)];
        end
        if (all_objects(a,1) == 3 || all_objects(a,1) == 5) % edged
            macroStruct = [macroStruct; all_objects(a,:)];
        end
        if (all_objects(a,1) == 1 || all_objects(a,1) == 2 || all_objects(a,1) == 3) % smooth
            microStruct = [microStruct; all_objects(a,:)];
        end
        if (all_objects(a,1) == 4 || all_objects(a,1) == 5) % rough
            microStruct = [microStruct; all_objects(a,:)];
        end
    end
    
    norm_compliance = compliance;
    norm_compliance(:,5) = (norm_compliance(:,5) - (min(norm_compliance(:,5)))) / (max(norm_compliance(:,5))-min(norm_compliance(:,5)))*10;
    norm_compliance(:,6) = (norm_compliance(:,6) - (min(norm_compliance(:,6)))) / (max(norm_compliance(:,6))-min(norm_compliance(:,6)))*10;
    norm_compliance(:,7) = (norm_compliance(:,7) - (min(norm_compliance(:,7)))) / (max(norm_compliance(:,7))-min(norm_compliance(:,7)))*10;
    norm_compliance(:,8) = (norm_compliance(:,8) - (min(norm_compliance(:,8)))) / (max(norm_compliance(:,8))-min(norm_compliance(:,8)))*10;
    
    norm_temperature = temperature;
    norm_temperature(:,5) = (norm_temperature(:,5) - (min(norm_temperature(:,5)))) / (max(norm_temperature(:,5))-min(norm_temperature(:,5)))*10;
    norm_temperature(:,6) = (norm_temperature(:,6) - (min(norm_temperature(:,6)))) / (max(norm_temperature(:,6))-min(norm_temperature(:,6)))*10;
    norm_temperature(:,7) = (norm_temperature(:,7) - (min(norm_temperature(:,7)))) / (max(norm_temperature(:,7))-min(norm_temperature(:,7)))*10;
    norm_temperature(:,8) = (norm_temperature(:,8) - (min(norm_temperature(:,8)))) / (max(norm_temperature(:,8))-min(norm_temperature(:,8)))*10;
    
    norm_macro = macroStruct;
    norm_macro(:,5) = (norm_macro(:,5) - (min(norm_macro(:,5)))) / (max(norm_macro(:,5))-min(norm_macro(:,5)))*10;
    norm_macro(:,6) = (norm_macro(:,6) - (min(norm_macro(:,6)))) / (max(norm_macro(:,6))-min(norm_macro(:,6)))*10;
    norm_macro(:,7) = (norm_macro(:,7) - (min(norm_macro(:,7)))) / (max(norm_macro(:,7))-min(norm_macro(:,7)))*10;
    norm_macro(:,8) = (norm_macro(:,8) - (min(norm_macro(:,8)))) / (max(norm_macro(:,8))-min(norm_macro(:,8)))*10;
    
    norm_micro = microStruct;
    norm_micro(:,5) = (norm_micro(:,5) - (min(norm_micro(:,5)))) / (max(norm_micro(:,5))-min(norm_micro(:,5)))*10;
    norm_micro(:,6) = (norm_micro(:,6) - (min(norm_micro(:,6)))) / (max(norm_micro(:,6))-min(norm_micro(:,6)))*10;
    norm_micro(:,7) = (norm_micro(:,7) - (min(norm_micro(:,7)))) / (max(norm_micro(:,7))-min(norm_micro(:,7)))*10;
    norm_micro(:,8) = (norm_micro(:,8) - (min(norm_micro(:,8)))) / (max(norm_micro(:,8))-min(norm_micro(:,8)))*10;
    
    save([subject,'_norm_correct','.mat'],'norm_correct_objects','norm_compliance','norm_temperature', 'norm_macro','norm_micro');
    
    soft = norm_compliance(norm_compliance(:,1)==1 | norm_compliance(:,1)==4,5:8);
    hard = norm_compliance(norm_compliance(:,1)==2 | norm_compliance(:,1)==3 | norm_compliance(:,1)==5,5:8);
    cold = norm_temperature(norm_temperature(:,1)==2 | norm_temperature(:,1)==3,5:8);
    warm = norm_temperature(norm_temperature(:,1)==1 | norm_temperature(:,1)==4 | norm_temperature(:,1)==5,5:8);
    roundd = norm_macro(norm_macro(:,1)==1 |  norm_macro(:,1)==2 | norm_macro(:,1)==4,5:8);
    edged = norm_macro(norm_macro(:,1)==3 | norm_macro(:,1)==5,5:8);
    rough = norm_micro(norm_micro(:,1)==4 |  norm_micro(:,1)==5,5:8);
    smooth = norm_micro(norm_micro(:,1)==1 | norm_micro(:,1)==2 | norm_micro(:,1)==3,5:8); 
    
    [within_dist1, between_dist1] = calc_within_between_distances(soft,hard);
    [p,h,stats] = ranksum(within_dist1,between_dist1,'tail','left')
    
    [within_dist2, between_dist2] = calc_within_between_distances(cold,warm);
    [p,h,stats] = ranksum(within_dist2,between_dist2,'tail','left')
    
    [within_dist3, between_dist3] = calc_within_between_distances(rough,smooth); % smooth rough
    [p,h,stats] = ranksum(within_dist3,between_dist3,'tail','left')
    
    [within_dist4, between_dist4] = calc_within_between_distances(roundd,edged);
    [p,h,stats] = ranksum(within_dist4,between_dist4,'tail','left')
    
    save([subject,'_dist.mat'], 'within_dist1', 'between_dist1', 'within_dist2', 'between_dist2', 'within_dist3', 'between_dist3', 'within_dist4', 'between_dist4')
    
    figure;
    boxplot([within_dist1; between_dist1; within_dist2; between_dist2; within_dist3; between_dist3; within_dist4; between_dist4],...
            [ones(1,numel(within_dist1)) ones(1,numel(between_dist1))*2 ones(1,numel(within_dist2))*3 ones(1,numel(between_dist2))*4 ones(1,numel(within_dist3))*5 ones(1,numel(between_dist3))*6 ...
             ones(1,numel(within_dist4))*7 ones(1,numel(between_dist4))*8])
     xticklabels({'soft-hard',' ', 'cold-warm', ' ', 'slippery-sticky/smooth-rough', ' ', 'round-edged', ' '})
     xtickangle(45)
     
    mn_correct = {};
    mn_correct.cat = median(correct_objects(correct_objects(:,1)==1,5:8));
    mn_correct.apple = median(correct_objects(correct_objects(:,1)==2,5:8));
    mn_correct.key = median(correct_objects(correct_objects(:,1)==3,5:8));
    mn_correct.towel = median(correct_objects(correct_objects(:,1)==4,5:8));
    mn_correct.toast = median(correct_objects(correct_objects(:,1)==5,5:8));
    
    % % % 
    satis_correct = [];
    data = correct_objects;
    for d=1:size(data,1)
        if data(d,1) == 1
            satis_correct = [satis_correct; data(d,10) pdist([data(d,5:8); mn_correct.cat]) mean([pdist([data(d,5:8); mn_correct.apple]) pdist([data(d,5:8); mn_correct.key]) pdist([data(d,5:8); mn_correct.towel]) pdist([data(d,5:8); mn_correct.toast])]) 1];
        elseif data(d,1) == 2
            satis_correct = [satis_correct; data(d,10) pdist([data(d,5:8); mn_correct.apple]) mean([pdist([data(d,5:8); mn_correct.cat]) pdist([data(d,5:8); mn_correct.key]) pdist([data(d,5:8); mn_correct.towel]) pdist([data(d,5:8); mn_correct.toast])]) 2];
        elseif data(d,1) == 3
            satis_correct = [satis_correct; data(d,10) pdist([data(d,5:8); mn_correct.key]) mean([pdist([data(d,5:8); mn_correct.cat]) pdist([data(d,5:8); mn_correct.apple]) pdist([data(d,5:8); mn_correct.towel]) pdist([data(d,5:8); mn_correct.toast])]) 3];
        elseif data(d,1) == 4
            satis_correct = [satis_correct; data(d,10) pdist([data(d,5:8); mn_correct.towel]) mean([pdist([data(d,5:8); mn_correct.cat]) pdist([data(d,5:8); mn_correct.apple]) pdist([data(d,5:8); mn_correct.key]) pdist([data(d,5:8); mn_correct.toast])]) 4];
        else
            satis_correct = [satis_correct; data(d,10) pdist([data(d,5:8); mn_correct.toast]) mean([pdist([data(d,5:8); mn_correct.cat]) pdist([data(d,5:8); mn_correct.apple]) pdist([data(d,5:8); mn_correct.key]) pdist([data(d,5:8); mn_correct.towel])]) 5];
        end
    end

    satis_incorrect = [];
    data = incorrect_objects;
    for d=1:size(data,1)
        
        if data(d,1) == 1 % according to choice
            satis_incorrect = [satis_incorrect; data(d,10) pdist([data(d,5:8); mn_correct.cat]) mean([pdist([data(d,5:8); mn_correct.apple]) pdist([data(d,5:8); mn_correct.key]) pdist([data(d,5:8); mn_correct.towel]) pdist([data(d,5:8); mn_correct.toast])]) 1];
        elseif data(d,1) == 2
            satis_incorrect = [satis_incorrect; data(d,10) pdist([data(d,5:8); mn_correct.apple]) mean([pdist([data(d,5:8); mn_correct.cat]) pdist([data(d,5:8); mn_correct.key]) pdist([data(d,5:8); mn_correct.towel]) pdist([data(d,5:8); mn_correct.toast])]) 2];
        elseif data(d,1) == 3
            satis_incorrect = [satis_incorrect; data(d,10) pdist([data(d,5:8); mn_correct.key]) mean([pdist([data(d,5:8); mn_correct.cat]) pdist([data(d,5:8); mn_correct.apple]) pdist([data(d,5:8); mn_correct.towel]) pdist([data(d,5:8); mn_correct.toast])]) 3];
        elseif data(d,1) == 4
            satis_incorrect = [satis_incorrect; data(d,10) pdist([data(d,5:8); mn_correct.towel]) mean([pdist([data(d,5:8); mn_correct.cat]) pdist([data(d,5:8); mn_correct.apple]) pdist([data(d,5:8); mn_correct.key]) pdist([data(d,5:8); mn_correct.toast])]) 4];
        else
            satis_incorrect = [satis_incorrect; data(d,10) pdist([data(d,5:8); mn_correct.toast]) mean([pdist([data(d,5:8); mn_correct.cat]) pdist([data(d,5:8); mn_correct.apple]) pdist([data(d,5:8); mn_correct.key]) pdist([data(d,5:8); mn_correct.towel])]) 5];
        end
    end
    
    cat_apple = distance_objects_all(correct_objects(correct_objects(:,1)==1,5:8),correct_objects(correct_objects(:,1)==2,5:8));
    cat_key = distance_objects_all(correct_objects(correct_objects(:,1)==1,5:8),correct_objects(correct_objects(:,1)==3,5:8));
    cat_towel = distance_objects_all(correct_objects(correct_objects(:,1)==1,5:8),correct_objects(correct_objects(:,1)==4,5:8));
    cat_toast = distance_objects(correct_objects(correct_objects(:,1)==1,5:8),correct_objects(correct_objects(:,1)==5,5:8));
    apple_key = distance_objects_all(correct_objects(correct_objects(:,1)==2,5:8),correct_objects(correct_objects(:,1)==3,5:8));
    apple_towel = distance_objects_all(correct_objects(correct_objects(:,1)==2,5:8),correct_objects(correct_objects(:,1)==4,5:8));
    apple_toast = distance_objects_all(correct_objects(correct_objects(:,1)==2,5:8),correct_objects(correct_objects(:,1)==5,5:8));
    key_towel = distance_objects_all(correct_objects(correct_objects(:,1)==3,5:8),correct_objects(correct_objects(:,1)==4,5:8));
    key_toast = distance_objects_all(correct_objects(correct_objects(:,1)==3,5:8),correct_objects(correct_objects(:,1)==5,5:8));
    towel_toast = distance_objects_all(correct_objects(correct_objects(:,1)==4,5:8),correct_objects(correct_objects(:,1)==5,5:8));
    
    cat = distance_self_all(correct_objects(correct_objects(:,1)==1,5:8));
    apple = distance_self_all(correct_objects(correct_objects(:,1)==2,5:8));
    key = distance_self_all(correct_objects(correct_objects(:,1)==3,5:8));
    towel = distance_self_all(correct_objects(correct_objects(:,1)==4,5:8));
    toast = distance_self_all(correct_objects(correct_objects(:,1)==5,5:8));
    
    labels = {'cat-towel','towel-toast','apple-key','cat-toast','cat-apple','key-toast','apple-towel','apple-toast','key-towel','cat-key'};
    distance = [mean(cat_towel) mean(towel_toast) mean(apple_key) mean(cat_toast) mean(cat_apple) mean(key_toast) mean(apple_towel) mean(apple_toast) mean(key_towel) mean(cat_key)];
    save([subject,'_parameter_distance.mat'],'distance','labels');
    
    figure;
    boxplot([satis_correct(:,2)' satis_incorrect(:,2)'],[ones(1,numel(satis_correct(:,2))) ones(1,numel(satis_incorrect(:,2)))*2]);
    xticklabels({'correct','incorrect'});
    ylabel('Euclidean distance')
    ylim([0 10]);
    set(gca,'FontSize',15)
    
    figure;
    boxplot([cat apple key towel toast cat_apple cat_key cat_towel cat_toast apple_key apple_towel apple_toast key_towel key_toast towel_toast],...
            [ones(1,numel([cat apple key towel toast])) ones(1,numel([cat_apple cat_key cat_towel cat_toast apple_key apple_towel apple_toast key_towel key_toast towel_toast]))*2]);
    ylim([0 13])
    ylabel('Euclidean distance')
    xticks([1,2])
    xticklabels({'same','different'})
    set(gca,'FontSize',15)
       
end