///scr_attack_state_air()
image_speed = 0.8;

if (!audio && state = scr_attack_state_air) {
    audio_play_sound(slash, 0, false);
    audio = true;
}

if hspd > 0 {
    hspd = spd;
}

if hspd < 0 {
    hspd = -spd;
}

if (place_meeting(x,y+1,obj_solid)) {
    sprite_index = spr_attack_air_land;
} else {
    sprite_index = spr_player_attack_air;
}

//horizontal collisions
if (place_meeting(x+hspd,y,obj_solid)) {
    while (!place_meeting(x+sign(hspd),y,obj_solid)) {
        x += sign(hspd);
    }
    hspd = 0;
}

//move horizontally
if vspd != 0 x += hspd;

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

if (image_index >= 2 && attacked = false) {
    var damage = instance_create(x,y,obj_damage);
    damage.creator = id;
    attacked = true;
}
