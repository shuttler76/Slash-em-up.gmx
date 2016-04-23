///scr_wall_stab_state()
var jkey = keyboard_check_pressed(ord('W'));
var dkey = keyboard_check_pressed(ord('S'));

sprite_index = spr_player_wall_stab;

if (jkey) {
    vspd = -jspd;
    state = scr_move_state;
}

if (dkey) {
    state = scr_move_state;
}
