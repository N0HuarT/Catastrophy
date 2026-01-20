extends RefCounted
class_name GameSettingsVideo
var fullscreen := true
var resolution := Vector2i(1920, 1080)

func load_from_cfg(cfg: ConfigFile):
	fullscreen = cfg.get_value("video", "fullscreen", fullscreen)
	resolution = cfg.get_value("video", "resolution", resolution)

func save_to_cfg(cfg: ConfigFile):
	cfg.set_value("video", "fullscreen", fullscreen)
	cfg.set_value("video", "resolution", resolution)
