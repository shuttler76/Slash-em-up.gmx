///scr_move_state

var rkey = keyboard_check(ord('D'));
var lkey = keyboard_check(ord('A'));
var jkey = keyboard_check_pressed(ord('W'));
var akey = mouse_check_button_pressed(mb_left);
var skey = mouse_check_button_pressed(mb_right);
var gkey = keyboard_check_pressed(ord('C'));

//check for ground
if (place_meeting(x,y+1,obj_solid)) {
    airjump = 1;
    vspd = 0;
    
    //jumping
    if (jkey) {
        vspd = -jspd;
        audio_play_sound(jump,1,false);
    }
} else {
    //Gravity
    if (vspd < 10) {
        vspd += grav;
    }
    
    //check for airjump
    if (airjump > 0) {
        if (jkey) {
            audio_play_sound(jump,1,false);
            vspd = -jspd;
            airjump -= 1;
        }
    }
}

//moving right
if (rkey) {
    hspd = spd;
    image_xscale = 1;
    image_speed = 0.3; 
    
    // left wall jump
    if (place_meeting(x-3,y,obj_solid) && !place_meeting(x,y+1,obj_solid) && !lkey)
        vspd = -jspd;
}

//moving left
if (lkey) {
    hspd = -spd;
    image_xscale = -1;
    image_speed = 0.3;
    
    // right wall jump
    if (place_meeting(x+1,y,obj_solid) && !place_meeting(x,y+1,obj_solid) && !rkey)
        vspd = -jspd;
}

//attack
if (akey) {
    if (place_meeting(x,y+1,obj_solid)) {
        state = scr_attack_state;
    } else {
        state = scr_attack_state_air;
    }
    if instance_exists(obj_enemy) {
        enemy = instance_nearest(x,y,obj_enemy);
        image_index = 0;
        audio = false;
        if (hspd != 0 and y==enemy.y) {
            hspd = lengthdir_x(x-enemy.x, 180)/2;
        } else {
             if (state = scr_attack_state_air) {
                if hspd < 0 {
                    hspd = -spd;
                }
                if hspd > 0 {
                    hspd = spd;
                }
            } else {
                if hspd < 0 {
                    hspd = -spd*8;
                }
                if hspd > 0 {
                    hspd = spd*8;
                }
            }
        }
    } else {
        if (place_meeting(x,y+1,obj_solid)) {
            state = scr_attack_state;
        } else {
            state = scr_attack_state_air;
        }
        image_index = 0;
        audio = false;
        if (state = scr_attack_state_air) {
            if hspd < 0 {
                hspd = -spd;
            }
            if hspd > 0 {
                hspd = spd;
            }
        } else {
            if hspd < 0 {
                hspd = -spd*8;
            }
            if hspd > 0 {
                hspd = spd*8;
            }
        }
    }
}

if (skey) {
    state = scr_whirlwind_state;
    image_index = 0;
    audio = false;
    whirl = 30;
}

//check for not moving
if ((!rkey && !lkey) || (rkey && lkey)) {
    hspd=0;
    if (vspd = 0) {
        sprite_index = spr_playeridle;
        image_speed = 0.1;
    }
} else {
    sprite_index = spr_playerwalk;
}

//jump animation
if (!place_meeting(x,y+1,obj_solid)) {
    image_speed = 0.4;
    if (airjump = 0) {
        sprite_index = spr_player_jump_flip;     
    } else {
        if (vspd <= 0) {
            sprite_index = spr_player_jump;
        } else {
            if (vspd > 0) sprite_index = spr_player_fall;
        }
    }
}

// Collisions start
if (hspd != 0) {
    hspd_dir = sign(hspd);
}

//horizontal collisions
if (place_meeting(x+hspd,y,obj_solid)) {
    while (!place_meeting(x+sign(hspd),y,obj_solid)) {
        x += sign(hspd);
    }
    hspd = 0;
}

//move horizontally
x += hspd;

//vertical collisions
if (place_meeting(x,y+vspd,obj_solid)) {
    while (!place_meeting(x,y+sign(vspd),obj_solid)) {
        y += sign(vspd);
    }
    vspd = 0;
}

//move vertically
y += vspd;

// Collisions end
var was_free = !position_meeting(x+(4*hspd_dir), yprevious-4, obj_solid);
var is_not_free = position_meeting(x+(4*hspd_dir), y-4, obj_solid);
var moving_down = yprevious < y;

if (was_free && is_not_free && moving_down) {
    hspd = 0;
    vspd = 0;
    
    // Move against the ledge
    while (!place_meeting(x+hspd_dir, y, obj_solid)) {
        x+=hspd_dir;
    }
    
    // Make sure we are the right height
    while (position_meeting(x+(4*hspd_dir),y-5,obj_solid)) {
        y-=1;
    }
    
    state = scr_ledge_grab_state;
}

// Wall Stab

if (place_meeting(x,y,obj_stabable) and gkey) {
    state = scr_wall_stab_state;
}
