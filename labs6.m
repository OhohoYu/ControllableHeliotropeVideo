% Load sequence of images
disp('Loading images...');
imgs = load_sequence_color('resources/gjbLookAtTargets', 'gjbLookAtTarget_00', 0, 71, 2, 'jpg');
% imgs = load_sequence_color('resources/pendulum', 'pendulum00', 0, 50, 2, 'jpeg');

% Calculate distance matric (dense)
disp('Computing distance matrix...');
if ~exist('gjb_dist_matrix.mat', 'file') 
    dist_matr = calc_dist_matrix(imgs);
else
    load('gjb_dist_matrix.mat', 'dist_matr');
end

% Use threshold to eliminate large changes between frames for the graph
dist_matr(dist_matr > 150) = 0;
dist_graph = sparse(dist_matr);

% Ask the user to input starting images
start_img = -1;
while (start_img < 1 || start_img > size(imgs,4))
    start_img = input('Input the number of the starting frame between 1 and 72: ');
end

% Get input from user for series of locations on starting image
[user_x, user_y] = get_path_locations(imgs(:,:,:,start_img));




