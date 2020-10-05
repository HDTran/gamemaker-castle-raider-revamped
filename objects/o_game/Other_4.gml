/// @description Set Collisions layer
global.map = layer_tilemap_get_id("Collisions");

// player create
if (!instance_exists(o_player)) {
	instance_create_layer(x, y, "Player", o_player);
}
