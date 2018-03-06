function interm = get_interm_frames(img1, n_frames, flows_a, img1_index, img2_index)
    
    [rows,cols,~] = size(img1);

    flow = get_optical_flow(img1_index, img2_index, flows_a);
    interm = [];
    
    flow = -flow./(n_frames+1);

    for i = 1 : n_frames
        warped_img = imwarp(img1, flow*i);
        warped_img = imcrop(warped_img,[5 5 cols-5 rows-5]);
        warped_img = imresize(warped_img,[rows cols]);
        interm(:,:,:,i) = warped_img;
    end
end