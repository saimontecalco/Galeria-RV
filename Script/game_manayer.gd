extends Node
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var coins = get_tree().get_nodes_in_group("Colletion")
	for coin in coins:
		coin.coinColleted.connect(_on_coinColleted)

func _on_coinColleted():
	audio_stream_player_3d.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
