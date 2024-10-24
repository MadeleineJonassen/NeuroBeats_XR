extends Node3D
class_name Game

const GameParam = Radio.GameParam
var game_params: Dictionary = {
	GameParam.BPM: 110,
	GameParam.SONG_SPEED: 1,
	GameParam.BEAT_TEMPO: 1,
	GameParam.NOTE_SPEED: 4,
	GameParam.SPAWN_DISTANCE: 8,
}

@onready var note_spawner: NoteSpawner = $NoteSpawner
@onready var game_timer: Timer = $GameTimer
@onready var music_player: AudioStreamPlayer = $MusicPlayer


func _ready() -> void:
	Radio.start.connect(start)
	Radio.stop.connect(stop)
	Radio.update_game_param.connect(update_game_param)


func start() -> void:
	var bpm = game_params[GameParam.BPM]
	var song_speed = game_params[GameParam.SONG_SPEED]
	var beat_tempo = game_params[GameParam.BEAT_TEMPO]
	game_timer.wait_time = (60.0 * 2**(4 - beat_tempo)) / (bpm * song_speed)
	music_player.pitch_scale = song_speed
	
	game_timer.start()
	music_player.play()
	note_spawner.setup(game_params)


func stop() -> void:
	game_timer.stop()
	music_player.stop()


func _on_game_timer_timeout() -> void:
	note_spawner.spawn()


func update_game_param(game_param: GameParam, value) -> void:
	game_params[game_param] = value
