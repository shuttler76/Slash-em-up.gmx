//Gravity
if (vspd < 10) {
    vspd += grav;
}

// Collisions start

//horizontal collisions=
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
        y += sign(vspd)
    } 
    grounded = (sign(vspd) == 1);
    vspd = 0;
} else {
    grounded = false;
}

//move vertically
y += vspd;

// Collisions end
