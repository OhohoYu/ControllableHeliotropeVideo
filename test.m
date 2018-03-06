imshow(imgs(:,:,:,start_img));
hold on;
plot(clicked_pts(:,1),clicked_pts(:,2),'-o','Color',[1,0,0], 'LineWidth', 1.5, 'MarkerSize', 5);
plot(est_path(:,1),est_path(:,2),'-o','Color',[0,0.7,0.9], 'LineWidth', 1.5, 'MarkerSize', 5);
