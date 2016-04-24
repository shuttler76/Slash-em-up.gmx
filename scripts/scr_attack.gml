///scr_attack()
var boost = 1;
if (place_meeting(x,y+1,obj_solid)) {
    state = scr_attack_state;
    boost = 7;
} else {
    state = scr_attack_state_air;
}
image_index = 0;
audio = false;

if instance_exists(obj_enemy) {
    enemy = instance_nearest(x,y,obj_enemy);
    if (hspd != 0 and y==enemy.y) {
        hspd = lengthdir_x(x-enemy.x, 180)/2;
        return 0;
    }
}

if hspd < 0 {
    hspd = -spd*boost;
}
if hspd > 0 {
    hspd = spd*boost;
}

