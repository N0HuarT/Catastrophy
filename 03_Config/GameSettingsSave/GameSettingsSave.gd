extends Resource

var audio := GameSettingsAudio.new()
var input := GameSettingsInput.new()
var video := GameSettingsVideo.new()

const PATH := "user://settings.cfg"

func load():
	var cfg := ConfigFile.new()
	if cfg.load(PATH) == OK:
		video.load_from_cfg(cfg)
		audio.load_from_cfg(cfg)
		input.load_from_cfg(cfg)

func save():
	var cfg := ConfigFile.new()
	video.save_to_cfg(cfg)
	audio.save_to_cfg(cfg)
	input.save_to_cfg(cfg)
	cfg.save(PATH)
