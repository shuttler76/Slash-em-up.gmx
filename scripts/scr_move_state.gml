///scr_move_state

var rkey = keyboard_check(ord('D'));
var lkey = keyboard_check(ord('A'));
var jkey = keyboard_check_pressed(ord('W'));
var skey = mouse_check_button_pressed(mb_left);
var akey = mouse_check_button_pressed(mb_right);
var gkey = keyboard_check_pressed(ord('C'));



//moving right
if (rkey) {
    hspd = spd;
    image_xscale = 1;
    image_speed = 0.3; 
}

//moving left
if (lkey) {
    hspd = -spd;
    image_xscale = -1;
    image_speed = 0.3;
}

//attack

if (akey) {
    scr_attack();
}

if (skey) {
    state = scr_whirlwind_state;
    image_index = 0;
    audio = false;
    whirl = 30;
}


scr_process_movement();


//check for ground
if (grounded) {
    //check for not moving
    if ((!rkey && !lkey) || (rkey && lkey) || hspd = 0) {
        hspd=0;
        if (vspd = 0) {
            sprite_index = spr_playeridle;
            image_speed = 0.1;
        }
    } else {
        sprite_index = spr_playerwalk;
    }
    airjump = 1;
    vspd = 0;
    
    mask_index = spr_playeridle;
    //jumping
    if (jkey) {
        vspd = -jspd;
        audio_play_sound(jump,1,false);
    }
} else {
    if (jkey) {
        // left wall jump
        if (place_meeting(x-1,y,obj_solid) && !lkey) {
            vspd = -jspd;
            hspd = spd;
            image_xscale = 1;
        }
        // right wall jump
        else if (place_meeting(x+1,y,obj_solid) && !rkey) {
            vspd = -jspd;
            hspd = -spd;
            image_xscale = -1;
        }
        //check for airjump
         else if (airjump > 0) {
        
            audio_play_sound(jump,1,false);
            vspd = -jspd;
            airjump -= 1;
            mask_index = spr_player_jump_flip;
        }
    }
}

//jump animation
if (!grounded) {
    image_speed = 0.4;
    if (airjump = 0) {
        sprite_index = spr_player_jump_flip;     
    } else {
        mask_index = spr_playeridle;
        if (vspd <= 0) {
            sprite_index = spr_player_jump;
        } else {
            if (vspd > 0) sprite_index = spr_player_fall;
        }
    }
}
if (hspd != 0) {
    hspd_dir = sign(hspd);
}

var half_w = abs(bbox_right - bbox_left)/2+1;
var was_free = !position_meeting(x+(4*hspd_dir), yprevious-4, obj_solid);
var is_not_free = position_meeting(x+(4*hspd_dir), y-4, obj_solid);
var moving_down = yprevious < y;

if (was_free && is_not_free && moving_down) {
    hspd = 0;
    vspd = 0;
    mask_index = spr_playeridle;
    state = scr_ledge_grab_state;
    // Move against the ledge
    while (!place_meeting(x+(hspd_dir), y, obj_solid)) {
        x+=hspd_dir;
    }
    
    // Make sure we are the right height
    while (position_meeting(x+(4*hspd_dir),y-5,obj_solid)) {
        y-=1;
    }
}

// Wall Stab

if (place_meeting(x,y,obj_stabable) and gkey) {
    state = scr_wall_stab_state;
}
