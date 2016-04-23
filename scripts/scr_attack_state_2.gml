///scr_attack_state_2()
image_speed = 0.8;

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
    sprite_index = spr_player_attack_2;
}

//control sprite
if hspd < 0 {
    image_xscale=-1;
}
if hspd > 0 {
    image_xscale=1;
}
sprite_index=spr_player_attack_2;

//horizontal collisions
if (place_meeting(x+hspd,y,obj_solid)) {
    while (!place_meeting(x+sign(hspd),y,obj_solid)) {
        x += sign(hspd);
    }
    hspd = 0;
}

//move horizontally
x += hspd;

if (image_index) < 1 {
    attacked = false;
}

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
