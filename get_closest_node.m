function [closest, closest_point] = get_closest_node(n_imgs, advected_locs, clicked_point)
    
    diff = zeros(n_imgs,1);
    
    for n = 1 : n_imgs
        x = advected_locs(n,1)-clicked_point(1);
        y = advected_locs(n,2)-clicked_point(2);
        
        diff(n,1) = sqrt(x^2 + y^2);
    end
    
    closest = find(diff == min(diff));
    closest_point = advected_locs(closest,:);
end