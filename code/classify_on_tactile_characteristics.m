function classify_on_tactile_characteristics(data_folder, subject)
    load(fullfile(data_folder, [subject,'_all_data.mat']))

    cat = data(find(data(:,2)==1),:);
    apple = data(find(data(:,2)==2),:);
    key= data(find(data(:,2)==3),:);
    towel = data(find(data(:,2)==4),:);
    toast = data(find(data(:,2)==5),:);

    % classify based on compliance
    s_data = [];
    s_data.soft = [cat(:,[6:9]); towel(:,[6:9])];
    s_data.hard = [apple(:,[6:9]); key(:,[6:9]); toast(:,[6:9]);]; 

    all_data = [s_data.soft; s_data.hard];
    all_labels = [ones(size(s_data.soft,1),1); ones(size(s_data.hard,1),1)*2];

    class_labels_compl = [ones(size(cat,1),1)*1; ones(size(towel,1),1)*4; ones(size(apple,1),1)*2; ones(size(key,1),1)*3; ones(size(toast,1),1)*5;];

    [perf, compl_labels] = run_LDA_with_matched_class_size(all_data, all_labels, {'soft', 'hard'});
    cat_comp = compl_labels(class_labels_compl(:,1)==1,end);
    apple_comp = compl_labels(class_labels_compl(:,1)==2,end);
    key_comp = compl_labels(class_labels_compl(:,1)==3,end);
    towel_comp = compl_labels(class_labels_compl(:,1)==4,end);
    toast_comp = compl_labels(class_labels_compl(:,1)==5,end);

    cat_sum = [sum(cat_comp==1)/numel(cat_comp), sum(cat_comp==2)/numel(cat_comp), sum(cat_comp==3)/numel(cat_comp)];
    apple_sum = [sum(apple_comp==1)/numel(apple_comp),sum(apple_comp==2)/numel(apple_comp),sum(apple_comp==3)/numel(apple_comp)];
    key_sum = [sum(key_comp==1)/numel(key_comp),sum(key_comp==2)/numel(key_comp),sum(key_comp==3)/numel(key_comp)];
    towel_sum = [sum(towel_comp==1)/numel(towel_comp),sum(towel_comp==2)/numel(towel_comp),sum(towel_comp==3)/numel(towel_comp)];
    toast_sum = [sum(toast_comp==1)/numel(toast_comp),sum(toast_comp==2)/numel(toast_comp),sum(toast_comp==3)/numel(toast_comp)];

    % classify based on temperature
    s_data = [];
    s_data.cold = [apple(:,[6:9]); key(:,[6:9])]; 
    s_data.warm = [cat(:,[6:9]); towel(:,[6:9]); toast(:,[6:9])]; 

    all_data = [s_data.cold; s_data.warm];
    all_labels = [ones(size(s_data.cold,1),1);  ones(size(s_data.warm,1),1)*2];

    class_labels_temp = [ones(size(apple,1),1)*2; ones(size(key,1),1)*3; ones(size(cat,1),1)*1; ones(size(towel,1),1)*4; ones(size(toast,1),1)*5];

    [perf, temp_labels] = run_LDA_with_matched_class_size(all_data, all_labels, {'cold', 'warm'});
    cat_temp = temp_labels(class_labels_temp(:,1)==1,end);
    apple_temp = temp_labels(class_labels_temp(:,1)==2,end);
    key_temp = temp_labels(class_labels_temp(:,1)==3,end);
    towel_temp = temp_labels(class_labels_temp(:,1)==4,end);
    toast_temp = temp_labels(class_labels_temp(:,1)==5,end);

    cat_sum = [sum(cat_temp==1)/numel(cat_temp), sum(cat_temp==2)/numel(cat_temp), sum(cat_temp==3)/numel(cat_temp)];
    apple_sum = [sum(apple_temp==1)/numel(apple_temp),sum(apple_temp==2)/numel(apple_temp),sum(apple_temp==3)/numel(apple_temp)];
    key_sum = [sum(key_temp==1)/numel(key_temp),sum(key_temp==2)/numel(key_temp),sum(key_temp==3)/numel(key_temp)];
    towel_sum = [sum(towel_temp==1)/numel(towel_temp),sum(towel_temp==2)/numel(towel_temp),sum(towel_temp==3)/numel(towel_temp)];
    toast_sum = [sum(toast_temp==1)/numel(toast_temp),sum(toast_temp==2)/numel(toast_temp),sum(toast_temp==3)/numel(toast_temp)];

    % classify based on friction
    s_data = [];
    s_data.slippery = [cat(:,[6:9]); key(:,[6:9])]; 
    s_data.sticky = [apple(:,[6:9]); towel(:,[6:9]); toast(:,[6:9])];

    all_data = [s_data.slippery;s_data.sticky];
    all_labels = [ones(size(s_data.slippery,1),1); ones(size(s_data.sticky,1),1)*2]

    class_labels_frict = [ones(size(cat,1),1)*1; ones(size(key,1),1)*3; ones(size(apple,1),1)*2; ones(size(towel,1),1)*4; ones(size(toast,1),1)*5];

    [perf, frict_labels] = run_LDA_with_matched_class_size(all_data, all_labels, {'slippery', 'sticky'});
    cat_frict = frict_labels(class_labels_frict(:,1)==1,end);
    apple_frict = frict_labels(class_labels_frict(:,1)==2,end);
    key_frict = frict_labels(class_labels_frict(:,1)==3,end);
    towel_frict = frict_labels(class_labels_frict(:,1)==4,end);
    toast_frict = frict_labels(class_labels_frict(:,1)==5,end); 

    cat_sum = [sum(cat_frict==1)/numel(cat_frict), sum(cat_frict==2)/numel(cat_frict), sum(cat_frict==3)/numel(cat_frict)];
    apple_sum = [sum(apple_frict==1)/numel(apple_frict),sum(apple_frict==2)/numel(apple_frict),sum(apple_frict==3)/numel(apple_frict)];
    key_sum = [sum(key_frict==1)/numel(key_frict),sum(key_frict==2)/numel(key_frict),sum(key_frict==3)/numel(key_frict)];
    towel_sum = [sum(towel_frict==1)/numel(towel_frict),sum(towel_frict==2)/numel(towel_frict),sum(towel_frict==3)/numel(towel_frict)];
    toast_sum = [sum(toast_frict==1)/numel(toast_frict),sum(toast_frict==2)/numel(toast_frict),sum(toast_frict==3)/numel(toast_frict)];

    % classify based on macro struct
    s_data = [];
    s_data.round = [cat(:,[6:9]); apple(:,[6:9]); towel(:,[6:9])]; 
    s_data.edged = [toast(:,[6:9]); key(:,[6:9])];

    all_data = [s_data.round; s_data.edged];
    all_labels = [ones(size(s_data.round,1),1); ones(size(s_data.edged,1),1)*2];

    class_labels = [ones(size(cat,1),1)*1; ones(size(apple,1),1)*2; ones(size(towel,1),1)*4; ones(size(toast,1),1)*5; ones(size(key,1),1)*3];

    [perf, macro_labels] = run_LDA_with_matched_class_size(all_data, all_labels, {'round', 'edged'});
    cat_macro = macro_labels(class_labels(:,1)==1,end);
    apple_macro = macro_labels(class_labels(:,1)==2,end);
    key_macro = macro_labels(class_labels(:,1)==3,end);
    towel_macro = macro_labels(class_labels(:,1)==4,end);
    toast_macro = macro_labels(class_labels(:,1)==5,end); 

    % % classify based on micro struct
    s_data = [];
    s_data.smooth = [cat(:,[6:9]); apple(:,[6:9]);key(:,[6:9])]; 
    s_data.rough = [towel(:,[6:9]); toast(:,[6:9])];

    all_data = [s_data.smooth; s_data.rough];
    all_labels = [ones(size(s_data.smooth,1),1); ones(size(s_data.rough,1),1)*2];

    class_labels = [ones(size(cat,1),1)*1; ones(size(apple,1),1)*2; ones(size(key,1),1)*3; ones(size(towel,1),1)*4; ones(size(toast,1),1)*5];

    [perf, micro_labels] = run_LDA_with_matched_class_size(all_data, all_labels, {'smooth', 'rough'});
    cat_micro = micro_labels(class_labels(:,1)==1,end);
    apple_micro = micro_labels(class_labels(:,1)==2,end);
    key_micro = micro_labels(class_labels(:,1)==3,end);
    towel_micro = micro_labels(class_labels(:,1)==4,end);
    toast_micro = micro_labels(class_labels(:,1)==5,end); 

    % plot characteristics based on individual classifiers
    perc_class1 = [(sum(cat_comp==1)/numel(cat_comp)) (sum(apple_comp==1)/numel(apple_comp)) (sum(key_comp==1)/numel(key_comp)) (sum(towel_comp==1)/numel(towel_comp)) (sum(toast_comp==1)/numel(toast_comp));...
    (sum(cat_temp==1)/numel(cat_temp)) (sum(apple_temp==1)/numel(apple_temp)) (sum(key_temp==1)/numel(key_temp)) (sum(towel_temp==1)/numel(towel_temp)) (sum(toast_temp==1)/numel(toast_temp));...
    (sum(cat_frict==1)/numel(cat_frict)) (sum(apple_frict==1)/numel(apple_frict)) (sum(key_frict==1)/numel(key_frict)) (sum(towel_frict==1)/numel(towel_frict)) (sum(toast_frict==1)/numel(toast_frict));...
    (sum(cat_macro==1)/numel(cat_macro)) (sum(apple_macro==1)/numel(apple_macro)) (sum(key_macro==1)/numel(key_macro)) (sum(towel_macro==1)/numel(towel_macro)) (sum(toast_macro==1)/numel(toast_macro));...
    (sum(cat_micro==1)/numel(cat_micro)) (sum(apple_micro==1)/numel(apple_micro)) (sum(key_micro==1)/numel(key_micro)) (sum(towel_micro==1)/numel(towel_micro)) (sum(toast_micro==1)/numel(toast_micro))];

    perc_class2 = 1-perc_class1;

    perc_class = zeros(size(perc_class1));
    for i=1:size(perc_class,1)
        for j=1:size(perc_class,2)
            if perc_class1(i,j)>perc_class2(i,j)
                perc_class(i,j) = perc_class1(i,j)*-100;
            else
                perc_class(i,j) = perc_class2(i,j)*100;
            end
        end
    end

    question_left = {'soft','cold','slippery','round','smooth','unpleasant','unfamiliar'};
    question_right = {'hard','warm','sticky','edged','rough','pleasant','familiar'};

    f = figure;
    a1 = axes;
    plot(perc_class2,'o-');
    hold on;
    plot([0 6], [0.5 0.5],'--k');
    ylim([0 1]);
    xlim([0 6]);
    xticks([0 1 2 3 4 5])
    xticklabels([' ', question_left])
    set(gca,'FontSize',15)
    xt = get(a1,'XTick');
    a2 = copyobj(a1,f);
    a2.XTickLabel = ([' ', question_right])
    set(a2,'Color','none')
    set(a2,'Ytick',[])
    set(a2,'XAxisLocation','top')
    legend('cat','apple','key','towel','toast');
    ylabel('classifier label (%)')
    set(gca,'FontSize',15)
end