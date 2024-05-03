function plot_charge(data_folder, subject)
    load(fullfile(data_folder, subject,'replay_data.mat'))

    % separate into objects
    data1 = data(find(data(:,1)==1),:);
    data2 = data(find(data(:,1)==2),:);
    data3 = data(find(data(:,1)==3),:);
    data4 = data(find(data(:,1)==4),:);
    data5 = data(find(data(:,1)==5),:);

    % normalize total charge
    data1(:,11:13) = data1(:,11:13)./data1(:,14:16);
    data2(:,11:13) = data2(:,11:13)./data2(:,14:16);
    data3(:,11:13) = data3(:,11:13)./data3(:,14:16);
    data4(:,11:13) = data4(:,11:13)./data4(:,14:16);
    data5(:,11:13) = data5(:,11:13)./data5(:,14:16);

    % plot total charge during replay
    figure;
    vdata = {};
    vdata.cat = mean(data1(:,11:13),2);
    vdata.apple = mean(data2(:,11:13),2);
    vdata.key = mean(data3(:,11:13),2);
    vdata.towel = mean(data4(:,11:13),2);
    vdata.toast = mean(data5(:,11:13),2);
    violinplot(vdata)
    ylim([0 3]);
    ylabel('charge')
    set(gca,'FontSize',15)
end

