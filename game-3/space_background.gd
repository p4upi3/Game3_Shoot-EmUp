extends ParallaxBackground

@onready var space_layer: ParallaxLayer = %SpaceLayer
@onready var far_starslayer: ParallaxLayer = %FarStarslayer
@onready var close_stars_layer: ParallaxLayer = %CloseStarsLayer

func _process(delta: float) -> void:
	close_stars_layer.motion_offset.y += 20 * delta
	space_layer.motion_offset.y += 2 * delta
	far_starslayer.motion_offset.y += 5 * delta
