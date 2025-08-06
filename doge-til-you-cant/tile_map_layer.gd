extends TileMap

# === SETTINGS ===
@export var scroll_speed: float = 100.0   # Speed the map scrolls (pixels/sec)
@export var tile_size: int = 16           # Width of one tile (your tiles are 16x16)
@export var map_width: int = 20           # Number of tiles horizontally in the tilemap

# Internal tracker for smooth scrolling
var scroll_offset: float = 0.0

func _process(delta: float) -> void:
	scroll_offset += scroll_speed * delta

	# When we've scrolled a full tile, shift all tiles left
	if scroll_offset >= tile_size:
		scroll_offset -= tile_size
		shift_tiles_left()

	# Visually move the tilemap (smooth motion)
	position.x = -scroll_offset


func shift_tiles_left() -> void:
	var used_rect = get_used_rect()

	# Shift all tiles left by copying each tile to its neighbor
	for y in used_rect.size.y:
		for x in range(1, map_width):
			var source_pos = Vector2i(x, y)
			var target_pos = Vector2i(x - 1, y)

			var current_tile = get_cell_source_id(0, source_pos)
			var current_atlas = get_cell_atlas_coords(0, source_pos)
			var current_alternative = get_cell_alternative_tile(0, source_pos)

			set_cell(0, target_pos, current_tile, current_atlas, current_alternative)

	# Add a new tile on the far right
	for y in used_rect.size.y:
		var pos = Vector2i(map_width - 1, y)
		set_cell(0, pos, choose_random_tile())


func choose_random_tile() -> int:
	# Replace with logic to return random tile IDs if needed
	# For now, returns the first tile (usually ID 0)
	return 0
