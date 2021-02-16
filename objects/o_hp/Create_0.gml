movement = {
	horizontalSpeedDecimal: 0,
	horizontalSpeedInitial: random_range(2, 5) * choose(-1, 1),
	verticalSpeedDecimal: 0,
	verticalSpeedInitial: random_range(-6, -3),
};

movement.horizontalSpeed = movement.horizontalSpeedInitial;
movement.verticalSpeed = movement.verticalSpeedInitial;

drag = 0.05;

die = false;

// pick color
image_index = irandom(image_number - 1);

hasBounced = false; // has bounce happened
canPickup = false; // can it pickup yet, we want it after bouncing

// enable light
var inst = instance_create_layer(x, y, "Light", o_light);
light_id = inst.id;
inst.type = 5;
