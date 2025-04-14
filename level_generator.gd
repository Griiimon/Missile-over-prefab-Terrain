extends Node2D

# add all your terrain prefab scenes through the inspector
@export var prefabs: Array[PackedScene]
# they must have a fixed pixel width
@export var prefab_pixel_width: int= 1000

# drag and drop your player/rocket node in the inspector so
# we know how far we have to update the level 
@export var viewer_node: Node2D

# same seed will result in same level
@export var world_seed: int= 0

@export var terrain_y_offset: int= 500

var rng: RandomNumberGenerator

# keep track of the number of spawned chunks
var num_spawned_terrain_chunks: int= 0



func _ready() -> void:
	rng= RandomNumberGenerator.new()
	rng.seed= world_seed


func _process(delta: float) -> void:
	update_level()


func update_level():
	# we want to generate terrain at least 2 prefab lengths ahead of the viewer
	var min_chunks_x: int= viewer_node.global_position.x + prefab_pixel_width * 2
	while min_chunks_x > num_spawned_terrain_chunks * prefab_pixel_width:
		spawn_random_chunk()


func spawn_random_chunk():
	# choose random prefab scene from the array
	var random_scene: PackedScene= prefabs[wrapi(rng.randi(), 0, prefabs.size())]
	var chunk: Node2D= random_scene.instantiate()
	
	# add it right next to last spawned chunk
	chunk.position.x= num_spawned_terrain_chunks * prefab_pixel_width
	chunk.position.y= terrain_y_offset
	
	add_child(chunk)
	num_spawned_terrain_chunks+= 1
