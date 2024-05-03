function plot_visual_vs_nonvisual_context(data_folder)
    subject = 'P2';
    P2 = load(fullfile(data_folder, subject,'object_survey_data.mat'));
    subject = 'P3';
    P3 = load(fullfile(data_folder, subject,'object_survey_data.mat'));
    subject = 'C1';
    C1 = load(fullfile(data_folder, subject,'object_survey_data.mat'));

    % plot differences in standard deviation
    figure;
    data = {};
    data.P2nonvisual = P2.std_nvisual(P2.std_nvisual>0);
    data.P2visual = P2.std_visual(P2.std_visual>0);
    data.P3nonvisual = P3.std_nvisual(P3.std_nvisual>0);
    data.P3visual = P3.std_visual(P3.std_visual>0);
    data.C1nonvisual = C1.std_nvisual(C1.std_nvisual>0);
    data.C1visual = C1.std_visual(C1.std_visual>0);
    violinplot(data)
    ylabel('standard deviation')

    % plot differences in absolute means
    figure;
    data = {};
    data.P2nonvisual = P2.diff_means_nv(P2.diff_means_nv>=0);
    data.P2visual = P2.diff_means_v(P2.diff_means_v>=0);
    data.P3nonvisual = P3.diff_means_nv(P3.diff_means_nv>=0);
    data.P3visual = P3.diff_means_v(P3.diff_means_v>=0);
    data.C1nonvisual = C1.diff_means_nv(C1.diff_means_nv>=0);
    data.C1visual = C1.diff_means_v(C1.diff_means_v>=0);
    violinplot(data)
    ylabel('participant - survey')
end