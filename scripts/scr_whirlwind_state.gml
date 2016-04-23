///scr_whirlwind_state()

var rkey = keyboard_check(ord('D'));
var lkey = keyboard_check(ord('A'));

image_speed = 0.6;

if (!audio && state = scr_attack_state) {
    audio_play_sound(slash, 0, false);
    audio = true;
}

sprite_index = spr_player_whirl;

if (rkey) {
    hspd = spd;
    image_xscale = 1;
}

//moving left
if (lkey) {
    hspd = -spd;
    image_xscale = -1;
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

if (!place_meeting(x,y+1,obj_solid)) {
    if (vspd < 10) {
        vspd += grav;
    }
}

if (place_meeting(x,y+vspd,obj_solid)) {
    while (!place_meeting(x,y+sign(vspd),obj_solid)) {
        y += sign(vspd);
    }
    vspd = 0;
}

y += vspd;

if (whirl%4 = 0) {
    var damage = instance_create(x,y,obj_damage);
    damage.creator = id;
}

if (whirl = 0) {
    if (place_meeting(x,y+1,obj_solid)) { 
        state = scr_move_state;
    } else {
        whirl = 30;
    }
} else {
    whirl -= 1;
}
