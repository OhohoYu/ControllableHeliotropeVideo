function advected_locs = compute_advected_locs(Paths, flows_a, start_pt, point)
    
    n_imgs = size(Paths,2);
    advected_locs = zeros(n_imgs, 2);
    
    for i = 1 : n_imgs
        path = Paths{1,i};
        
        if (size(path,2) > 1)
            
            advected_locs(i, 1) = start_pt(1);
            advected_locs(i, 2) = start_pt(2);

            % Iterate each node in the path and sum the optical flow between
            % each node
            for p = 1 : size(path,2)-1
                flow = get_optical_flow(path(p), path(p+1), flows_a);
                advected_locs(i, 1) = advected_locs(i, 1) + flow(point(2),point(1),1);
                advected_locs(i, 2) = advected_locs(i, 2) + flow(point(2),point(1),2);
            end
        end
        
    end
end

function flow = get_optical_flow(i, j, flows_a)
    if (i > j)
        k = (i-1) * (i-2) / 2 + j;
        flow = flows_a(:,:,:,k);
    else
        k= (j-1) * (j-2) / 2 + i;
        flow = -flows_a(:,:,:,k');
    end
end