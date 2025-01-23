function [mean_dist, st_dist] = distance_objects(data1,data2)
    dist_objects = [];
    for i=1:size(data1,1)
        for j=1:size(data2,1)
            dist_objects = [dist_objects pdist([data1(i,:); data2(j,:)])];
        end
    end
    mean_dist = mean(dist_objects);
    st_dist = std(dist_objects);
end