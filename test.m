vid_writer = VideoWriter('slow_mo.avi');
vid_writer.FrameRate = 4;
open(vid_writer);

for i = 1:size(out_imgs_slow,4)
    writeVideo(vid_writer, out_imgs_slow(:,:,:,i));
end

close(vid_writer);