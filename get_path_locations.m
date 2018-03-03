function [points_x, points_y] = get_path_locations(start_img)
    
    n_points = -1;
    while (n_points < 4 || n_points > 10)
        n_points = input('How many look-at points? (between 4 and 10): ');
    end
    
    points_x = zeros(1, n_points);
    points_y = zeros(1, n_points);
    
    imshow(start_img);
    
    for points_clicked = 1 : n_points
        [x,y] = ginput(1);
        hold on;
        plot(x,y,'r+');
        
        % Append arrays with clicked positions
        points_x(1, points_clicked) = x;
        points_y(1, points_clicked) = y;
    end

    close all;
end