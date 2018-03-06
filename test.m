test_out = zeros(size(out_imgs_slow));
interlacer = vision.Deinterlacer;

for i = 1 : size(out_imgs_slow,4)
   
    test_out(:,:,:,i) = interlacer(out_imgs_slow(:,:,:,i));
    
end