function out_imgs = labs6_trajectory(path, prefix, first, last, digits, suffix, n_interm_frames,flows_a)

    load('example.mat');

    % Example function call
    % labs6_slowmo('gjbLookAtTargets', 'gjbLookAtTarget_00', 0, 71, 2, 'jpg', 4);

    % Load sequence of images
    disp('Loading images...');
    imgs = load_sequence_color(path, prefix, first, last, digits, suffix);
    imgs = imresize(imgs, 0.3);

    n_imgs = size(imgs,4);         

    % Calculate distance matric
    disp('Computing distance matrix...');
    if ~exist('gjb_dist_matrix.mat', 'file') 
        dist_matr = calc_dist_matrix(imgs);
        save('gjb_dist_matrix.mat', 'dist_matr');
    else
        load('gjb_dist_matrix.mat', 'dist_matr');
    end

    % Use threshold to eliminate large distances
    dist_matr(dist_matr > 65) = 0;
    dist_graph = biograph(sparse(dist_matr));

    % Load the optical flow
    disp('Loading optical flow...');
%     load('flows.mat');

    % Ask the user to input the starting image
    % start_img = -1;
    % while (start_img < 1 || start_img > n_imgs)
    %     start_img = input('Input the number of the starting frame between 1 and 72: ');
    % end

    % Get input from user for series of locations on starting image
    % clicked_pts = user_path_locations(imgs(:,:,:,start_img));

    disp('Computing path...');

    src_node = start_img;
    out_path = [];
    est_path = [clicked_pts(1,:)];

    % Loop through clicked points i.e. each segment
    for i = 2 : size(clicked_pts,1)

        start_pt = clicked_pts(i-1,:);

        % Compute shortest path between source node and all others
        Paths = compute_shortest_paths(dist_graph, src_node, n_imgs);
        
        % Get mid point between clicked points
        interm_pt = [(start_pt(1)+clicked_pts(i,1))/2, (start_pt(2)+clicked_pts(i,2))/2];
        interm_pt = round(interm_pt);
        
        advected_locs = compute_advected_locs(Paths, flows_a, start_pt, interm_pt);
        [closest_node, closest_pt] = get_closest_node(n_imgs, advected_locs, interm_pt);
        
        % Add shortest path to closest node to output array and closest point
        % to estimated path
        out_path = [out_path, Paths(1,closest_node)];
        est_path = [est_path; closest_pt];
        
        src_node = closest_node;
        
        Paths = compute_shortest_paths(dist_graph, src_node, n_imgs);

        % Compute advected locations of point s in other nodes
        advected_locs = compute_advected_locs(Paths, flows_a, interm_pt, clicked_pts(i,:));

        % Get node that is closest to the clicked position
        [closest_node, closest_pt] = get_closest_node(n_imgs, advected_locs, clicked_pts(i,:));
        
        % Add shortest path to closest node to output array and closest point
        % to estimated path
        out_path = [out_path, Paths(1,closest_node)];
        est_path = [est_path; closest_pt];

        % Update src_node for next iteration
        src_node = closest_node;
    end

    % Convert out_path into an array containing indexes of each image in the
    % path
    out_imgs_index = [1];
    n = 2;
    for i = 1 : size(out_path,2)
        for j = 2 : size(out_path{1,i},2)
            out_imgs_index(n) = out_path{1,i}(j);
            n = n + 1;
        end
    end

    % Loop through path and add extra frames for slow mo effect
    disp('Adding intermediate frames from optical flow...');
    out_imgs_slow = [imgs(:,:,:,start_img)];

    for i = 2 : size(out_imgs_index,2)
        img1 = imgs(:,:,:,out_imgs_index(i-1));
        img2 = imgs(:,:,:,out_imgs_index(i));

        interm = get_interm_frames(img1, n_interm_frames, flows_a, out_imgs_index(i-1), out_imgs_index(i));
        out_imgs_slow = cat(4, out_imgs_slow, interm, img2);
    end

    % Save image sequence
%     save_sequence(out_imgs_slow, 'output_slowmo', 'out_seq_', 1, 4);

    % Save as video file
%     vid_writer = VideoWriter('slow_mo.avi');
%     vid_writer.FrameRate = 10;
%     open(vid_writer);
% 
%     out_imgs_slow(out_imgs_slow > 1) = 1;
%     out_imgs_slow(out_imgs_slow < 0) = 0;
% 
%     for i = 1:size(out_imgs_slow,4)
%         writeVideo(vid_writer, out_imgs_slow(:,:,:,i));
%     end
% 
%     close(vid_writer);

    % Show user clicked path compared to estimated path
    imshow(imgs(:,:,:,start_img));
    hold on;
    plot(clicked_pts(:,1),clicked_pts(:,2),'-o','Color',[1,0,0], 'LineWidth', 1.5, 'MarkerSize', 5);
    plot(est_path(:,1),est_path(:,2),'-o','Color',[0,0.7,0.9], 'LineWidth', 1.5, 'MarkerSize', 5);

    % Play output image sequence
    implay(out_imgs_slow);
end