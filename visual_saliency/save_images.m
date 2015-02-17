
%%%%%%%%%%%%%%%%%%%%%%%%
%%%% STEP 1 %%%%%%%%%%%%
%%%% PREPARE DATA %%%%%%
%%%% AND PTB      %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
sdata = readtable('Data_list/current_subject_data.txt');


% OPEN PTB SCREEN

%Here screen is opened just for changing the SyncTest preferences 
Screen('Preference', 'SkipSyncTests', 1); %forgo syncTests
Screen('Preference', 'VBLTimestampingMode', -1);

%Getting center pixels
[m_win, myRect] = Screen('OpenWindow', 0, [0 0 0], [0 0 1280 1024]);

%display dark screen again
Screen('FillRect', m_win, [0 0 0]);
Screen(m_win, 'Flip');

%close screen again
[c_x, c_y] = RectCenter(myRect);


%initialize all pictures

for j=1:114;
    cur_num = num2str(j); %number of current picture
    cur_dir = ['pos_food_numbered/nr' cur_num '.bmp']; %current picture
    cur_dat.Images{j} = imread(cur_dir); %read in current image
end


%%%%%%%%%%%%%%%%%%%%%%
%%%% STEP 2      %%%%%
%%%% SAVE IMAGES %%%%%
%%%%%%%%%%%%%%%%%%%%%%


for z = 1:length(sdata.Subject)

s_str = num2str(sdata.Subject(z));
size_str = num2str(sdata.Set_size(z));

set_size = sdata.Set_size(z);


% Reading in file

f_name = ['choices_R_' s_str '_' size_str '.txt'];

temp_mat = tblread(['choices/' f_name]);


if set_size == 4
    cur_dat.Snacks = temp_mat(:,5:8);
end

if set_size == 6
    cur_dat.Snacks = temp_mat(:,5:10);
end

if set_size == 8
    cur_dat.Snacks = temp_mat(:,5:12);
end


% Initialize picture positions (we go for picture size 266-200)
% The average distance between all possible item pairs on the screen is
% Equal across all set_sizes (Average distance chosen = 444.23 pixels)

if set_size == 4
    
    % We identify the center coordinates of every item (from average
    % distance = 444.23, it follows delta-x = 195 (rounded), delta-y = 195 (rounded), 
    % delta-x and delta-y have been equated in the calculation for set_size = 4)
    
    dx = 195;
    dy = 195;
    pic_x = 266;
    pic_y = 200;
    
    centers = zeros(set_size,2);
    centers(1,:) = [c_x - dx, c_y - dy];
    centers(2,:) = [c_x + dx, c_y - dy];
    centers(3,:) = [c_x - dx, c_y + dy];
    centers(4,:) = [c_x + dx, c_y + dy];
    
dest_pics = ...
    [centers(1,1) - (pic_x/2), centers(1,2) - (pic_y/2), centers(1,1) + (pic_x/2), centers(1,2) + (pic_y/2) ; ...
     centers(2,1) - (pic_x/2), centers(2,2) - (pic_y/2), centers(2,1) + (pic_x/2), centers(2,2) + (pic_y/2); ...
     centers(3,1) - (pic_x/2), centers(3,2) - (pic_y/2), centers(3,1) + (pic_x/2), centers(3,2) + (pic_y/2); ...
     centers(4,1) - (pic_x/2), centers(4,2) - (pic_y/2), centers(4,1) + (pic_x/2), centers(4,2) + (pic_y/2)];
end

if set_size == 6
    
     %we identify the center coordinates of every item (from average
     %distance = 444.23, it follows delta-x = 331 (rounded), delta-y = 165 (rounded), 
     %delta-x = 2*delta-y in the calculation for set_size = 6)
    
    dx = 331;
    dy = 165;
    pic_x = 266;
    pic_y = 200;
    
    centers = zeros(set_size,2);
    centers(1,:) = [c_x - dx, c_y - dy];
    centers(2,:) = [c_x, c_y - dy];
    centers(3,:) = [c_x + dx, c_y - dy];
    centers(4,:) = [c_x - dx, c_y + dy];
    centers(5,:) = [c_x, c_y + dy];
    centers(6,:) = [c_x + dx, c_y + dy];
     
    dest_pics = ...
        [centers(1,1) - (pic_x/2), centers(1,2) - (pic_y/2), centers(1,1) + (pic_x/2), centers(1,2) + (pic_y/2); ...
         centers(2,1) - (pic_x/2), centers(2,2) - (pic_y/2), centers(2,1) + (pic_x/2), centers(2,2) + (pic_y/2); ...
         centers(3,1) - (pic_x/2), centers(3,2) - (pic_y/2), centers(3,1) + (pic_x/2), centers(3,2) + (pic_y/2); ...
         centers(4,1) - (pic_x/2), centers(4,2) - (pic_y/2), centers(4,1) + (pic_x/2), centers(4,2) + (pic_y/2); ...
         centers(5,1) - (pic_x/2), centers(5,2) - (pic_y/2), centers(5,1) + (pic_x/2), centers(5,2) + (pic_y/2); ...
         centers(6,1) - (pic_x/2), centers(6,2) - (pic_y/2), centers(6,1) + (pic_x/2), centers(6,2) + (pic_y/2)]; ...
end

if set_size == 8
    
    % we identify the center coordinates of every item (from average
    % distance = 444.23, it follows delta-x = 331 (rounded), delta-y = 165 (rounded)
    
    dx = 318;
    dy = 126;
    pic_x = 266;
    pic_y = 200;
    
    centers = zeros(set_size,2);
    centers(1,:) = [c_x - 1.5*dx, c_y - dy];
    centers(2,:) = [c_x - (dx/2), c_y - dy];
    centers(3,:) = [c_x + (dx/2), c_y - dy];
    centers(4,:) = [c_x + 1.5*dx, c_y - dy];
    centers(5,:) = [c_x - 1.5*dx, c_y + dy];
    centers(6,:) = [c_x - (dx/2), c_y + dy];
    centers(7,:) = [c_x + (dx/2), c_y + dy];
    centers(8,:) = [c_x + 1.5*dx, c_y + dy];
    
    
    dest_pics = ...
        [centers(1,1) - (pic_x/2), centers(1,2) - (pic_y/2), centers(1,1) + (pic_x/2), centers(1,2) + (pic_y/2); ...
         centers(2,1) - (pic_x/2), centers(2,2) - (pic_y/2), centers(2,1) + (pic_x/2), centers(2,2) + (pic_y/2); ...
         centers(3,1) - (pic_x/2), centers(3,2) - (pic_y/2), centers(3,1) + (pic_x/2), centers(3,2) + (pic_y/2); ...
         centers(4,1) - (pic_x/2), centers(4,2) - (pic_y/2), centers(4,1) + (pic_x/2), centers(4,2) + (pic_y/2); ...
         centers(5,1) - (pic_x/2), centers(5,2) - (pic_y/2), centers(5,1) + (pic_x/2), centers(5,2) + (pic_y/2); ...
         centers(6,1) - (pic_x/2), centers(6,2) - (pic_y/2), centers(6,1) + (pic_x/2), centers(6,2) + (pic_y/2); ...
         centers(7,1) - (pic_x/2), centers(7,2) - (pic_y/2), centers(7,1) + (pic_x/2), centers(7,2) + (pic_y/2); ...
         centers(8,1) - (pic_x/2), centers(8,2) - (pic_y/2), centers(8,1) + (pic_x/2), centers(8,2) + (pic_y/2)]; ...
end


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%% START TRIALS OF TASK 2 %%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %initialize image cell for current choice sets
cur_images = cell(set_size, 1); 
    %start trials
    
for i = 1:300
    HideCursor;
    Screen('FillRect', m_win, [0 0 0]);
    %load new choice set
    
    for j = 1:set_size
        cur_snack = cur_dat.Snacks(i,j);
        
        cur_images{j} = cur_dat.Images{cur_snack};
    end
     
    for j = 1:set_size
        cur_im{j} = Screen('MakeTexture', m_win, cur_images{j});
        Screen('DrawTextures', m_win, cur_im{j}, [], dest_pics(j,:));
    end
    
        Screen(m_win, 'Flip');
        cur_screen = Screen(m_win,'GetImage',[0 0 1280 1024]);
        
        trial_nr = num2str(i);
        image_save_file = ['visual_saliency/displays_shown_img/subject_' s_str '_setsize_' size_str '_' trial_nr '.png'];
        imwrite(cur_screen,image_save_file);
        Screen('Close');
end
end
Screen('CloseAll');

