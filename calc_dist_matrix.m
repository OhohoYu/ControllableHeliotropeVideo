function dist_matr = calc_dist_matrix(imgs)

    n_imgs = size(imgs,4);
    dist_matr = zeros(n_imgs,n_imgs);
    
    for i = 1 : n_imgs
        for j = 1 : n_imgs 
            diff = imgs(:,:,:,i) - imgs(:,:,:,j);
            
            r = diff(:,:,1);
            g = diff(:,:,2);
            b = diff(:,:,3);
            
            dist_matr(i,j) = sqrt(sum(sum(r.^2 + g.^2 + b.^2)));
        end
    end        
end