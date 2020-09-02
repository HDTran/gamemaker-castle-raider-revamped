/// @description Move dust toward player and fade
// move dust toward player
x = lerp(x, o_player.x, 0.003);

// fade dust
image_alpha -= fade;