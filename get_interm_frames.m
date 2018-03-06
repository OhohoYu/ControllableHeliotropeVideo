function out_imgs = get_interm_frames(img1, img2, n_frames, flows_a, img1_index, img2_index)

    flow = get_optical_flow(img1_index, img2_index, flows_a);
    out_imgs = [];

    for i = 1 : n_frames
        flow_x = flow(:,:,1);
        flow_y = flow(:,:,2);

        flow_x = flow_x./(i/n_frames+1);
        flow_y = flow_y./(i/n_frames+1);

        warp_r = warpFLColor(img1(:,:,1), img2(:,:,1), flow_x, flow_y);
        warp_g = warpFLColor(img1(:,:,2), img2(:,:,2), flow_x, flow_y);
        warp_b = warpFLColor(img1(:,:,3), img2(:,:,3), flow_x, flow_y);

        warp = cat(3, warp_r, warp_g, warp_b);
        out_imgs(:,:,:,i) = warp;
    end
end