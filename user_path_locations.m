function clicked_points = user_path_locations(start_img)
    
    n_points = -1;
    while (n_points < 4 || n_points > 10)
        n_points = input('How many look-at points? (between 4 and 10): ');
    end
    
    clicked_points = zeros(n_points, 2);    
    imshow(start_img);
    
    for points_clicked = 1 : n_points
        [x,y] = ginput(1);
        hold on;
        plot(x,y,'r+');
        
        % Append arrays with clicked positions
        clicked_points(points_clicked, 1) = round(x);
        clicked_points(points_clicked, 2) = round(y);
    end

    close all;
end