function out = average_interm_frames(interm, interm_back)
    
    out = zeros(size(interm));
    n_imgs = size(interm,4);
    
    for i = 1 : n_imgs
        out(:,:,:,i) = imhistmatch(interm(:,:,:,i), interm_back(:,:,:,n_imgs-i+1));
    end
end