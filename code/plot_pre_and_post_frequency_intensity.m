function plot_pre_and_post_frequency_intensity(data_folder, subject)

    if strcmp(subject,'P2')
        channels = [49, 58, 17];
        session = [7 8 9 10 11 12 15 16 17 19 20 21 22 23 24 27 28 29, 30, 31, 32, 33]; 
        stim_set = {{1},{1},{1, 3},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},{1},...     
                    {1},{1},{1},{1},{1},{1},{1}};
        block = {{2},{2, 6},{2},{2, 7},{2, 8},{2, 8},{2, 7},{2, 7},{2, 7},{2, 7},...          
                 {2, 7},{2, 7},{2, 7},{2, 7},{2, 7},{2, 7},{2, 7},{2, 6},{2, 6},...       
                 {2, 7},{2, 7},{2, 7}};        
        trials = [1:3];
        date = {'21-Jun-2021', '23-Jun-2021','25-Jun-2021','28-Jun-2021',...
                '07-Jul-2021','12-Jul-2021','21-Jul-2021','20-Sep-2021',...
                '22-Sep-2021','27-Sep-2021', '29-Sep-2021','04-Oct-2021',...
                '06-Oct-2021','18-Oct-2021','20-Oct-2021','28-Oct-2021',...
                '01-Nov-2021', '03-Nov-2021','08-Nov-2021','23-Nov-2021',...
                '29-Nov-2021','02-Dec-2021'};
        order = {{2},{1, 2},{1},{1, 2},{1, 2},{1, 2},{1, 2},{1, 2},{1, 2},...          
                 {1, 2},{1, 2},{1, 2},{1, 2},{1, 2},{1, 2},{1, 2}, {1, 2},...  
                 {1, 2},{1, 2},{1, 2},{1, 2},{1, 2}};
    elseif strcmp(subject,'P3')
        channels = [56, 3, 31];
        session = [3, 5, 6, 7, 8, 9, 11, 11, 12, 13, 13, 14, 14];
        stim_set = {{1}, {1}, {1}, {2}, {1}, {1}, {1}, {2}, {1}, {1}, {2}, {1}, {3}};
        block = {{2, 8}, {2, 8}, {2, 10}, {2, 5}, {2, 8}, {2, 8}, {2}, {2}, {2 6}, {2}, {2}, {2}, {2}};
        order = {{1, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 2}, {1}, {2}, {1, 2}, {1}, {2}, {1}, {2}};
        trials = [1:3];
        date = {'17-Aug-2021','09-Sep-2021','24-Sep-2021','28-Sep-2021','01-Oct-2021',...
                '07-Oct-2021','24-Nov-2021','24-Nov-2021','18-Jan-2022','08-Feb-2022','08-Feb-2022','22-Mar-2022','22-Mar-2022'};
    elseif strcmp(subject,'C1')
        channels = [17, 31, 53];
        session = [1, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 8, 9, 9, 10];
        stim_set = {{1},{2},{1},{1},{2},{1},{1},{1},{2},{1},{1},{2},{1},{2},{1}};
        block = {{2},{2},{2,6},{2},{2},{2,6},{2,6},{2},{2},{2,6},{2},{2},{2},{6},{2,6}};
        order = {{1},{2},{1,2},{1},{2},{1,2},{1,2},{1},{2},{1,2},{1},{2},{1},{2},{1,2}};
        trials = [1,2,3];
        date = {'15-Nov-2021','15-Nov-2021','20-Dec-2021','27-Dec-2021','27-Dec-2021','04-Jan-2022','07-Jan-2022','28-Jan-2022','28-Jan-2022','14-Feb-2022',...
                  '21-Feb-2022','21-Feb-2022','11-Mar-2022','11-Mar-2022','01-Apr-2022'};
    end

    axes = {'frequency','amplitude','biomimetic factor','drag'};

    idx1 = 1;
    idx2 = 1;
    idx3 = 1;
    ch1 = [];
    ch2 = [];
    ch3 = [];
    ch_order = [];
    for s=1:numel(session)
        datapath = fullfile(data_folder,subject,['session.',num2str(session(s))]);

        cd(datapath)
        for ss=1:numel(stim_set{s})
            for b=1:numel(block{s})
                for t=1:numel(trials)
                    if block{s}{b} >= 10
                        trialFile = fullfile(['FrequencyData.Set000',num2str(stim_set{s}{ss}),'.Block00',num2str(block{s}{b}),'.Trial000',num2str(trials(t)),'.',date{s},'.json']);
                    else
                        trialFile = fullfile(['FrequencyData.Set000',num2str(stim_set{s}{ss}),'.Block000',num2str(block{s}{b}),'.Trial000',num2str(trials(t)),'.',date{s},'.json']);
                    end
                    trialData{t} = jsondecode(fileread(trialFile));

                    channel = trialData{t}.stimInfo.channel;

                    if channel == channels(1)
                        ch1(idx1,:) = trialData{t}.stimInfo.most_intense;
                        idx1 = idx1+1;
                    elseif channel == channels(2)
                        ch2(idx2,:) = trialData{t}.stimInfo.most_intense;
                        idx2 = idx2+1;
                    elseif channel == channels(3)
                        ch3(idx3,:) = trialData{t}.stimInfo.most_intense;
                        idx3 = idx3+1;
                    end  
                    ch_order = [ch_order; channel trialData{t}.stimInfo.most_intense order{s}{b}];
                end
            end
        end
    end

    pre_choice = ch_order(ch_order(:,3)==1,1:2);
    post_choice = ch_order(ch_order(:,3)==2,1:2);
    ch1_pre = pre_choice(pre_choice(:,1)==channels(1),2);
    ch1_post = post_choice(post_choice(:,1)==channels(1),2);
    ch2_pre = pre_choice(pre_choice(:,1)==channels(2),2);
    ch2_post = post_choice(post_choice(:,1)==channels(2),2);
    ch3_pre = pre_choice(pre_choice(:,1)==channels(3),2);
    ch3_post = post_choice(post_choice(:,1)==channels(3),2);

    figure;
    subplot(1,3,1)
    bar([1, 2],[(sum(ch1_pre==20)/numel(ch1_pre))*100, (sum(ch1_pre==85)/numel(ch1_pre))*100, (sum(ch1_pre==150)/numel(ch1_pre))*100; (sum(ch1_post==20)/numel(ch1_post))*100, (sum(ch1_post==85)/numel(ch1_post))*100, (sum(ch1_post==150)/numel(ch1_post))*100])
    xlabel('frequency(Hz)')
    ylabel('counts')
    title('ch 1')
    ylim([0 100])
    set(gca,'FontSize',15)
    subplot(1,3,2)
    bar([1, 2],[(sum(ch2_pre==20)/numel(ch2_pre))*100, (sum(ch2_pre==85)/numel(ch2_pre))*100, (sum(ch2_pre==150)/numel(ch2_pre))*100; (sum(ch2_post==20)/numel(ch2_post))*100, (sum(ch2_post==85)/numel(ch2_post))*100, (sum(ch2_post==150)/numel(ch2_post))*100])
    xlabel('frequency(Hz)')
    ylabel('counts')
    title('ch 2')
    ylim([0 100])
    set(gca,'FontSize',15)
    subplot(1,3,3)
    bar([1, 2],[(sum(ch3_pre==20)/numel(ch3_pre))*100, (sum(ch3_pre==85)/numel(ch3_pre))*100, (sum(ch3_pre==150)/numel(ch3_pre))*100; (sum(ch3_post==20)/numel(ch3_post))*100, (sum(ch3_post==85)/numel(ch3_post))*100, (sum(ch3_post==150)/numel(ch3_post))*100])
    xlabel('frequency(Hz)')
    ylabel('counts')
    title('ch 3')
    ylim([0 100])
    set(gca,'FontSize',15)
    sgtitle(subject)
end
