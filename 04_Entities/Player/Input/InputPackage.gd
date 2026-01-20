# InputPackage.gd
extends Resource
class_name InputPackage
enum ActionState { TAP, HOLD, RELEASE }

var actions:= {} #name of the action eg: attack,utility,reload,spell1
var input_direction: Vector2 = Vector2.ZERO #keyboard Control
var look_delta: Vector2 = Vector2.ZERO #(mouse/controller) for rotation
