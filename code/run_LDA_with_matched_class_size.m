% classify data with LDA
function [perf, most_used_label] = run_LDA_with_matched_class_size(all_objects_orig, all_labels_orig, word_labels)

perf = [];

% check class sizes
nr_classes = numel(unique(all_labels_orig));
sizes = [];
for i=1:nr_classes
    sizes = [sizes sum(all_labels_orig == i)];
end
max_size = max(sizes);
min_size = min(sizes);

all_true_labels = [];
all_assigned_labels=[];
classified_data = [];
for r=1:100 %repeat all 100 times to get stable result
    
    % match class sizes
    all_data = [];
    all_labels = [];
    all_class_samples = [];
    for c=1:nr_classes
        if sum(all_labels_orig==c) < max_size
            c_data = all_objects_orig(all_labels_orig==c,:);
            diff = max_size - size(c_data,1);
            random_supplement_idx = randsample(size(c_data,1),diff, true); % sample with replacement
            class_samples = [ones(size(c_data,1),1)*c; ones(numel(random_supplement_idx),1)*-1];
            class_data = [c_data; c_data(random_supplement_idx,:)]; % make this class as big as biggest class
            all_data = [all_data; class_data];
            class_label = ones(size(class_data,1),1)*c;
            all_labels = [all_labels; class_label];
            all_class_samples = [all_class_samples; class_samples];
        else
            c_data = all_objects_orig(all_labels_orig==c,:);
            class_label = ones(size(c_data,1),1)*c;
            class_samples = class_label;
            all_data = [all_data; c_data];
            all_labels = [all_labels; class_label];
            all_class_samples = [all_class_samples; class_samples];
        end
    end
    
    classified_data(r,:,:) = zeros(size(all_data,1),size(all_data,2)+2);

    all_data = [all_data all_labels];
    r_idx = randperm(size(all_data,1));
    all_data = all_data(r_idx,:); % shuffle data
    all_objects = all_data(:,1:size(all_data,2)-1); 
    all_labels = all_data(:,size(all_data,2)); 

    partitions = round(linspace(1,size(all_objects,1),11));

    nr_correct = [];
    for p=1:numel(partitions)-1
        nr_correct(p) = 0;

        if p==numel(partitions)-1 % last partition
            idx = [partitions(p):partitions(p+1)];
        else
            idx = [partitions(p):partitions(p+1)-1];
        end

        dataTrain = all_objects;
        dataTrain(idx,:) = [];
        labelsTrain = all_labels;
        labelsTrain(idx,:) = [];
        dataTest  = all_objects(idx,:);
        labelsTest = all_labels(idx,:);
        
        % LDA
        MdlLinear = fitcdiscr(dataTrain, labelsTrain);
        assigned_label = predict(MdlLinear,dataTest);
        
        classified_data(r,r_idx(idx),:) = [dataTest labelsTest assigned_label];

        for l=1:numel(assigned_label)
            if assigned_label(l) == labelsTest(l)
                nr_correct(p) = nr_correct(p)+1;
            else
                all_true_labels = [all_true_labels; labelsTest];
                all_assigned_labels = [all_assigned_labels; assigned_label];
            end
        end
        nr_correct(p) = nr_correct(p)/numel(labelsTest)*100;

    end
    perf(r) = mean(nr_correct);
    stdf(r) = std(nr_correct);
end
classified_data(:,all_class_samples==-1,:) = [];  % delete all repeated objects that were used to match class sizes, so keep original objects only

% count most frequently assigned label
most_used_label = zeros(size(classified_data,2),6);
for r=1:size(classified_data,2)
    most_used_label(r,:) = [squeeze(classified_data(end,r,1:5))' mode(classified_data(:,r,end))];
end

actual_perf = mean(perf)
mean(stdf)

% create confusion matrix
all_classes = unique(all_labels_orig);
confusion_matrix = zeros(numel(all_classes),numel(all_classes));
class_nr = zeros(1,numel(all_classes));
for c=1:numel(all_classes)
    current_class_idx = find(all_true_labels == all_classes(c));
    class_nr(c) = numel(current_class_idx);
    current_class_predictions = all_assigned_labels(current_class_idx);
    for p=1:numel(all_classes)
        confusion_matrix(c,p) = sum(current_class_predictions==all_classes(p));
    end
end
confusion_matrix = (confusion_matrix./class_nr')*100;

c_matrix = round(confusion_matrix)
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
xticklabels(word_labels)
yticklabels(word_labels)
ylabel('true class')
xlabel('predicted class')
colormap(cmap)
colorbar
title('LDA')
set(gca,'FontSize',14)

save('confusion_matrix_LDA.mat','c_matrix')

% do 1000 permutations
% permutation test to assess significance level
for perm=1:1000  

    % shuffle original data labels
    r_idx = randperm(size(all_labels_orig,1));
    all_shuffled_labels = all_labels_orig(r_idx); 
    
    % match class sizes
    all_data = [];
    all_labels = [];
    all_class_samples = [];
    for c=1:nr_classes
        if sum(all_shuffled_labels==c) < max_size
            c_data = all_objects_orig(all_shuffled_labels==c,:);
            diff = max_size - size(c_data,1);
            random_supplement_idx = randsample(size(c_data,1),diff, true); % sample with replacement
            class_samples = [ones(size(c_data,1),1)*c; ones(numel(random_supplement_idx),1)*-1];
            class_data = [c_data; c_data(random_supplement_idx,:)]; % make this class as big as biggest class
            all_data = [all_data; class_data];
            class_label = ones(size(class_data,1),1)*c;
            all_labels = [all_labels; class_label];
            all_class_samples = [all_class_samples; class_samples];
        else
            c_data = all_objects_orig(all_shuffled_labels==c,:);
            class_label = ones(size(c_data,1),1)*c;
            class_samples = class_label;
            all_data = [all_data; c_data];
            all_labels = [all_labels; class_label];
            all_class_samples = [all_class_samples; class_samples];
        end
    end
    
    % shuffle data
    all_data = [all_data all_labels];
    r_idx = randperm(size(all_data,1));
    all_data = all_data(r_idx,:);
    all_objects = all_data(:,1:size(all_data,2)-1); 
    all_labels = all_data(:,size(all_data,2)); 

    partitions = round(linspace(1,size(all_objects,1),11));

    all_true_labels = [];
    all_assigned_labels=[];
    nr_correct = []; 
    for p=1:numel(partitions)-1
        nr_correct(p) = 0;

        if p==numel(partitions)-1 % last partition
            idx = [partitions(p):partitions(p+1)];
        else
            idx = [partitions(p):partitions(p+1)-1];
        end

        dataTrain = all_objects;
        dataTrain(idx,:) = [];
        labelsTrain = all_labels;
        labelsTrain(idx,:) = [];
        dataTest  = all_objects(idx,:);
        labelsTest = all_labels(idx,:);

        % LDA
        MdlLinear = fitcdiscr(dataTrain, labelsTrain);
        assigned_label = predict(MdlLinear,dataTest);

        for l=1:numel(assigned_label)
            if assigned_label(l) == labelsTest(l)
                nr_correct(p) = nr_correct(p)+1;
            else
                all_true_labels = [all_true_labels; labelsTest];
                all_assigned_labels = [all_assigned_labels; assigned_label];
            end
        end
        nr_correct(p) = nr_correct(p)/numel(labelsTest)*100;
    end
    perm_perf(perm) = mean(nr_correct);
end

h = hist(perm_perf);

figure;
hist(perm_perf);
sorted_perf = sort(perm_perf);
sign_perf = sorted_perf(round(0.95*numel(sorted_perf)))
p_value = (sum(sorted_perf > actual_perf)/numel(sorted_perf))
hold on;
plot([actual_perf actual_perf],[0 max(h)],'r:','LineWidth',3)
plot([sign_perf sign_perf],[0 max(h)],'k:','LineWidth',3)
legend('bootstrap distr','test observation','95% significance')
xlabel('LDA performance(%)')
ylabel('nr observations')
set(gca,'FontSize',15)


