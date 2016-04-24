///scr_attack_state_air()
image_speed = 0.8;

if (!audio && state = scr_attack_state_air) {
    audio_play_sound(slash, 0, false);
    audio = true;
}

hspd = spd * sign(hspd);

if (place_meeting(x,y+1,obj_solid)) {
    sprite_index = spr_attack_air_land;
} else {
    sprite_index = spr_player_attack_air;
}


scr_process_movement();

//move horizontally
if (vspd == 0) x -= hspd;

if (image_index >= 2 && attacked = false) {
    var damage = instance_create(x,y,obj_damage);
    damage.creator = id;
    attacked = true;
}
