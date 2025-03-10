function plot_single_trial_cursor_movement(data_folder, subject)
    % determine what data to load
    if strcmp(subject,'P2')
        session = [7 8 9 10 11 12 15 16 17 19 20 21 22 23 24 27 28 29 30 31 32 33]; 
        stim_set = {{1}, {1}, {3}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, ...
                    {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}};           
        block = {{3, 4, 5}, {3, 4}, {3, 4}, {3, 4, 5}, {3, 4, 5, 6}, {3, 4}, ...          
                 {3, 4}, {3, 4}, {3, 4, 5}, {3, 4}, {3, 4}, {3, 4}, {3, 4, 5},...
                 {3, 4, 5}, {3, 4, 5}, {3, 4, 5}, {3, 4, 5}, {3, 4}, {3, 4}, ...
                 {3, 4}, {3, 4}, {3, 4}};
        trials = {{{1, 2, 3}, {1, 2, 3}, {1, 2}},...
                 {{1, 2, 3}, {1, 2, 3}}, ...
                 {{1, 2, 3}, {1, 2, 3}}, ...     
                 {{1, 2, 3}, {1, 2, 3}, {1, 2, 3}}...       
                 {{1, 2, 3}, {1, 2, 3}, {1, 2, 3}, {1, 2, 3}},... 
                 {{1, 2, 3}, {1, 2, 3}},...                      
                 {{1, 2, 3}, {1, 2, 3}},...                    
                 {{1, 2, 3}, {1, 2, 3}},...                      
                 {{1, 2, 3}, {1, 2, 3}, {1, 2, 3}},...          
                 {{1, 2, 3}, {1, 2, 3}},...                     
                 {{1, 3}, {1, 2, 3}},...                        
                 {{1, 2, 3}, {1, 2, 3}},...                      
                 {{1, 2, 3}, {1, 3}, {1, 2, 3}},...             
                 {{1, 2, 3}, {1, 2, 3}, {1, 2, 3}},...            
                 {{1, 2, 3}, {1, 2, 3}, {1, 2, 3}},...            
                 {{1, 2, 3}, {1, 2}, {1}},...                
                 {{1, 2, 3}, {1, 2, 3}, {1, 2, 3}},...      
                 {{1, 3}, {1, 2}},...                         
                 {{1, 2, 3}, {1, 2, 3}},...                 
                 {{1, 2, 3}, {1, 2, 3}},...                   
                 {{1, 2, 3}, {1, 2, 3}},...                     
                 {{1, 2, 3}, {3}}};                            
        date = {'21-Jun-2021', '23-Jun-2021','25-Jun-2021','28-Jun-2021',...
                '07-Jul-2021','12-Jul-2021','21-Jul-2021','20-Sep-2021',...
                '22-Sep-2021','27-Sep-2021', '29-Sep-2021','04-Oct-2021',...
                '06-Oct-2021','18-Oct-2021','20-Oct-2021','28-Oct-2021',...        
                '01-Nov-2021', '03-Nov-2021','08-Nov-2021','23-Nov-2021',...
                '29-Nov-2021','02-Dec-2021'};
    elseif strcmp(subject,'P3')
        session = [3, 5, 6, 7, 8, 9, 11, 12, 13, 13, 14, 14];
        stim_set = {{1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {2}, {1}, {3}};
        block = {{3, 4, 5, 6}, {3, 4, 5, 6}, {3, 4, 5, 6, 7, 8}, {3, 4, 5, 6}, {3, 4}, {3, 4}, {3, 4}, {3, 4}, {3}, {3}, {3}, {4}};
        trials = {{{1, 2, 3}, {1, 2, 3}, {1, 2, 3}, {1, 2, 3}},...
                  {{1, 2, 3}, {1, 2, 3}, {1, 2, 3}, {1, 2, 3}},...
                  {{1, 2, 3}, {1, 2, 3}, {1, 2}, {1, 2, 3}, {1, 2, 3}, {1, 2, 3}},...
                  {{1, 2, 3}, {1, 2}, {1, 2, 3}, {1, 2, 3}},...
                  {{1, 2, 3},{1, 2, 3}},...
                  {{1, 2, 3},{1, 2, 3}},...
                  {{2, 3, 4, 5}, {2, 4, 5}},...
                  {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}},...
                  {{1, 2, 3, 4, 5}},...
                  {{1, 2, 3, 4, 5}},...
                  {{1, 2, 3, 4, 5}},...
                  {{1, 2, 3, 4, 5}}};
        date = {'17-Aug-2021','09-Sep-2021','24-Sep-2021','28-Sep-2021','01-Oct-2021',...
                '07-Oct-2021','24-Nov-2021','18-Jan-2022','08-Feb-2022','08-Feb-2022','22-Mar-2022','22-Mar-2022'};
    elseif strcmp(subject,'C1')
        session = [1,1,2,3,4,5,6,7,8,8,9,10];
        stim_set = {{1},{2},{1},{1},{1},{1},{1},{1},{1},{2},{1},{1}};
        block = {{3},{3,4},{3,4},{3,4},{3,4},{3,4},{3,4},{3,4},{3},{4},{3,4},{3,4}};
        trials = {{{1,2,3,4,5}},...
                 {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5},{1, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}},...
                 {{1, 2, 3, 4, 5},{1, 2, 3, 4, 5}}};
        date = {'15-Nov-2021','15-Nov-2021','20-Dec-2021','27-Dec-2021',...
                  '04-Jan-2022','07-Jan-2022','28-Jan-2022','14-Feb-2022',...
                  '21-Feb-2022','21-Feb-2022','11-Mar-2022','01-Apr-2022'};
    end

    axes = {'frequency','amplitude','biomimetic factor','drag'};

    all_times = [];
    all_counts = [];
    for s=1:numel(session)
        datapath = fullfile(data_folder,subject,['session.',num2str(session(s))]);

        cd(datapath)
        for ss=1:numel(stim_set{s})
            for b=1:numel(block{s})
                for t=1:numel(trials{s}{b})

                    trialFile = fullfile(['TrialSummary.Set000',num2str(stim_set{s}{ss}),'.Block000',num2str(block{s}{b}),'.Trial000',num2str(trials{s}{b}{t}),'.',date{s},'.json']);
                    trialData{t} = jsondecode(fileread(trialFile));

                    stimFile = fullfile(['StimData.Set000',num2str(stim_set{s}{ss}),'.Block000',num2str(block{s}{b}),'.Trial000',num2str(trials{s}{b}{t}),'.',date{s},'.json']);
                    stimData{t} = jsondecode(fileread(stimFile));

                    % plot cursor behavior
                    length = sum(any(stimData{t}.stimInfo.active_channel,2));
                    white = [255 255 255]/255;
                    red = [255 0 0]/255;
                    gradient = [linspace(white(1),red(1),length)', linspace(white(2),red(2),length)', linspace(white(3),red(3),length)'];

                    figure;
                    subplot(1,2,1)
                    hold on;
                    left_canvas_x = stimData{t}.userInfo.cursor_canvas_left(:,1);
                    left_canvas_y = stimData{t}.userInfo.cursor_canvas_left(:,2);
                    plot(left_canvas_x,left_canvas_y,'k')
                    scatter(left_canvas_x(any(stimData{t}.stimInfo.active_channel,2)),left_canvas_y(any(stimData{t}.stimInfo.active_channel,2)),[],gradient,'filled')
                    axis square
                    title('left canvas')
                    xlabel('cursor X')
                    ylabel('cursor Y')
                    if strcmp(subject,'C1')
                        ylim([120 910])
                        xlim([20 490])
                     else
                        ylim([90 650])
                        xlim([20 440])
                    end

                    set(gca,'FontSize',15)
                    subplot(1,2,2)
                    hold on;

                    right_canvas_x = stimData{t}.userInfo.cursor_canvas_right(:,1);
                    right_canvas_y = stimData{t}.userInfo.cursor_canvas_right(:,2);
                    plot(right_canvas_x,right_canvas_y,'k')
                    scatter(right_canvas_x(any(stimData{t}.stimInfo.active_channel,2)),right_canvas_y(any(stimData{t}.stimInfo.active_channel,2)),[],gradient,'filled')
                    axis square
                    title('right canvas')
                    xlabel('cursor X')
                    ylabel('cursor Y')
                    sgtitle([erase(subject,'Lab'), ' - ',erase(trialData{t}.trialInfo.object,'images\')])
                    set(gca,'FontSize',15)
                    if strcmp(subject,'C1')
                        ylim([120 910])
                        xlim([565 1025])
                    else
                        ylim([90 650])
                        xlim([470 890])
                    end
                    idx = find(stimData{t}.stimInfo.active_channel(:,2)==1);
                    diff_idx = diff(idx);
                    all_times = [all_times ((sum(stimData{t}.stimInfo.active_channel(:,2))*20)/1000)/60];
                    all_counts = [all_counts sum(diff_idx>1)];
                end
            end
        end
    end
end
