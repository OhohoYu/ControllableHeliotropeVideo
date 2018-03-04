% Load sequence of images
disp('Loading images...');
imgs = load_sequence_color('resources/gjbLookAtTargets', 'gjbLookAtTarget_00', 0, 71, 2, 'jpg');
imgs = imresize(imgs, 0.3);
% imgs = load_sequence_color('resources/pendulum', 'pendulum00', 0, 50, 2, 'jpeg');

n_imgs = size(imgs,4);

% Calculate distance matric (dense)
disp('Computing distance matrix...');
if ~exist('gjb_dist_matrix.mat', 'file') 
    dist_matr = calc_dist_matrix(imgs);
else
    load('gjb_dist_matrix.mat', 'dist_matr');
end

% Use threshold to eliminate large changes between frames for the graph
dist_matr(dist_matr > 250) = 0;
dist_graph = biograph(sparse(dist_matr));

% Load the optical flow
disp('Loading optical flow...');
% load('flows.mat'); % TODO Uncomment for submission

% Ask the user to input the starting image
start_img = 1;
while (start_img < 1 || start_img > n_imgs)
    start_img = input('Input the number of the starting frame between 1 and 72: ');
end

% Get input from user for series of locations on starting image
clicked_points = user_path_locations(imgs(:,:,:,start_img));

src_node = start_img;
out_path = [];

% Loop through clicked points i.e. each segment
for i = 1 : size(clicked_points,1)
    
    % Compute shortest path between source node and all others
    Paths = compute_shortest_paths(dist_graph, src_node, n_imgs);
    
    % Compute advected locations of point s in other nodes
    advected_locs = compute_advected_locs(Paths, flows_a, clicked_points(i,:));
    
    % Pick path whose advected location comes closest to next clicked point
    % (t)
    diff = zeros(n_imgs,1);
    for n = 1 : n_imgs
        diff(n,1) = sqrt((advected_locs(n,1)-clicked_points(i,1))^2 + (advected_locs(n,1)-clicked_points(i,2))^2);
    end
    
    closest_node = find(diff==min(diff));
    
    out_path = [out_path, Paths(1,closest_node)];
    
    disp(src_node);
    src_node = closest_node;
    
    % Update src img for next points
%     src_node = closest_node;
end





