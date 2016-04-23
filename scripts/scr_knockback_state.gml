///scr_knockback

if (place_meeting(x+xforce,y,obj_solid)) {
    while (!place_meeting(x+sign(xforce),y,obj_solid)) {
        x += sign(xforce);
    }
    xforce = 0;
}

x += xforce;
xforce -= sign(xforce);

if xforce = 0 and object_get_parent(id.object_index) == obj_enemy {
    state = scr_enemy_aggressive_state;
}

if xforce = 0 and id.object_index = obj_player {
    state = scr_move_state;
}

//check for ground
if (!place_meeting(x,y+1,obj_solid)){
    vspd+=1;
} else {
    vspd = 0;
}

//vertical collisions
if (place_meeting(x,y+vspd,obj_solid)) {
    while (!place_meeting(x,y+sign(vspd),obj_solid)) {
        y += sign(vspd);
    }
    vspd = 0;
}

y+=vspd;
