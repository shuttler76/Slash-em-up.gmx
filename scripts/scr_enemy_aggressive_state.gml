///scr_enemy_aggressive_state

var xspd = sign(obj_player.x - x)*spd;

if (!place_meeting(x+xspd,y,obj_player) and !place_meeting(x+xspd, y, obj_solid)) x += xspd;
//    is not colliding with player             is not colliding with a wall  

//setting xscale
if xspd < 0 image_xscale = 1; 
if xspd > 0 image_xscale = -1;

//applying gravity
if (!place_meeting(x,y+1,obj_solid)){
    vspd+=1;
} else {
    vspd = 0;
}

//colliding vertically
if (place_meeting(x,y+vspd,obj_solid)) {
    while (!place_meeting(x,y+sign(vspd),obj_solid)) {
        y += sign(vspd);
    }
    vspd = 0;
}

y+=vspd;
