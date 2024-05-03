function classify_on_stim_parameters(data_folder,subject)
    load(fullfile(data_folder, [subject,'_all_data.mat']))

    % separate into objects
    data1 = data(find(data(:,2)==1),:); % cat
    data2 = data(find(data(:,2)==2),:); % apple
    data3 = data(find(data(:,2)==3),:); % key
    data4 = data(find(data(:,2)==4),:); % towel
    data5 = data(find(data(:,2)==5),:); % toast

    % normalize total charge (total_charge/train_length)
    data1(:,10:12) = data1(:,10:12)./data1(:,13:15);
    data2(:,10:12) = data2(:,10:12)./data2(:,13:15);
    data3(:,10:12) = data3(:,10:12)./data3(:,13:15);
    data4(:,10:12) = data4(:,10:12)./data4(:,13:15);
    data5(:,10:12) = data5(:,10:12)./data5(:,13:15);

    s_data = [];
    idx = [6,7,8,9]; % final parameters
    s_data.cat = data1(:,idx); 
    s_data.apple = data2(:,idx);
    s_data.key = data3(:,idx);
    s_data.towel = data4(:,idx);
    s_data.toast = data5(:,idx);

    all_data = [s_data.cat; s_data.apple; s_data.key; s_data.towel; s_data.toast];
    all_labels = [ones(size(s_data.cat,1),1); ones(size(s_data.apple,1),1)*2; ones(size(s_data.key,1),1)*3; ones(size(s_data.towel,1),1)*4; ones(size(s_data.toast,1),1)*5];

    % run LDA and plot confusion matrix
    [perf, decoded_label] = run_LDA_with_matched_class_size(all_data, all_labels,{'cat','apple','key','towel','toast'});

    % all decoded labels
    dlab = decoded_label(:,[5,6]);

    % get LDA object confusions
    appleKey   = (sum(dlab(dlab(:,1)==2,2)==3) + sum(dlab(dlab(:,1)==3,2)==2)) / (sum(dlab(dlab(:,1)==2,2)~=2) + sum(dlab(dlab(:,1)==3,2)~=3));
    catTowel   = (sum(dlab(dlab(:,1)==1,2)==4) + sum(dlab(dlab(:,1)==4,2)==1)) / (sum(dlab(dlab(:,1)==1,2)~=1) + sum(dlab(dlab(:,1)==4,2)~=4));
    towelToast = (sum(dlab(dlab(:,1)==4,2)==5) + sum(dlab(dlab(:,1)==5,2)==4)) / (sum(dlab(dlab(:,1)==4,2)~=4) + sum(dlab(dlab(:,1)==5,2)~=5));
    catApple   = (sum(dlab(dlab(:,1)==1,2)==2) + sum(dlab(dlab(:,1)==2,2)==1)) / (sum(dlab(dlab(:,1)==1,2)~=1) + sum(dlab(dlab(:,1)==2,2)~=2));
    catKey     = (sum(dlab(dlab(:,1)==1,2)==3) + sum(dlab(dlab(:,1)==3,2)==1)) / (sum(dlab(dlab(:,1)==1,2)~=1) + sum(dlab(dlab(:,1)==3,2)~=3));
    keyToast   = (sum(dlab(dlab(:,1)==3,2)==5) + sum(dlab(dlab(:,1)==5,2)==3)) / (sum(dlab(dlab(:,1)==3,2)~=3) + sum(dlab(dlab(:,1)==5,2)~=5));
    catToast   = (sum(dlab(dlab(:,1)==1,2)==5) + sum(dlab(dlab(:,1)==5,2)==1)) / (sum(dlab(dlab(:,1)==1,2)~=1) + sum(dlab(dlab(:,1)==5,2)~=5));
    appleTowel = (sum(dlab(dlab(:,1)==2,2)==4) + sum(dlab(dlab(:,1)==4,2)==2)) / (sum(dlab(dlab(:,1)==2,2)~=2) + sum(dlab(dlab(:,1)==4,2)~=4));
    appleToast = (sum(dlab(dlab(:,1)==2,2)==5) + sum(dlab(dlab(:,1)==5,2)==2)) / (sum(dlab(dlab(:,1)==2,2)~=2) + sum(dlab(dlab(:,1)==5,2)~=5));
    keyTowel   = (sum(dlab(dlab(:,1)==3,2)==4) + sum(dlab(dlab(:,1)==4,2)==3)) / (sum(dlab(dlab(:,1)==3,2)~=3) + sum(dlab(dlab(:,1)==4,2)~=4));

    confusion = [towelToast, appleKey catTowel keyTowel catApple keyToast catToast catKey appleTowel appleToast];

    cd(fullfile(data_folder,subject));
    save('lda_data.mat','perf','decoded_label','confusion')
end
