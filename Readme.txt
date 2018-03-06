To run:

Make sure to include the flows.mat file before running as this is not included in the submission to to its' size.

################# Basic Section #################

Run labs6('path/to/images/', 'image_prefix', 'first_frame', 'last_frame', 'digits_in_frame_number', 'image_suffix'), for example:
 - labs6('gjbLookAtTargets', 'gjbLookAtTarget_00', 0, 71, 2, 'jpg');

When prompted, enter the starting image and following this, the number of look at points.

The starting image will be shown and you will be asked to select the starting point in the image as well as the look at points. 

Once the path has been computed, the path comparison will be shown drawn onto the starting image as well as the output image sequence.

The output_seq folder contains an example output image sequence that corresponds to the path drawn in the report. Therefore, the 'save_sequence' function has been commented out in the code.

################# Advanced Section - Slow Motion #################

Function call is similar to basic section, apart from the extra last parameter, where the user can specify the number of intermediate frames that are added for the slow motion. The value used for the example output is 4. 

Run labs6_slowmo('path/to/images/', 'image_prefix', 'first_frame', 'last_frame', 'digits_in_frame_number', 'image_suffix', 'n_interm_frames'), for example:
 - labs6('gjbLookAtTargets', 'gjbLookAtTarget_00', 0, 71, 2, 'jpg',4);

The rest is the same as I the basic section.

The output_slowmo folder contains an example output sequence that corresponds to the same path as used in the example in the basic section.

