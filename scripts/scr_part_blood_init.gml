///scr_part_blood_init

// initialize gloabl blood particle
global.pt_blood = part_type_create();
var pt = global.pt_blood;

// set the settings
part_type_shape(pt, pt_shape_square);
part_type_size(pt,.05,.1,0,0);
part_type_color1(pt,c_purple);
part_type_alpha2(pt,2,0)
part_type_speed(pt,2,5,-0.1,0);
part_type_direction(pt,0,360,0,0);
part_type_gravity(pt,.5,270);
part_type_life(pt,25,50);
