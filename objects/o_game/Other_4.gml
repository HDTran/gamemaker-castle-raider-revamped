/// @description Set Collisions layer
global.map = layer_tilemap_get_id("Collisions");

// player create
if (room != rm_init && room != rm_menu && (!instance_exists(o_player))) {
	instance_create_layer(x, y, "Player", o_player);
}
