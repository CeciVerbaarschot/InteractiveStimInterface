function plot_within_session_replay_performance(data_folder, subject)

    % read in data
    load(fullfile(data_folder, subject,'replay_data.mat'))

    % separate into objects
    data1 = data(find(data(:,1)==1),:);
    data2 = data(find(data(:,1)==2),:);
    data3 = data(find(data(:,1)==3),:);
    data4 = data(find(data(:,1)==4),:);
    data5 = data(find(data(:,1)==5),:);

    figure;
    vdata = {};
    vdata.incorrect = data(data(:,4)==0,3);
    vdata.correct = data(data(:,4)==1,3);
    violinplot(vdata)
    ylim([0 100])
    ylabel('certainty(%)')
    set(gca,'FontSize',15)

    % replay performance per session
    perf_per_session = [];
    p = 1;
    classes = unique(data(:,1));
    nr_classes = numel(classes);
    for s=min(data(:,9)):max(data(:,9))
        if numel(find(data(:,9)==s))>0
            sdata = data(find(data(:,9)==s),:);
            perf_per_session(p) = sum(sdata(:,4))/size(sdata,1)*100;
            p = p+1;
        end
    end

    % do 1000 permutations
    % permutation test to assess significance level
    actual_perf = sum(data(:,2)==data(:,1))/size(data,1)*100 % participant performance across whole dataset
    for perm=1:1000  
        all_data = [];
        for c=1:nr_classes
            c_data = classes(randsample(size(classes),sum(data(:,1)==classes(c)),true),1); % sample without replacement
            all_data = [all_data; c_data];
        end
        perm_perf(perm) = sum(all_data==data(:,1))/size(data,1)*100;
    end
    permuted_perf = mean(perm_perf); % statistical chance level
    sorted_perf = sort(perm_perf);
    sign_perf = sorted_perf(round(0.95*numel(sorted_perf))) % statistical significance level
    p_value = (sum(sorted_perf > actual_perf)/numel(sorted_perf))
    save([subject,'_replay_perf.mat'],'perf_per_session');

    % performance
    perf = mean(perf_per_session)
    perf_across = sum(data(:,4))/size(data,1)*100

    % confusion matrix
    idx = find(data(:,1) == 1);
    cat = hist(data(idx,2),[1:5]);
    cat = cat/sum(cat)*100;
    idx = find(data(:,1) == 2);
    apple = hist(data(idx,2),[1:5]);
    apple = apple/sum(apple)*100;
    idx = find(data(:,1) == 3);
    key = hist(data(idx,2),[1:5]);
    key = key/sum(key)*100;
    idx = find(data(:,1) == 4);
    towel = hist(data(idx,2),[1:5]);
    towel = towel/sum(towel)*100;
    idx = find(data(:,1) == 5);
    toast = hist(data(idx,2),[1:5]);
    toast = toast/sum(toast)*100;
    c_matrix = round([cat; apple; key; towel; toast]);
    figure;
    clims = [0 100];
    imagesc(c_matrix,clims)
    blue = [0, 0, 1];
    white = [1, 1, 1];
    length = 100;
    cmap = [linspace(white(1),blue(1),length)', linspace(white(2),blue(2),length)', linspace(white(3),blue(3),length)'];
    hold on;
    t = {};
    x = [];
    y = [];
    for r=1:size(c_matrix,1)
        for c=1:size(c_matrix,2)
            t{c,r} = num2str(c_matrix(r,c));
            x(c,r) = c;
            y(c,r) = r;
        end
    end
    text(x(:), y(:), t, 'HorizontalAlignment', 'Center')
    xticks([1:5])
    yticks([1:5])
    xticklabels({'cat','apple','key','towel','toast'})
    yticklabels({'cat','apple','key','towel','toast'})
    ylabel('true class')
    xlabel('predicted class')
    colormap(cmap)
    colorbar
    title([subject,' (within)'])
    set(gca,'FontSize',14)
end