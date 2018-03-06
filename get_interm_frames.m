function out_imgs = get_interm_frames(img1, n_frames, flows_a, img1_index, img2_index)

    flow = get_optical_flow(img1_index, img2_index, flows_a);
    out_imgs = [];
    
    flow = -flow./(n_frames+1);

    for i = 1 : n_frames
        flow_i = flow*i;
        warp = imwarp(img1, flow_i);
        out_imgs(:,:,:,i) = warp;
    end
end