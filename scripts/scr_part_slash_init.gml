///scr_part_blood_init

// initialize gloabl blood particle
global.pt_slash = part_type_create();
var pt = global.pt_slash;

// set the settings
part_type_sprite(pt,spr_slash,true,false,false);
part_type_life(pt,6,6);
part_type_direction(pt,0,360,0,0);
