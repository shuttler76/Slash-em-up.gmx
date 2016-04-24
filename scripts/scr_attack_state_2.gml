///scr_attack_state_2()
image_speed = 1.5;

//create effect
if hspd != 0 {
    var dash = instance_create(x,y,obj_dash_effect);
    dash.sprite_index = sprite_index;
    dash.image_index = image_index;
    dash.image_xscale = image_xscale;
}

if (!audio) {
    audio_play_sound(slash, 0, false);
    audio = true;
}

if hspd != 0 {
    hspd/=2;
}

//control sprite
if hspd < 0 {
    image_xscale=-1;
}
if hspd > 0 {
    image_xscale=1;
}
sprite_index=spr_player_attack_2;

if (image_index) < 1 {
    attacked = false;
}

scr_process_movement();

if (image_index >= 2 && attacked = false) {
    var damage = instance_create(x,y,obj_damage);
    damage.creator = id;
    attacked = true;
}
