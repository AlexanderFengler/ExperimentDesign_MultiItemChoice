

clear all;

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

Screen('CloseAll');




sdata = readtable('Data_list/current_subject_data.txt');


% now for all subjects set_sizes and trials

for cnt = 1:length(sdata.Subject)
    subject_str = num2str(sdata.Subject(cnt));
    set_size_str = num2str(sdata.Set_size(cnt));
    
    
        fid = fopen(['visual_saliency/saliencies/saliencies_subject_' subject_str '_setsize_' set_size_str '.txt'],'w+') ; 
        fprintf(fid, '%s\n', 'Subject Set_size Trial Saliency_1 Saliency_2 Saliency_3 Saliency_4 Saliency_5 Saliency_6 Saliency_7 Saliency_8');
        
        
        
   subject = sdata.Subject(cnt);
   set_size = sdata.Set_size(cnt);
   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% INITIALIZING PICTURE DESTINATIONS %%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
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


        %%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% SAVING PICTURES %%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%
     
        
        for k = 1:300
            trial_str = num2str(k);
            

            img = initializeImage(['visual_saliency/displays_shown_img/subject_' ...
                                    subject_str '_setsize_' set_size_str '_' trial_str '.png']);
            params = defaultSaliencyParams;
            salmap = makeSaliencyMap(img,params);
            bigMap = imresize(salmap.data,img.size(1:2));

            item_saliency(1:8) = -1;

            for l = 1:set_size
                
                % Be aware in the bigMap file, x and y are actually
                % switched it has 1024 rows (x values) and 1280 columns (y values)
                item_saliency(l) = sum(sum(bigMap(dest_pics(l,2):dest_pics(l,4),dest_pics(l,1):dest_pics(l,3))));
            end
            
            ssk = round([subject set_size k]);
            
            fprintf(fid, '%.0f ', ssk);
            fprintf(fid, '%.1f ', item_saliency(1:(8-1)));
            fprintf(fid, '%.1f', item_saliency(8));
            fprintf(fid, '\n');
            
            ['Subject: ' subject_str ' Set Size: ' set_size_str ' Trial: ' trial_str]
                
        end
        fclose(fid);
end

   
    
    
    
    
    
   






