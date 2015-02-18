# ExperimentDesign_MultiItemChoice
An experiment that lets the participant take decisions over differing amount of items on the screen, which have been rated before. Coded with the help of Psychtoolbox. Ready for eyetracking (Eyelink).

## What does the experiment do?
Three main functions *liking_choices()*, *liking_choices_no_eyetracking()*, and *liking_choices_training()* do the following.

1. Read in set of images (currently from the *pos_food_numbered*, *pos_food_numbered_training* folders)
2. Show these images as a liking rating task where the subject indicates how much he/she likes the given item (each item is shown two times)
3. Extract the items that were on average rated above zero
4. Show these items in a choice task (with or without *Eyetracking*) where the subject runs through 300 trials and decides over a specified number of items (pictures are presented at random).

The training function is different only in that it accesses a different set of items and presents less (currently 15 trials).

## Eyetracking
The main function *liking_choices()* is set up to work with eyetracking right out of the box. (Eyelink Eyetracker)
An *.edf* file that indicates the subject, set size and session number is created and send to the host pc at the end of the experiment.

## To do:

- [ ] Read in files more flexibly (utilize regexp)
- [ ] Make task item general (compute item positions for each set size given a max set size
- [ ] Only one function for training, with and without eyetracking
- [ ] Make background white 







