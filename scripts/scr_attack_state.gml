///scr_attack_state()
image_speed = 2;

//create effect
if hspd != 0 {
    var dash = instance_create(x,y,obj_dash_effect);
    dash.sprite_index = sprite_index;
    dash.image_index = image_index;
    dash.image_xscale = image_xscale;
}

if (!audio && state = scr_attack_state) {
    audio_play_sound(slash, 0, false);
    audio = true;
}

if hspd != 0 {
    hspd/=2;
}

scr_process_movement();

//control sprite
if hspd < 0 {
    image_xscale=-1;
}
if hspd > 0 {
    image_xscale=1;
}
sprite_index=spr_player_attack;



//create the hitbox
if (image_index >= 2 && attacked = false) {
    var damage = instance_create(x,y,obj_damage);
    damage.creator = id;
    attacked = true;
}

//switch to second attack state
if (image_index > 5 && mouse_check_button_pressed(mb_left)){
    state = scr_attack_state_2;
    image_index = 0;
    audio = false;
    if instance_exists(obj_enemy) {
        enemy = instance_nearest(x,y,obj_enemy);
        if (keyboard_check(ord('A')) or keyboard_check(ord('D'))) and y == enemy.y {
            hspd = lengthdir_x(x-enemy.x, 180)/2;
            return 0;
        }
    }
    if keyboard_check(ord('A')) {
        hspd = -spd*8;
    }
    if keyboard_check(ord('D')) {
        hspd = spd*8;
    }
}

