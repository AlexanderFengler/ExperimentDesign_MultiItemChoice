function liking_choices_training(s_number, session,num_trials_liking, set_size)

% We begin with converting the parameters into string to be able to include
% them into a file name
s_number_str = num2str(s_number);
session_str = num2str(session);
set_size_str = num2str(set_size);


        %%%%%%%%%%%
        %%%TASK1%%%
        %%%%%%%%%%%
        
%LIKING RATING PART STARTS

%Here screen is opened just for changing the SyncTest preferences 
Screen('Preferences', 'SkipSyncTests', 1); %forgo syncTests
Screen('Preference', 'VBLTimestampingMode', -1);

%Getting center pixels
[m_win, myRect] = Screen('OpenWindow', 0);

%close screen again
%storing center-pixels
[c_x, c_y] = RectCenter(myRect);

%display intro text and central fixation cross
Screen('FillRect', m_win, [0 0 0]);
Screen('Preference','DefaultFontSize', 22);
DrawFormattedText(m_win, 'We will start Task 1 now!' ,'center', 'center', [255 255 255]);
Screen(m_win, 'Flip');
WaitSecs(3);
Screen('FillRect', m_win, [0 0 0]);
Screen(m_win, 'Flip');
WaitSecs(1);
Screen('FillRect', m_win, [0 0 0]);
Screen('Preference','DefaultFontSize', 80);
DrawFormattedText(m_win, '+' ,'center', 'center', [255 255 255]);
Screen(m_win,'Flip');
HideCursor;
WaitSecs(3);

%initialize all pictures
img_cell = cell(19);
for j=1:19;
    cur_num = num2str(j); %number of current picture
    cur_dir = ['pos_food_training\nr' cur_num '.bmp']; %current picture
    cur_img = imread(cur_dir); %read in current image
    img_cell{j} = cur_img; %store in cell
end
%display dark screen again
Screen('FillRect', m_win, [0 0 0]);
Screen(m_win, 'Flip');
WaitSecs(2);

%Open file and write layout for output file
f_name =['likingratings\likingratings_subject_' s_number_str '_session_' session_str '.txt' ];
f_curr = fopen(f_name,'a+t');
fprintf(f_curr, '%53s \n\n', 'Liking Ratings for positive snack items');
fprintf(f_curr, '%20s %3.0f\n','Subject Number: ', s_number);
fprintf(f_curr, '%20s %3.0f\n','Session: ', session);
fprintf(f_curr, '%10s %10s %10s %10s \n', 'Trial', 'Stimulus_Nr', 'Snack_Nr' , 'Liking');

%start of the task // liking ratings
%for loop over trials
for i=1:(num_trials_liking) 
    
stim_num = 19; % beginning number of stimuli --> complete set of snack items
stim_order = randperm(stim_num);

if i == 1
%for the first trial we show all pictures and then store the ratings into
%the stim_rating vector to kick out negatively rated items directly
stim_rating = zeros(stim_num,1); % rating-vector

for j=1:19
Screen('FillRect', m_win, [0 0 0]);
Screen(m_win, 'Flip');
WaitSecs(0.5);
cur_im = Screen('MakeTexture', m_win, img_cell{stim_order(j)});
Screen('DrawTexture', m_win, cur_im);
Screen(m_win, 'Flip');
[secs, keycode] = KbWait([],2,[]);

%stimulus_num = num2str(j);
%food_item_num = num2str(stim_order(j));

%write trial number and stimulus number, the picture number and the ratings to file
fprintf(f_curr, '%10.0f', i);
fprintf(f_curr, '%10.0f %10.0f', j, stim_order(j));

if keycode(1,67)
    fprintf(f_curr, '%10.0f \n', -1);
    stim_rating(j) = -1;

elseif keycode(1,86)
    fprintf(f_curr, '%10.0f \n', 0);
    stim_rating(j) = 0;

elseif keycode (1,66)
    fprintf(f_curr, '%10.0f \n', 1);
    stim_rating(j) = 1;

elseif keycode (1,78)
   fprintf(f_curr, '%10.0f \n', 2); 
   stim_rating(j) = 2;

elseif keycode (1,77)
   fprintf(f_curr, '%10.0f \n', 3);
   stim_rating(j) = 3;
else
    fprintf(f_curr, '%10.0f \n', -999);
   stim_rating(j) = -999;
end
end
%now get rid of the negative items in stim_order and store all positive
%ones in the // pos_stims // vector
for test_row= 1:length(stim_order)
    if stim_rating(test_row) < 0
        stim_order(test_row) = 999;
    end    
end
pos_stims = stim_order(stim_order~=999); %pos_stims contains all positively rated stimuli

else 
% for the rest of the trials just show the positively rated items
    for j=1:length(pos_stims)
Screen('FillRect', m_win, [0 0 0]);
Screen(m_win, 'Flip');
WaitSecs(0.5);
cur_im = Screen('MakeTexture', m_win, img_cell{pos_stims(j)});
Screen('DrawTexture', m_win, cur_im);
Screen(m_win, 'Flip');
[secs, keycode] = KbWait([],2,[]);

%stimulus_num = num2str(j);
%food_item_num = num2str(stim_order(j));
fprintf(f_curr, '%10.0f', i);
fprintf(f_curr, '%10.0f %10.0f', j, pos_stims(j));

if keycode(1,67)
    fprintf(f_curr, '%10.0f \n', -1);
    stim_rating(j) = -1;

elseif keycode(1,86)
    fprintf(f_curr, '%10.0f \n', 0);
    stim_rating(j) = 0;

elseif keycode (1,66)
    fprintf(f_curr, '%10.0f \n', 1);
    stim_rating(j) = 1;

elseif keycode (1,78)
   fprintf(f_curr, '%10.0f \n', 2); 
   stim_rating(j) = 2;

elseif keycode (1,77)
   fprintf(f_curr, '%10.0f \n', 3);
   stim_rating(j) = 3;
else
    fprintf(f_curr, '%10.0f \n', 3);
   stim_rating(j) = -999;
end
    end
end

end
Screen('Preference','DefaultFontSize', 22);
DrawFormattedText(m_win, 'You finished task 1, we proceed with task 2' ,'center', 'center', [255 255 255]);
Screen(m_win, 'Flip');
WaitSecs(3);
Screen('FillRect', m_win, [0 0 0]);
Screen(m_win, 'Flip');
WaitSecs(1);

    %%%%%%%%%%%
    %%%Task2%%%
    %%%%%%%%%%%
    
DrawFormattedText(m_win, 'We will now calibrate the EyeTracker' ,'center', 'center', [255 255 255]);
Screen(m_win, 'Flip');
WaitSecs(3);
Screen('CloseAll');

%open file and write first lines of subject data
f_name =['choices\choices_subject_' s_number_str '_session_' session_str '_setsize_' set_size_str '.txt' ];

f_curr = fopen(f_name,'a+t');
fprintf(f_curr, '%53s \n\n', 'Choices  for positive snack items');
fprintf(f_curr, '%20s %3.0f\n','Subject Number: ', s_number);
fprintf(f_curr, '%20s %3.0f\n','Session: ', session);
fprintf(f_curr, '%20s %3.0f\n\n','Set_size: ', set_size);

if set_size == 4
    fprintf(f_curr, '%10s %16s %12s \n','Trial_nr', 'Snacks_shown', 'Snack_picked');
end
if set_size == 6
    fprintf(f_curr, '%10s %24s %12s \n','Trial_nr', 'Snacks_shown', 'Snack_picked');
end
if set_size == 8
    fprintf(f_curr, '%10s %37s %12s \n','Trial_nr', 'Snacks_shown', 'Snack_picked');
end


%initialize choice set cell array
choice_sets = cell(30, set_size);
imgs_shown = zeros(30, set_size);
for i = 1:20
    img_order = pos_stims(randperm(length(pos_stims)));  
    
% I am storing the pic_numbers per trial here into variable imgs_shown
% The actual pictures are stored in choice_sets 
        for j = 1:set_size
        choice_sets(i,j) = img_cell(img_order(j),1);
        imgs_shown(i,j) = img_order(j);
        end    
end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%% NOW WE INITIALIZE THE EYETRACKER %%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



    %%%%%%%%%%
    % STEP 1 %
    %%%%%%%%%%
    
    % I dont know exactly what this dummmode thing does but it has to be
    % here (maybe i can be put exactly before the line where it is used)
    
    dummymode = 0;
    
    % Added a dialog box to set your own EDF file name before opening
    % experiment graphics. Make sure the entered EDF file name is 1 to 8
    % characters in length and only numbers or letters are allowed.
       
% should be enough to name it // BE CAREFUL WITH SUBJECT NAMES AND NUMBERS

    edf_name = [s_number_str '_' session_str '_' set_size_str];
    fprintf('EDFFile: %s\n', edf_name ); %this one might be unnecessary
        
    %%%%%%%%%%
    % STEP 2 %
    %%%%%%%%%%
    
    % DO I NEED THIS? I SHOULD USE MY VERSION OF THIS HERE %
    % Open a graphics window on the main screen
    % using the PsychToolbox's Screen function.
    screenNumber=max(Screen('Screens'));  %% SHOULD THIS BE MAX OF RATHER MIN???
    [m_win, myRect]=Screen('OpenWindow', screenNumber, 0,[],32,2); %#ok<*NASGU>
    Screen(m_win,'BlendFunction',GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    [wW, wH] = Screen('WindowSize',m_win);
    
    %%%%%%%%%%
    % STEP 3 %
    %%%%%%%%%%
    
    % Provide Eyelink with details about the graphics environment
    % and perform some initializations. The information is returned
    % in a structure that also contains useful defaults
    % and control codes (e.g. tracker state bit and Eyelink key values).
    
    % FOR WINDOW I SHOULD USE m_win here!!!
    el=EyelinkInitDefaults(m_win);
    
    %%%%%%%%%%
    % STEP 4 %
    %%%%%%%%%%
    
    % Initialization of the connection with the Eyelink Gazetracker.
    % exit program if this fails.
    if ~EyelinkInit(dummymode)
        fprintf('Eyelink Init aborted.\n');
        cleanup;  % cleanup function
        return;
    end
    
     % open file to record data to
    res = Eyelink('Openfile', edf_name);
    if res~=0
        fprintf('Cannot create EDF file ''%s'' ', edf_name);
        cleanup; %shutdown routine
        return;
    end
    
    Eyelink('command', 'add_file_preamble_text''Recorded by EyelinkToolbox for Choice Set-Size Experiment by Alexander Fengler''');
    
    %%%%%%%%%%
    % STEP 5 %
    %%%%%%%%%%
    
    % SET UP TRACKER CONFIGURATION
    % Setting the proper recording resolution, proper calibration type,
    % as well as the data file content;
    
    % it's location here is overridded by EyelinkDoTracker which resets it
    % with display PC coordinates[wW, wH]
    Eyelink('command','screen_pixel_coords = %ld %ld %ld %ld', 0, 0, wW-1, wH-1);
    Eyelink('message', 'DISPLAY_COORDS %ld %ld %ld %ld', 0, 0, wW-1, wH-1);
    % set calibration type.
    Eyelink('command', 'calibration_type = HV5');
    
    % set EDF file contents
    % STEP 5.2 retrieve tracker version and tracker software version
    [~,vs] = Eyelink('GetTrackerVersion');
    
    if vs >=4 
        Eyelink('command', 'file_sample_data  = LEFT,RIGHT,GAZE,HREF,AREA,HTARGET,GAZERES,STATUS,INPUT');
        Eyelink('command', 'link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA,HTARGET,STATUS,INPUT');       
    else
        Eyelink('command', 'file_sample_data  = LEFT,RIGHT,GAZE,HREF,AREA,GAZERES,STATUS,INPUT');
        Eyelink('command', 'link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA,STATUS,INPUT');
    end
    
    
    % allow to use the big button on the eyelink gamepad to accept the 
    % calibration/drift correction target
    Eyelink('command', 'button_function 5 "accept_target_fixation"');
    
    % make sure we're still connected.
     if Eyelink('IsConnected')~=1 && dummymode == 0
         fprintf('not connected, clean up\n');
         cleanup;
         return;
     end
     
    % setup the proper calibration foreground and background colors
    el.backgroundcolour = [0 0 0];    
    el.calibrationtargetcolour = [255 255 255];
    % you must call this function to apply the changes from above
    EyelinkUpdateDefaults(el);
    
    % enter Eyetracker camera setup mode, calibration and validation
    EyelinkDoTrackerSetup(el);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%% END OF EYETRACKER PREPARATION %%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %%%%% SOME OTHER INITIALIZATIONS UNTIL FINALLY TRIALS START %%%%%

%initialize picture positions (we go for picture size 266-200)
%the average distance between all possible item pairs on the screen is
%equal across all set_sizes (Average distance chosen = 444.23 pixels)

if set_size == 4
    
    %we identify the center coordinates of every item (from average
    %distance = 444.23, it follows delta-x = 195 (rounded), delta-y = 195 (rounded), 
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


    %now open screen for main task
Screen('FillRect', m_win, [0 0 0]);
Screen(m_win,'Flip');

% start of task2 message
DrawFormattedText(m_win, 'Please focus on the fixation cross to start!' ,'center', 'center', [255 255 255]);
Screen(m_win, 'Flip');
WaitSecs(3);
Screen('FillRect', m_win, [0 0 0]);
Screen(m_win, 'Flip');
WaitSecs(1);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%% START TRIALS OF TASK 2 %%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %initialize image cell for current choice sets
cur_im = cell(set_size, 1); 
    %start trials
    
for i = 1:20
    HideCursor;
    
    
    %stare at fixation screen
        Eyelink('Message', 'TRIALID fixation before %d', i);
        Eyelink('StartRecording');
        eye_used = Eyelink('EyeAvailable'); % get eye that's tracked  
    
        %draw fixation cross
        Screen('Preference','DefaultFontSize', 80);
        DrawFormattedText(m_win, '+' ,'center', 'center', [255 255 255]);
        Screen(m_win,'Flip');
        Screen('Preference','DefaultFontSize', 22);
    
        %make sure you stare at fixation screen for 500ms
        secsOnFix = 0;
        x_fix=0; y_fix=0;
        StartSecs = GetSecs;
        static_StartSecs = GetSecs; %this is defined to go stay and is not update in the while loop to allow for fallback to calibration
        while secsOnFix < 1 
              if Eyelink( 'NewFloatSampleAvailable') > 0 && GetSecs <= static_StartSecs + 30
                        % get the sample in the form of an event structure
                        evt = Eyelink( 'NewestFloatSample');
                        evt.gx;
                        evt.gy;

                            x = evt.gx(eye_used+1); % +1 as we're accessing MATLAB array
                            y = evt.gy(eye_used+1);
                            % do we have valid data and is the pupil visible?
                            if x~=el.MISSING_DATA && y~=el.MISSING_DATA && evt.pa(eye_used+1)>0
                                x_fix=x;
                                y_fix=y;
                            end
              end
              
              if (x_fix > c_x-100 &&  x_fix < c_x+100 && y_fix > c_y-100 && y_fix < c_y+100)
                    secsOnFix =  GetSecs - StartSecs;
                else
                  secsOnFix = 0;
                  StartSecs = GetSecs;
              end
              if GetSecs >= static_StartSecs + 30
                  Eyelink('Message', 'FAILURE in TRIALID fixation before %d', i);
                  Eyelink('StopRecording');
                  EyelinkDoTrackerSetup(el);
                  Eyelink('Message', 'RESTART TRIALID fixation before %d', i);
                  static_StartSecs = GetSecs;
                  Eyelink('StartRecording');
                  DrawFormattedText(m_win, '+' ,'center', 'center', [255 255 255]);
                  Screen(m_win,'Flip');
                  StartSecs = GetSecs;
              end
        end
        Eyelink('StopRecording');
        %End of fixation cross     
    %load new choice set
    for j = 1:set_size
cur_im{j} = Screen('MakeTexture', m_win, choice_sets{i,j});
Screen('DrawTextures', m_win, cur_im{j}, [], dest_pics(j,:));
    end
    
    %set up eyetracker for recording trial
     Eyelink('Message', 'TRIALID %d', i);
        Eyelink('StartRecording');
        eye_used = Eyelink('EyeAvailable'); % get eye that's tracked
    
Screen(m_win, 'Flip');


%until Keyboard is pressed we will record and importantly collect the
%location of gaze data 

while KbCheck == 0    
end
Eyelink('StopRecording');     
oldType = ShowCursor();
SetMouse(c_x,c_y);
[m_x, m_y, m_button] = GetMouse;
while any(m_button)
    [m_x, m_y, m_button] = GetMouse;
end
while ~any(m_button)
    [m_x, m_y, m_button] = GetMouse;
end
while any(m_button)
    [m_x, m_y, m_button] = GetMouse;
end

%write trial_nr to file
fprintf(f_curr, '%10.0f', i);

%mouse position test to write item-choice and all other trial data to file
 
% four items taking relevant dest_pics matrix
if set_size == 4
    %write image vector to file // image_nr corresponds to filename of img
    for q = 1:4
        fprintf(f_curr, '%4.0f %s', imgs_shown(i,q), ' ');
    end
if m_y > dest_pics(1,2) && m_y < dest_pics (1,4)
    if m_x > dest_pics(1,1) && m_x < dest_pics(1,3) %item 1
        fprintf(f_curr, '%12.0f \n', 1); 
    end
    if m_x > dest_pics(2,1) && m_x < dest_pics(2,3) %item 2
        fprintf(f_curr, '%12.0f \n', 2); 
    end
 
elseif m_y > dest_pics(3,2) && m_y < dest_pics (3,4)
    if m_x > dest_pics(3,1) && m_x < dest_pics(3,3) %item 3
       fprintf(f_curr, '%12.0f \n', 3); 
    end
    if m_x > dest_pics(4,1) && m_x < dest_pics(4,3) %item 4
       fprintf(f_curr, '%12.0f \n', 4); 
    end
else 
       fprintf(f_curr, '%12.0f \n', 999);
end
end

% six items taking televant dest_pics matrix
if set_size == 6
    %write image vector to file // image_nr corresponds to filename of img
    for q = 1:6
        fprintf(f_curr, '%4.0f %s', imgs_shown(i,q), ' ');
    end
if m_y > dest_pics(1,2) && m_y < dest_pics(1,4)
    if m_x > dest_pics(1,1) && m_x < dest_pics(1,3) %item 1
        fprintf(f_curr, '%12.0f \n', 1);
    end
    if m_x > dest_pics(2,1) && m_x < dest_pics(2,3) %item 2
        fprintf(f_curr, '%12.0f \n', 2);
    end
    if m_x > dest_pics(3,1) && m_x < dest_pics(3,3) %item 3
        fprintf(f_curr, '%12.0f \n', 3);
    end
elseif m_y > dest_pics(4,2) && m_y < dest_pics(4,4)
    if m_x > dest_pics(4,1) && m_x < dest_pics(4,3) %item 4
        fprintf(f_curr, '%12.0f \n', 4);
    end
    if m_x > dest_pics(5,1) && m_x < dest_pics(5,3) %item 5
        fprintf(f_curr, '%12.0f \n', 5);
    end
    if m_x > dest_pics(6,1) && m_x < dest_pics(6,3) %item 6
        fprintf(f_curr, '%12.0f \n', 6);
    end
else  
    fprintf(f_curr, '%12.0f \n', 999);
end
end

%eight items taking relevant dest_pics matrix 
if set_size == 8
    %write image vector to file // image_nr corresponds to filename of img
    for q = 1:8
        fprintf(f_curr, '%4.0f %s', imgs_shown(i,q), ' ');
    end
if m_y > dest_pics(1,2) && m_y < dest_pics(1,4)
    if m_x > dest_pics(1,1) && m_x < dest_pics(1,3) %item 1
        fprintf(f_curr, '%12.0f \n', 1);
    end
    if m_x > dest_pics(2,1) && m_x < dest_pics(2,3) %item 2
        fprintf(f_curr, '%12.0f \n', 2);
    end
    if m_x > dest_pics(3,1) && m_x < dest_pics(3,3) %item 3
        fprintf(f_curr, '%12.0f \n', 3);
    end
    if m_x > dest_pics(4,1) && m_x < dest_pics(4,3) %item 4
        fprintf(f_curr, '%12.0f \n', 4);
    end
elseif m_y > dest_pics(5,2) && m_y < dest_pics(5,4)
    if m_x > dest_pics(5,1) && m_x < dest_pics(5,3) %item 5
        fprintf(f_curr, '%12.0f \n', 5);
    end
    if m_x > dest_pics(6,1) && m_x < dest_pics(6,3) %item 6
        fprintf(f_curr, '%12.0f \n', 6);
    end
    if m_x > dest_pics(7,1) && m_x < dest_pics(7,3) %item 7
        fprintf(f_curr, '%12.0f \n', 7);
    end
    if m_x > dest_pics(8,1) && m_x < dest_pics(8,3) %item 8
        fprintf(f_curr, '%12.0f \n', 8);
    end
else
    fprintf(f_curr, '%12.0f \n', 999);
end
end
%end of mouse position testing
Screen('FillRect', m_win, [0 0 0]);
Screen(m_win,'Flip');
WaitSecs(0.5);

end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % STEP 8 % We deinitialize the EYETRACKER here %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % End of Experiment; close the file first   
    % close graphics window, close data file and shut down tracker
        
    Eyelink('Command', 'set_idle_mode');
    WaitSecs(0.5);
    Eyelink('CloseFile');

    % download data file
    try
        fprintf('Receiving data file ''%s''\n', edf_name );
        status=Eyelink('ReceiveFile');
        if status > 0
            fprintf('ReceiveFile status %d\n', status);
        end
        if 2==exist(edf_name, 'file')
            fprintf('Data file ''%s'' can be found in ''%s''\n', edf_name, 'choices\' );
        end
    catch
        fprintf('Problem receiving data file ''%s''\n', edf_name );
    end
cleanup;
function cleanup
% Shutdown Eyelink:        
        Eyelink('Shutdown');
        Screen('CloseAll');
end
fclose('all');
end