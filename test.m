% test_out = zeros(size(out_imgs_slow));
% interlacer = vision.Deinterlacer;
% 
% for i = 1 : size(out_imgs_slow,4)
%    
%     test_out(:,:,:,i) = interlacer(out_imgs_slow(:,:,:,i));
%     
% end

for i = 1 : size(out_path,2)
    for j = 2 : size(out_path{1,i},2)
        out_imgs(:,:,:,n) = imgs(:,:,:,out_path{1,i}(j));
        n = n + 1;
    end
end