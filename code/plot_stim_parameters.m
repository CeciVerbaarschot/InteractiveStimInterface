function plot_stim_parameters(data_folder, subject)
    load(fullfile(data_folder, [subject,'_all_data.mat']))

    % plot parameters
    figure;
    subplot(2,2,1)
    amplitude = {};
    amplitude.cat = data(data(:,2)==1,6);
    amplitude.apple = data(data(:,2)==2,6);
    amplitude.key = data(data(:,2)==3,6);
    amplitude.towel = data(data(:,2)==4,6);
    amplitude.toast = data(data(:,2)==5,6);
    violinplot(amplitude);
    ylabel('amplitude (level)')
    set(gca,'FontSize',15) 
    ylim([0 10])
    subplot(2,2,2)
    freq = {};
    freq.cat = data(data(:,2)==1,7);
    freq.apple = data(data(:,2)==2,7);
    freq.key = data(data(:,2)==3,7);
    freq.towel = data(data(:,2)==4,7);
    freq.toast = data(data(:,2)==5,7);
    violinplot(freq);
    ylabel('frequency (level)')
    set(gca,'FontSize',15)
    ylim([0 10])
    subplot(2,2,3)
    bio = {};
    bio.cat = data(data(:,2)==1,8);
    bio.apple = data(data(:,2)==2,8);
    bio.key = data(data(:,2)==3,8);
    bio.towel = data(data(:,2)==4,8);
    bio.toast = data(data(:,2)==5,8);
    violinplot(bio);
    ylabel('biomimetic factor (level)')
    set(gca,'FontSize',15)
    ylim([0 10])
    subplot(2,2,4)
    drag = {};
    drag.cat = data(data(:,2)==1,9);
    drag.apple = data(data(:,2)==2,9);
    drag.key = data(data(:,2)==3,9);
    drag.towel = data(data(:,2)==4,9);
    drag.toast = data(data(:,2)==5,9);
    violinplot(drag);
    ylabel('drag (level)')
    set(gca,'FontSize',15)
    ylim([0 10])
    save([subject,'_parameters.mat'],'amplitude','freq','bio','drag');
end