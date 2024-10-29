extends Node

const HitType = Enums.HitType
const GameParam = Enums.GameParam

signal start

signal stop

signal note_hit(hit_type: HitType)

signal update_game_param(param: GameParam, value)

signal change_ui_scene(path: String)
