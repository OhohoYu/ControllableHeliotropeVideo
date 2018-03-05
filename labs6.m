% Load sequence of images
disp('Loading images...');
imgs = load_sequence_color('resources/gjbLookAtTargets', 'gjbLookAtTarget_00', 0, 71, 2, 'jpg');
imgs = imresize(imgs, 0.3);

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

disp('Computing path...');

src_node = start_img;
out_path = [];

% Loop through clicked points i.e. each segment
for i = 1 : size(clicked_points,1)
    
    % Compute shortest path between source node and all others
    Paths = compute_shortest_paths(dist_graph, src_node, n_imgs);
    
    % Compute advected locations of point s in other nodes
    advected_locs = compute_advected_locs(Paths, flows_a, clicked_points(i,:));
    
    % Get node that is closest to the clicked position
    closest_node = get_closest_node(n_imgs, advected_locs, clicked_points(i,:));
    
    % Add shortest path to closest node to output array
    out_path = [out_path, Paths(1,closest_node)];
    
    disp(src_node);
    src_node = closest_node;
end

% Convert output array into a sequence of images
out_imgs = [];
n = 1;
for i = 1 : size(out_path,2)
    for j = 1 : size(out_path{1,i},2)
        out_imgs(:,:,:,n) = imgs(:,:,:,out_path{1,i}(j));
        n = n + 1;
    end
end




